//
//  FactsTableView.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

protocol FactsTableViewProtocol: UIViewController {
    func refreshContent()
}

final class FactsTableView: UITableViewController {
    
    // dataSource Model
    private unowned var dataSourceModel: FactsTableViewModelProtocol
    
    init(_ source: FactsTableViewModelProtocol) {
        dataSourceModel = source
        super.init(style: .grouped)
        // configure tableView
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FactsTableViewCell = FactsTableViewCell.dequeue(from: tableView, for: indexPath)
        
        if let fact = dataSourceModel.data(forIndexPath: indexPath) {
            cell.setup(viewModel: fact)
        }
        
        return cell
    }
}

extension FactsTableView: FactsTableViewProtocol {
    func refreshContent() {
        // end refreshing and update tableView
        self.refreshControl?.endRefreshing()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // Pull to refesh fact details.
    func setupPullToRefesh() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "refresh")
        refreshControl?.addTarget(self, action: #selector(pullToRefesh), for: UIControl.Event.valueChanged)
    }
    
    @objc func pullToRefesh(_ sender: AnyObject) {
        // fetch latest details to refresh table view
        DispatchQueue.main.async {
            self.dataSourceModel.getFactDetails()
        }
    }
}

private extension FactsTableView {
    enum Constants {
        static let estimatedRowHeight: CGFloat = 71.0
    }
    
    private func configureView() {
        // set height for rows
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        // Cell class register
        FactsTableViewCell.registerClass(for: self.tableView)
        setupPullToRefesh()
    }
}
