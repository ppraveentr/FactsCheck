//
//  FactsBuilder.swift
//  FactsCheck
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

protocol FactsViewBuilding {
    static func buildFactsViewContoller() -> UINavigationController
}

final class FactsViewBuilder: FactsViewBuilding {
    static func buildFactsViewContoller() -> UINavigationController {
        return FactsViewController.navigationController()
    }
}
