//
//  ProjectViewModelTests.swift
//  GithubTrendsTests
//
//  Created by Yeral Yamil on 8/18/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import XCTest
import ReactiveSwift
import ReactiveCocoa
import Result
@testable import GithubTrends

class ProjectViewModelTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOutput_ReturnsCorrectValues() {
        //Given
        let name = "TestProject"
        let project = makeProject(name: name, description: nil, starsCount: 10)
        let sut = ProjectViewModel(project: project)
        
        //When
        let output = sut.output
        
        //Then
        XCTAssertEqual(output.name.value, name)
        XCTAssertTrue(output.description.value == nil)
        XCTAssertEqual(output.starsCount.value, "10")
        
    }
    
    private func makeProject(name: String, description: String?, starsCount: Int) -> Project {
        let owner = Owner(avatarUrl: nil, login: nil)
        let project = Project(name: name, description: description, forks: 0, stargazersCount: starsCount, watchersCount: 0, owner: owner)
        
        return project
    }
    
}
