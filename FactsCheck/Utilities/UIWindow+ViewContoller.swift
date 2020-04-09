//
//  UIWindow+RootViewContoller.swift
//  FactsCheck
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

extension UIWindow {
    /// Returns the current application's top most view controller.
    class var topViewController: UIViewController? {
        return UIApplication.shared.topMostViewController
    }
    
    func setupFactRootViewContoller() {
        let navigation = FactsViewBuilder.buildFactsViewContoller()
        rootViewController = navigation
        makeKeyAndVisible()
    }
}

extension UIApplication {
    var topMostViewController: UIViewController? {
        return keyWindow?.rootViewController?.topMostViewController
    }
}

extension UIViewController {
    /// Returns the top most view controller
    var topMostViewController: UIViewController {
        // presented view controller
        if let presented = presentedViewController {
            return presented.topMostViewController
        }
        
        // UITabBarController
        if let tab = self as? UITabBarController,
            let selectedViewController = tab.selectedViewController {
            return selectedViewController.topMostViewController
        }
        
        // UINavigationController
        if let navigationController = self as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return visibleViewController.topMostViewController
        }
        
        // UIPageController
        if let pageViewController = self as? UIPageViewController,
            let firstPageViewController = pageViewController.viewControllers?.first,
            pageViewController.viewControllers?.count == 1 {
            return firstPageViewController.topMostViewController
        }
        
        // child view controller
        if let subviews = view?.subviews {
            for subview in subviews {
                if let childViewController = subview.next as? UIViewController {
                    return childViewController.topMostViewController
                }
            }
        }
        
        return self
    }
}
