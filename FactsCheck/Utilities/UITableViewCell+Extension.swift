//
//  UITableViewCell+Extension.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var defaultReuseIdentifier: String {
        return "\(self)ID"
    }
    
    static func registerClass(for tableView: UITableView, reuseIdentifier: String? = nil) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier ?? defaultReuseIdentifier)
    }
    
    static func dequeue(from tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: defaultReuseIdentifier) else {
            fatalError("Unable to dequeue cell with reuse identifier '\(defaultReuseIdentifier)'")
        }
        return cell
    }
    
    static func dequeue<T: UITableViewCell>(from tableView: UITableView, for indexPath: IndexPath) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell of type \(T.self) with reuse identifier '\(defaultReuseIdentifier)'")
        }
        return cell
    }
}
