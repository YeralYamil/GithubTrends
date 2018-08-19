//
//  URLRequest.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/19/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static func create(fromString: String) -> URLRequest? {
        guard let url = URL(string: fromString) else { return nil }
        return URLRequest(url: url)
    }
    
}
