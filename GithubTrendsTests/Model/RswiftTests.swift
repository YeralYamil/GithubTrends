//
//  RswiftTests.swift
//  GithubTrendsTests
//
//  Created by Yeral Yamil on 8/18/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import XCTest
@testable import GithubTrends

class RswiftTests: XCTestCase {
    
    func testRValidate_DoesNotThrow() {
        XCTAssertNoThrow(try R.validate())
    }
    
}
