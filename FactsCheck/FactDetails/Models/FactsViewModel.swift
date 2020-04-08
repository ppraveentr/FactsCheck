//
//  FactsViewModel.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

protocol FactsViewModelProtocol: NSObject {
}

protocol FactsTableViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func data(atIndexPath indexPath: IndexPath) -> Fact?
}

final class FactsViewModel {
    
    //Facts List tableView
    private(set) weak var delegate: FactsViewModelProtocol?
    private(set) lazy var factsTableView = FactsTableView(self)

    //factDetails hold's the data from the backend
    var factDetails: FactDetails? {
        didSet {
            factsTableView.refreshView()
        }
    }
    
    init(_ delegate: FactsViewModelProtocol) {
        self.delegate = delegate
    }
    
    func setupModel() {
        //Fetch Fact details from backend
        self.refreshFacts()
    }
}

extension FactsViewModel: FactsTableViewModelProtocol {
    func numberOfRowsInSection() -> Int {
        return factDetails?.facts?.count ?? 0
    }
    
    func data(atIndexPath indexPath: IndexPath) -> Fact? {
        return factDetails?.facts?[indexPath.row]
    }
}

extension FactsViewModel {
    //API call to fetch the Facts
    func refreshFacts(completion: (() -> Void)? = nil) {
        FactsService.fetchFactsList { [weak self] factsData, error in
            //assign to local facts array to our returned model to refresh View
            self?.factDetails = factsData
        }
    }
}
