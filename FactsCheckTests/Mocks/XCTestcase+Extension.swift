//
//  XCTestcase+Extension.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import Foundation

extension Bundle {
    class var testCaseModule: Bundle {
        return Bundle(for: UnitTestCase.self)
    }
}

final class UnitTestCase { }
