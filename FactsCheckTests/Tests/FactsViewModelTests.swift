//
//  FactsViewModelTests.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

@testable import FactsCheck
import XCTest

final class FactsViewModelTests: XCTestCase {
    private var delegateMock: FactsViewDelegateMock!
    private var sut: FactsViewModel!
    private var serviceMock: FactsServiceProtocolMock!
    
    override func setUp() {
        super.setUp()
        delegateMock = FactsViewDelegateMock()
        serviceMock = FactsServiceProtocolMock()

        sut = FactsViewModel(delegateMock)
        sut.factsService = serviceMock
    }
    
    func testModelSetup() {
        // then
        XCTAssertEqual(sut.delegate, delegateMock)
    }
    
    func testModelViewingTitle() {
        // let
        let mockDetails = serviceMock.mockFactDetails
        // when
        sut.refeshViewDetails()
        // then
        XCTAssertEqual(sut.title(), mockDetails?.title)
    }
    
    func testNumberOfRows() {
        // let
        let mockDetails = serviceMock.mockFactDetails
        // when
        sut.refeshViewDetails()
        // then
        XCTAssertEqual(sut.numberOfRowsInSection(), mockDetails?.facts?.count)
    }
    
    func testDataAtIndexPath() {
        // let
        let mockDetails = serviceMock.mockFactDetails
        let indexPath = IndexPath(row: 0, section: 0)
        let mockFact = mockDetails?.facts?.first
        // when
        sut.refeshViewDetails()
        // then
        let fact = sut.data(forIndexPath: indexPath)
        XCTAssertNotNil(fact)
        XCTAssertEqual(fact, mockFact)
    }
    
    // MAKR: Network API
    func testRefeshViewDetails() {
        // when
        sut.refeshViewDetails()
        // then
        XCTAssertTrue(serviceMock.fetchFactsListCalled)
    }
    
    func testRefeshViewDetailsFails() {
        // let
        serviceMock.mockFactDetails = nil
        // when
        sut.refeshViewDetails()
        // then
        XCTAssertTrue(delegateMock.showAlertCalled)
    }
}
