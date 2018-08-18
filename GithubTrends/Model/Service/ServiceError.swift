//
//  ServiceError.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/16/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case noInternetConnection
    case serverError
    case jsonParsingError
    case custom(String)
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return R.string.localizable.noInternetConnectionPleaseTryAgainLater()
        case .serverError:
            return R.string.localizable.thereWasAServerErrorPleaseTryAgainLater()
        case .jsonParsingError:
            return R.string.localizable.errorParsingJSON()
        case .custom(let message):
            return message
        }
    }
}

extension ServiceError: Equatable {
    static public func ==(lhs: ServiceError, rhs: ServiceError) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}
