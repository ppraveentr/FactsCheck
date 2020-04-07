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

struct Fact: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}
