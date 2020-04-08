//
//  ViewController.swift
//  FactsCheck
//
//  Created by Praveen P on 07/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

final class FactsViewController: UIViewController {

     //ViewModel for facts
    private(set) lazy var viewModel = FactsViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        viewModel.setupModel()
        
        // Embed tableView as container
        self.embedController(viewModel.contentView) { factView in
            self.view.embedView(factView)
        }
    }
}

extension FactsViewController: FactsViewDelegate {
    func refreshTitle() {
        // Update view's title
        self.title = viewModel.title()
    }
}
