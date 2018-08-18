//
//  DataRequesting.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/18/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol DataRequesting {
    func data(with request: URLRequest) -> ReactiveSwift.SignalProducer<(Data, URLResponse), AnyError>
}

extension Reactive: DataRequesting where Base == URLSession {
    
}
