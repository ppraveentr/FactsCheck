//
//  UIWindow+RootViewContoller.swift
//  FactsCheck
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

extension UIWindow {
    func setupFactRootViewContoller() {
        let navigation = FactsViewBuilder.buildFactsViewContoller()
        rootViewController = navigation
        makeKeyAndVisible()
    }
}
