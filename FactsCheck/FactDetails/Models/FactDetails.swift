//
//  FactDetails.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

struct FactDetails: Codable {
    var title: String?
    var facts: [Fact]?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case facts = "rows"
    }
}

extension FactDetails: Equatable {
    mutating func trimInvalidFacts() {
        facts = facts?.filter { $0.isValid }
    }
}

struct Fact: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}

extension Fact: Equatable {
    var isValid: Bool {
        return title != nil || description != nil || imageHref != nil
    }
}
