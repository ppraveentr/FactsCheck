//
//  FactsViewControllerTests.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

@testable import FactsCheck
import XCTest

class FactsViewControllerTests: XCTestCase {
    private var sut: FactsViewController!
    private var seviceMock: FactsServiceProtocolMock!

    override func setUp() {
        super.setUp()
        seviceMock = FactsServiceProtocolMock()
        sut = FactsViewController()
        sut.viewModel.factsService = seviceMock
    }
    
    func testViewTitle() {
        // let
        let title = seviceMock.mockFactDetails?.title
        // when
        sut.viewModel.refeshViewDetails()
        // then
        XCTAssertEqual(sut.title, title)
    }
    
    func testEmbededView() {
        // let
        let childVC = sut.viewModel.contentView
        // when
        sut.viewDidLoad()
        // then
        XCTAssertTrue(sut.children.contains(childVC))
        XCTAssertTrue(sut.view.subviews.contains(childVC.view))
    }
}
