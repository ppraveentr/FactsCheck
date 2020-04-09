//
//  FactsTableViewCellTests.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

@testable import FactsCheck
import XCTest

class FactsTableViewCellTests: XCTestCase {
    private var sut: FactsTableViewCell!
    
    override func setUp() {
        super.setUp()
        sut = FactsTableViewCell(style: .default, reuseIdentifier: "")
    }
    
    func testCellSetup() {
        // let
        let mock = FactDetailsMock.mockFact()
        // when
        sut.setup(viewModel: mock)
        
        // Title
        let title = findLabel(title: mock.title, in: sut.contentView)
        // then
        XCTAssertNotNil(title)
        
        // Title
        let desc = findLabel(title: mock.description, in: sut.contentView)
        // then
        XCTAssertNotNil(desc)
    }
}

private extension FactsTableViewCellTests {
    func findLabel(title: String?, in view: UIView) -> UILabel? {
        guard let title = title else { return nil }
        
        let label = view.subviews.first { ($0 as? UILabel)?.text == title } as? UILabel
        return label
    }
}
