//
//  UIView+Constraints.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

extension UIView {
    
    struct Edges: OptionSet {
        let rawValue: Int
        static let left = Edges(rawValue: 1 << 0)
        static let top = Edges(rawValue: 1 << 1)
        static let right = Edges(rawValue: 1 << 2)
        static let bottom = Edges(rawValue: 1 << 3)
        
        static let vertical: Edges = [.top, .bottom]
        static let horizontal: Edges = [.left, .right]
        static let all: Edges = [.left, .top, .right, .bottom]
    }
    
    /**
     Example: contentView.pinView([.horizontal, .top], edgeInsets: UIEdgeInsetsMake(15, 15, -15, -15))
     */
    func pinView(_ edge: Edges = .all, edgeInsets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            return
        }
         translatesAutoresizingMaskIntoConstraints = false
        if edge.contains(.top) {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: edgeInsets.top).isActive = true
        }
        if edge.contains(.left) {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: edgeInsets.left).isActive = true
        }
        if edge.contains(.bottom) {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: edgeInsets.bottom).isActive = true
        }
        if edge.contains(.right) {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: edgeInsets.right).isActive = true
        }
    
        setNeedsLayout()
    }
    
    func anchor(constraints: [String], viewsDict: [String: UIView]) {
        viewsDict.forEach { _, view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        constraints.forEach { co in
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: co, options: [], metrics: nil, views: viewsDict))
        }
        
        setNeedsLayout()
    }
}

extension UIView {
    func embedView(_ view: UIView, edge: Edges = .all, edgeInsets: UIEdgeInsets = .zero) {
        // check if view already exits, if not add it.
        guard !self.subviews.contains(view) else { return }
        // add as subview
        self.addSubview(view)
        // pin the view to edges
        view.pinView(edge, edgeInsets: edgeInsets)
    }
}

extension UIViewController {
    static func navigationController() -> UINavigationController {
        let viewController = self.init()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func embedController(_ child: UIViewController, completion: (_ view: UIView) -> Void) {
        self.addChild(child)
        completion(child.view)
    }
}
