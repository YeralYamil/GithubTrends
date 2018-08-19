//
//  GithubService.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/16/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol GithubServiceProtocol {
    func searchProjects(searchTermSignal: Signal<String, NoError>, dataRequester: DataRequesting) -> Signal<([Project]?, ServiceError?), AnyError>
}

extension GithubServiceProtocol {
    func searchProjects(searchTermSignal: Signal<String, NoError>) -> Signal<([Project]?, ServiceError?), AnyError> {
        return searchProjects(searchTermSignal: searchTermSignal, dataRequester: URLSession.shared.reactive)
    }
}

struct GithubService: GithubServiceProtocol {
    
    private let host = "https://api.github.com/search/repositories?"
    private let query = "q=%@&sort=stars&order=desc"
    private static let throttleInterval = 1.0
    
    func searchProjects(searchTermSignal: Signal<String, NoError>, dataRequester: DataRequesting = URLSession.shared.reactive) -> Signal<([Project]?, ServiceError?), AnyError> {
        
        let searchResult = searchTermSignal
            .map(makeSearchRequest)
            .skipNil()
            .throttle(GithubService.throttleInterval, on: QueueScheduler.main)
            .flatMap(FlattenStrategy.latest) { (urlRequest: URLRequest) -> SignalProducer<(Data, URLResponse), AnyError> in
                
                return dataRequester
                    .data(with: urlRequest)
                    
                    .flatMapError { error -> SignalProducer<(Data, URLResponse), AnyError> in
                        print("Network error occurred: \(error)")
                        return SignalProducer.empty
                }
                
            }
            .map(parseResponse)
        
        return searchResult
    }
    
    private func parseResponse(data: Data, response: URLResponse) -> ([Project]?, ServiceError?) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let githubResult = try? decoder.decode(GithubResult.self, from: data) else {
            return (nil, ServiceError.jsonParsingError)
        }
        if let message = githubResult.message {
            return (nil, ServiceError.custom(message))
        }
    
        return (githubResult.items, nil)
    }
    
    private func makeSearchRequest(_ searchTerm: String) -> URLRequest? {
        guard let encodedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        let queryString = String(format: query, encodedSearchTerm)
        let urlString = "\(host)\(queryString)"
        
        print(urlString)
        let urlRequest = URLRequest.create(fromString: urlString)
        return urlRequest
    }
}
