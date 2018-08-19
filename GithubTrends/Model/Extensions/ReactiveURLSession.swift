//
//  ReactiveURLSession.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/19/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

extension Reactive: DataRequesting where Base == URLSession {
    
    func data(urlString: String) -> ReactiveSwift.SignalProducer<Data?, AnyError> {
        
        guard let urlRequest = URLRequest.create(fromString: urlString) else { return SignalProducer.empty }
        
        return self
            .data(with: urlRequest)
            .map(dataResponseToData)
    }
    
    private func dataResponseToData(data: Data?, response: URLResponse) -> Data? {
        return data
    }
    
}
