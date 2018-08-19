//
//  Project.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/17/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation

struct GithubResult: Codable {
    var items: [Project]?
    var message: String?
}

struct Project: Codable {
    
    var name: String?
    var description: String?
    var forks: Int
    var stargazersCount: Int?
    var watchersCount: Int?
    var owner: Owner
    
}

struct Owner: Codable {
    var avatarUrl: String?
    var login: String?
}
