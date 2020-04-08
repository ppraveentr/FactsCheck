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
        if edge.contains(.top) {
            superview.topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top).isActive = true
        }
        if edge.contains(.left) {
            superview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left).isActive = true
        }
        if edge.contains(.bottom) {
            superview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: edgeInsets.bottom).isActive = true
        }
        if edge.contains(.right) {
            superview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: edgeInsets.right).isActive = true
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
