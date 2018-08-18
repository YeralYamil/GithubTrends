//
//  GithubServiceTests.swift
//  GithubTrendsTests
//
//  Created by Yeral Yamil on 8/18/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import XCTest
import ReactiveSwift
import Result
@testable import GithubTrends

class GithubServiceTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchProjects_ReturnsJsonErrorWhenJsonIsNotValid() {
        
        //Given
        let sut = GithubService()
        let signalPipe = Signal<String, NoError>.pipe()
        let expectation = XCTestExpectation(description: "jsonErrorExpectation")
        
        //When
        let _ = sut.searchProjects(searchTermSignal: signalPipe.output, dataRequester:IncorrectJsonDataProvidingMock()).observe { (event) in
            guard let error = event.value?.1 else { return }
            if (error == ServiceError.jsonParsingError) {
                expectation.fulfill()
            }
        }
        
        signalPipe.input.send(value: "Swift")

        //Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchProjects_ReturnsCorrectValuesWhenJsonIsCorrect() {
        
        //Given
        let sut = GithubService()
        let signalPipe = Signal<String, NoError>.pipe()
        let expectation = XCTestExpectation(description: "valueExpectation")
        
        //When
        let _ = sut.searchProjects(searchTermSignal: signalPipe.output, dataRequester:CorrectJsonDataProvidingMock()).observe { (event) in
            guard let projects = event.value?.0 else { return }
            if (projects.count == 2) {
                expectation.fulfill()
            }
        }
        
        signalPipe.input.send(value: "Swift")
        
        //Then
        wait(for: [expectation], timeout: 1)
    }
    
}

//MARK: Mocks

struct IncorrectJsonDataProvidingMock: DataRequesting {
    func data(with request: URLRequest) -> ReactiveSwift.SignalProducer<(Data, URLResponse), AnyError> {
        let data = Data(capacity: 0)
        guard let url = URL(string: "www.testurl.com") else { XCTFail("URL cannot be nil"); exit(0) }
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        
        let signalProducer: SignalProducer<(Data, URLResponse), AnyError> =
            SignalProducer<(Data, URLResponse), AnyError> { (observer: Signal<(Data, URLResponse), AnyError>.Observer, lifetime: Lifetime) in
                
                observer.send(value: (data, urlResponse))
        }
        
        return signalProducer
    }
}

struct CorrectJsonDataProvidingMock: DataRequesting {
    func data(with request: URLRequest) -> ReactiveSwift.SignalProducer<(Data, URLResponse), AnyError> {
        
        guard let url = R.file.githubProjectsSampleJson() else { XCTFail("URL cannot be nil"); exit(0) }
        guard let data = try? Data.init(contentsOf: url) else { XCTFail("Contents of json file cannotbe nil "); exit(0) }
        
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        
        let signalProducer: SignalProducer<(Data, URLResponse), AnyError> =
            SignalProducer<(Data, URLResponse), AnyError> { (observer: Signal<(Data, URLResponse), AnyError>.Observer, lifetime: Lifetime) in
                
                observer.send(value: (data, urlResponse))
        }
        
        return signalProducer
    }
}
