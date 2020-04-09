//
//  FactsViewModel.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

// MARK: Protocols
// FactsViewContoller: delegate protocol
protocol FactsViewDelegate: NSObject {
    func refreshTitle()
    func showAlert(message: String)
}

// tableView: dataSource Protocol
protocol FactsTableViewModelProtocol: AnyObject {
    func numberOfRowsInSection() -> Int
    func data(forIndexPath indexPath: IndexPath) -> Fact?
    func getFactDetails()
}

// FactsViewContoller: viewModel protocol
protocol FactsViewModelViewing {
    func title() -> String
    func getFactDetails()
}

// MARK: ViewModel
final class FactsViewModel: FactsViewModelViewing {
    
    //Facts contoller delegate
    private(set) unowned var delegate: FactsViewDelegate?
    // Facts List content view
    private(set) lazy var contentView: FactsTableViewProtocol = {
        FactsTableView(self)
    }()

    //factDetails hold's the data from the backend and refresh view on update.
    private(set) var factDetails: FactDetails? {
        didSet {
            refreshViewOnUpdate()
        }
    }
    
    init(_ delegate: FactsViewDelegate) {
        self.delegate = delegate
    }
    
    func refeshViewDetails() {
        //Fetch Fact details from backend
        self.getFactDetails()
    }
}

// MARK: FactsViewModelViewing
extension FactsViewModel {
    // Update view's title
    func title() -> String {
        return factDetails?.title ?? ""
    }
    
    // refesh ViewContoller's data
    private func refreshViewOnUpdate() {
        // refresh tableView content
        contentView.refreshContent()
        // update view's title
        delegate?.refreshTitle()
    }
}

// MARK: FactsTableViewModelProtocol
extension FactsViewModel: FactsTableViewModelProtocol {
    // no of facts to show
    func numberOfRowsInSection() -> Int {
        return factDetails?.facts?.count ?? 0
    }
    
    // fact data for the cell
    func data(forIndexPath indexPath: IndexPath) -> Fact? {
        return factDetails?.facts?[indexPath.row]
    }
}

// MARK: Service Get Fact Details
extension FactsViewModel {
    //API call to fetch the Facts
    func getFactDetails() {
        //Show spinner while fetching content from Backend
        ActivityIndicator.start()
        FactsService.fetchFactsList { [weak self] factsData, error in
            // Hide spinner
            ActivityIndicator.stop()
            guard factsData != nil else {
                self?.delegate?.showAlert(message: kSeviceErrorMessage.localized)
                return
            }
            //assign to local facts array to our returned model to refresh View
            self?.factDetails = factsData
        }
    }
}
