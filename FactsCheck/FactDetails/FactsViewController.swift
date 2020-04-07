//
//  ViewController.swift
//  FactsCheck
//
//  Created by Praveen P on 07/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

final class FactsViewController: UIViewController {

    let viewModel = FactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refreshFacts()
    }
}
