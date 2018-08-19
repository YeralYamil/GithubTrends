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
    
    var sut: GithubService!
    
    override func setUp() {
        super.setUp()
        sut = GithubService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchProjects_ReturnsJsonErrorWhenJsonIsNotValid() {
        
        //Given
        let signalPipe = Signal<String, NoError>.pipe()
        let expectation = XCTestExpectation(description: "jsonErrorExpectation")
        let dataRequester = DataProvidingMock(jsonData: Data(capacity: 0))
        
        //When
        let _ = sut.searchProjects(searchTermSignal: signalPipe.output, dataRequester: dataRequester).observe { (event) in
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
        let signalPipe = Signal<String, NoError>.pipe()
        let expectation = XCTestExpectation(description: "valueExpectation")
        guard let jsonFileUrl = R.file.githubProjectsSampleJson() else { XCTFail("URL cannot be nil"); return }
        guard let jsonData = try? Data(contentsOf: jsonFileUrl) else { XCTFail("JSON file data cannot be nil"); return }
        let dataRequester = DataProvidingMock(jsonData: jsonData)
        
        //When
        let _ = sut.searchProjects(searchTermSignal: signalPipe.output, dataRequester:dataRequester).observe { (event) in
            guard let projects = event.value?.0 else { return }
            if (projects.count == 2) {
                expectation.fulfill()
            }
        }
        
        signalPipe.input.send(value: "Swift")
        
        //Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchProjects_ReturnsCustomErrorWhenJsonContainsMessage() {
        
        //Given
        let signalPipe = Signal<String, NoError>.pipe()
        let expectation = XCTestExpectation(description: "valueExpectation")
        
        let errorMessage = "Error message"
        let jsonString = "{\"message\":\"\(errorMessage)\"}"
        guard let jsonData = jsonString.data(using: .utf8) else { XCTFail("JSON data cannot be nil"); return }
        let dataRequester = DataProvidingMock(jsonData: jsonData)
        
        //When
        let _ = sut.searchProjects(searchTermSignal: signalPipe.output, dataRequester:dataRequester).observe { (event) in
            guard let error = event.value?.1 else { return }
            if (error == ServiceError.custom(errorMessage)) {
                expectation.fulfill()
            }
        }
        
        signalPipe.input.send(value: "Swift")
        
        //Then
        wait(for: [expectation], timeout: 1)
    }
    
}

//MARK: Mocks
struct DataProvidingMock: DataRequesting {
    
    let jsonData: Data
    
    func data(with request: URLRequest) -> ReactiveSwift.SignalProducer<(Data, URLResponse), AnyError> {
        
        guard let url = URL(string: "www.testurl.com") else { XCTFail("URL cannot be nil"); exit(0) }
        let data = jsonData
        
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        
        let signalProducer: SignalProducer<(Data, URLResponse), AnyError> =
            SignalProducer<(Data, URLResponse), AnyError> { (observer: Signal<(Data, URLResponse), AnyError>.Observer, lifetime: Lifetime) in
                
                observer.send(value: (data, urlResponse))
        }
        
        return signalProducer
    }
}
