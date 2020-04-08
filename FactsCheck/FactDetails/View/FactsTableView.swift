//
//  FactsTableView.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

final class FactsTableView: UITableViewController {
    
    private var factDetails: FactDetails?
    
    func refreshView(model: FactDetails?) {
        factDetails = model
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
        return factDetails?.facts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kNovelCellIdentifier", for: indexPath)
        
        if
            let cell = cell as? FactsTableViewCell,
            let fact = factDetails?.facts?[indexPath.row] {
            cell.configureContent(model: fact)
        }
        
        return cell
    }
}
