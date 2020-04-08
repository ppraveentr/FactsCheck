//
//  FactsTableViewCell.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

class FactsTableViewCell: UITableViewCell {
    static let kFactsCellIdentifier = "FactsTableViewCell"

    var model: Fact?
    
    func configureContent(model: Fact) {
        self.model = model
        self.textLabel?.text = model.title
    }
}
