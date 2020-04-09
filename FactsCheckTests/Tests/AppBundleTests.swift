//
//  AppBundleTests.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

@testable import FactsCheck
import XCTest

final class AppBundleTests: XCTestCase {
    
    func testLocalized() {
        let message = "Something's Not Right"
        let title = "ServiceErrorTitle"
        XCTAssertEqual(title.localized, message)
    }
    
    func testLocalizedFails() {
        let title = "dummy"
        XCTAssertEqual(title.localized, title)
    }
}
