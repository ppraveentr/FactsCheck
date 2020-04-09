//
//  NetworkManagerTests.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

@testable import FactsCheck
import XCTest

final class NetworkManagerTests: XCTestCase {

    private var sut: NetworkManagerProtocol!
    private var path: String!
    
    private var mockFileURL: URL? {
        XCTAssertNotNil(path)
        return URL(fileURLWithPath: path)
    }
    
    override func setUp() {
        super.setUp()
        sut = NetworkManager.shared
    }
    
    func testMakeService() {
        //let
        path = Bundle.testCaseModule.path(forResource: "Mockfacts", ofType: "json")
        let promise = expectation(description: "Status code: 200")
        guard let url = mockFileURL else {
            XCTFail("mockFileURL fails")
            return 
        }
        
        // when
        sut.makeService(url: url, responseType: FactDetails.self) { result in
            // then
            XCTAssertNotNil(result)
            let responseType = try? result.get() as? FactDetails
            XCTAssertNotNil(responseType)
            promise.fulfill()
        }
        
        //Timeout: '5'
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: Image
    func testDownloadedImage() {
        //let
        path = Bundle.testCaseModule.path(forResource: "mockImage", ofType: "png")
        let promise = expectation(description: "Status code: 200")
        guard let url = mockFileURL else {
            XCTFail("mockFileURL fails")
            return
        }
        // when
        sut.downloadedImage(url: url, allowCache: true) { image in
            // then
            XCTAssertNotNil(image)
            promise.fulfill()
        }
        //Timeout: '5'
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadedImageFails() {
        //let
        path = Bundle.testCaseModule.path(forResource: "Mockfacts", ofType: "json")
        let promise = expectation(description: "Status code: 200")
        guard let url = mockFileURL else {
            XCTFail("mockFileURL fails")
            return
        }
        // when
        sut.downloadedImage(url: url, allowCache: true) { image in
            // then
            XCTAssertNil(image)
            promise.fulfill()
        }
        //Timeout: '5'
        waitForExpectations(timeout: 5, handler: nil)
    }
}
