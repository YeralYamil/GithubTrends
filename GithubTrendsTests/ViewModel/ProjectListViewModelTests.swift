//
//  ProjectListViewModelTests.swift
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

class ProjectListViewModelTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTransform_MapsProjectsToProjectViewModels() {
        
        //Given
        let projects = [makeProject(), makeProject(), makeProject()]
        let error: ServiceError? = nil
        let githubService = GithubServiceMock()
        let sut = ProjectListViewModel(service: githubService)
        let input = ProjectListViewModel.Input(searchText: Signal<String, NoError>.pipe().output)
        let expectation = XCTestExpectation(description: "mapExpectation")
        
        //When
        let output = sut.transform(input: input)
        
        //Then
        output.projects.observe { (event) in
            guard let value = event.value,
                let viewModels = value.0 else { return }
            if viewModels.count == 3 {
                expectation.fulfill()
            }
        }
        githubService.signalPipe.input.send(value: (projects, error))
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testTransform_ReportsError() {
        
        //Given
        let projects: [Project]? = nil
        let error: ServiceError = .jsonParsingError
        let githubService = GithubServiceMock()
        let sut = ProjectListViewModel(service: githubService)
        let input = ProjectListViewModel.Input(searchText: Signal<String, NoError>.pipe().output)
        let expectation = XCTestExpectation(description: "errorExpectation")
        
        //When
        let output = sut.transform(input: input)
        
        //Then
        output.projects.observe { (event) in
            guard let value = event.value,
                let serviceError = value.1 else { return }
            if serviceError == error {
                expectation.fulfill()
            }
        }
        githubService.signalPipe.input.send(value: (projects, error))
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    
    private func makeProject() -> Project {
        let owner = Owner(avatarUrl: nil, login: nil)
        let project = Project(name: nil, description: nil, forks: 0, stargazersCount: 0, watchersCount: 0, owner: owner)
        
        return project
    }
    
    struct GithubServiceMock: GithubServiceProtocol {
        func searchReadme(login: String, projectName: String, dataRequester: DataRequesting) -> SignalProducer<(Readme?, ServiceError?), AnyError> {
            return SignalProducer.empty
        }
        
        let signalPipe = Signal<([Project]?, ServiceError?), AnyError>.pipe()
        
        func searchProjects(searchTermSignal: Signal<String, NoError>, dataRequester: DataRequesting = URLSession.shared.reactive) -> Signal<([Project]?, ServiceError?), AnyError> {
            
            return signalPipe.output
        }
    }
    
}
