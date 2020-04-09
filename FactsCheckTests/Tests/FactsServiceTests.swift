//
//  FactsServiceTests.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

@testable import FactsCheck
import XCTest

final class FactsServiceTests: XCTestCase {
    
    private var path: String!
    private var sut: FactsService!
    private var mockNetworkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        path = Bundle.testCaseModule.path(forResource: "Mockfacts", ofType: "json")
        sut = FactsService.shared
    }
    
    private var mockFileURL: URL? {
        XCTAssertNotNil(path)
        return URL(fileURLWithPath: path)
    }
    
    // Asynchronous test: success fast, failure slow
    func testFetchFactsList() {
        let promise = expectation(description: "Status code: 200")
        
        let url = mockFileURL
        XCTAssertNotNil(url)
        
        sut.fetchFactsList(url: url) { (facts, error) in
            XCTAssertNil(error, "Error: \(String(describing: error?.localizedDescription))")
            XCTAssertNotNil(facts)
            promise.fulfill()
        }
        
        //Timeout: '5'
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchFactsListFails() {
        let promise = expectation(description: "Status code: 200")
        
        let url = URL(fileURLWithPath: "test")
        sut.fetchFactsList(url: url) { (facts, error) in
            XCTAssertNotNil(error)
            XCTAssertEqual(FactsError.serviceError, error)
            XCTAssertNil(facts)
            promise.fulfill()
        }
        
        //Timeout: '5'
        waitForExpectations(timeout: 5, handler: nil)
    }
}

