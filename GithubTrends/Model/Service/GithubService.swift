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
    func searchProjects(searchTermSignal: Signal<String, NoError>, dataRequester: DataRequesting) -> Signal<([GithubProject], ServiceError?), AnyError>
}

extension GithubServiceProtocol {
    func searchProjects(searchTermSignal: Signal<String, NoError>, dataRequester: DataRequesting = URLSession.shared.reactive) -> Signal<([GithubProject], ServiceError?), AnyError> {
        return searchProjects(searchTermSignal: searchTermSignal, dataRequester: dataRequester)
    }
}


struct GithubService: GithubServiceProtocol {
    
    private let host = "https://api.github.com/search/repositories?"
    private let query = "q=%@&sort=stars&order=desc"
    private static let numberOfRetries = 2
    
    func searchProjects(searchTermSignal: Signal<String, NoError>, dataRequester: DataRequesting) -> Signal<([GithubProject], ServiceError?), AnyError> {
        
        let searchResult = searchTermSignal.flatMap(FlattenStrategy.latest) { (searchTerm: String) -> SignalProducer<(Data, URLResponse), AnyError> in
            
            guard let request = self.makeSearchRequest(searchTerm: searchTerm) else { return SignalProducer.empty }
            let query = dataRequester
                .data(with: request)
                .retry(upTo: GithubService.numberOfRetries)
                .flatMapError { error -> SignalProducer<(Data, URLResponse), AnyError> in
                    print("Network error occurred: \(error)")
                    return SignalProducer.empty
                }
            
            return query
        }
        .map { (data, response) -> ([GithubProject], ServiceError?) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let githubResult = try? decoder.decode(GithubResult.self, from: data) else {
                return ([], ServiceError.jsonParsingError)
            }
            
            return (githubResult.items, nil)
        }
        
        return searchResult
    }
    
    private func makeSearchRequest(searchTerm: String) -> URLRequest? {
        
        guard let encodedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        let queryString = String(format: query, encodedSearchTerm)
        let urlString = "\(host)\(queryString)"
        
        guard let url = URL(string: urlString) else { return nil }
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
