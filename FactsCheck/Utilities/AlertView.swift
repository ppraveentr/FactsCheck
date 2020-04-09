//
//  AlertView.swift
//  FactsCheck
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

/// Class helps to show Alerts
final class AlertView {
    static var shared = AlertView()
    
    // MARK: - Interface Methods
    func showAlert(error: Error) {
        showAlert(message: error.localizedDescription)
    }
    
    func showAlert(title: String? = nil, message: String? = nil, buttonTitle: String = NSLocalizedString("OK", comment: "OK")) {
        let alertAction = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
        showAlert(title: title, message: message, actions: [alertAction])
    }
    
    // swiftlint:disable:next cyclomatic_complexity
    func showAlert(title: String? = nil, message: String? = nil, actions: [UIAlertAction]? = nil, presenter: UIViewController? = UIWindow.topViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions?.forEach { alertController.addAction($0) }
        
        guard let topViewController = presenter else { return }
        topViewController.present(alertController, animated: true)
    }
}

