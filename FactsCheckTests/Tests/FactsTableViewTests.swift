//
//  FactsTableViewTests.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

@testable import FactsCheck
import XCTest

class FactsTableViewTests: XCTestCase {
    private var sut: FactsTableView!
    private var modelMock: FactsTableViewModelProtocolMock!
    
    override func setUp() {
        super.setUp()
        modelMock = FactsTableViewModelProtocolMock()
        sut = FactsTableView(modelMock)
    }
    
    func testSetupView() {
        // when
        //sut.refreshContent()
        sut.tableView.reloadData()
        // then
        XCTAssertTrue(modelMock.numberOfRowsInSectionCalled)
    }
    
    func testPullToRefesh() {
        // let
        XCTAssertNotNil(sut.refreshControl)
        // when
        sut.refreshControl?.sendActions(for: .valueChanged)
        // then
        XCTAssertTrue(modelMock.getFactDetailsCalled)
    }
}
