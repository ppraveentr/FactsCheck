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
    
    private var mockFileURL: URL {
        XCTAssertNotNil(path)
        let url = URL(fileURLWithPath: path)
        if url.absoluteString.isEmpty {
            XCTFail("mockFileURL fails")
        }
        return url
    }
    
    override func setUp() {
        super.setUp()
        path = Bundle.testCaseModule.path(forResource: "Mockfacts", ofType: "json")
        sut = NetworkManager.shared
    }
    
    func testMakeService() {
        //let
        let promise = expectation(description: "FactDetails is nil")
        // when
        sut.makeService(url: mockFileURL, responseType: FactDetails.self) { result in
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
        let promise = expectation(description: "image is nil")
       // when
        sut.downloadedImage(url: mockFileURL, allowCache: true) { image in
            // then
            XCTAssertNotNil(image)
            promise.fulfill()
        }
        //Timeout: '5'
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadedImageFails() {
        //let
        let promise = expectation(description: "image download fails")
        // when
        sut.downloadedImage(url: mockFileURL, allowCache: true) { image in
            // then
            XCTAssertNil(image)
            promise.fulfill()
        }
        //Timeout: '5'
        waitForExpectations(timeout: 5, handler: nil)
    }
}
