//
//  AppBundle.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import Foundation

// Localized String
extension String {
    var localized: String {
        return getLocalizedValue() ?? self
    }
    
    private func getLocalizedValue(tableName: String? = nil) -> String? {
        let value = NSLocalizedString(self, tableName: tableName, bundle: Bundle.accountModule, comment: self)
        return value != self ? value : nil
    }
}

extension Bundle {
    class var accountModule: Bundle {
        return Bundle(for: AppBundle.self)
    }
}

// Class used to locate the module bundle
private final class AppBundle { }
