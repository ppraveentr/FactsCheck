//
//  FactsTableView.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

final class FactsTableView: UITableViewController {
    
    private var dataSourceModel: FactsTableViewModelProtocol
    
    init(_ source: FactsTableViewModelProtocol) {
        dataSourceModel = source
        super.init(style: .grouped)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        FactsTableViewCell.registerClass(for: self.tableView)
    }
    
    func refreshView() {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FactsTableViewCell = FactsTableViewCell.dequeue(from: tableView, for: indexPath)
        
        if let fact = dataSourceModel.data(atIndexPath: indexPath) {
            cell.configureContent(model: fact)
        }
        
        return cell
    }
}
