//
//  ActivityIndicator.swift
//  FactsCheck
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen Prabhakar. All rights reserved.
//

import UIKit

fileprivate final class ActivityIndicatorView: UIActivityIndicatorView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Always bring to front of view
        if let window = UIApplication.shared.delegate?.window {
            window?.bringSubviewToFront(self)
        }
    }
}

final class ActivityIndicator {
    //Static single Spinner
    private static var spinnerView: ActivityIndicatorView?
    
    //White color spinner
    static var style: UIActivityIndicatorView.Style = .white
    
    //Black color bg, with .6 alpha
    static var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.6)
    
    //Handler when spinner is loading
    private static var touchHandler: (() -> Void)?
    
    static func spin(style: UIActivityIndicatorView.Style = style, backgroundColor: UIColor = backgroundColor, touchHandler: (() -> Void)? = nil) {
        
        //Remove exising spinner
        spinnerView?.removeFromSuperview()
        
        //Creare new spinner if nil
        if spinnerView == nil {
            //Size of the main screen
            let frame = UIScreen.main.bounds
            spinnerView = ActivityIndicatorView(frame: frame)
            
            spinnerView?.backgroundColor = backgroundColor
            spinnerView?.style = style
            //To expand to entier window
            spinnerView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        
        guard let spinnerView = spinnerView else {
           return
        }
        
        let window = UIApplication.shared.windows.first
        //Add spinner to mainWindow
        window?.addSubview(spinnerView)
        //Start Animating
        spinnerView.startAnimating()
        
        //Setup gesture, if user sends any touch-handler
        if touchHandler != nil {
            self.touchHandler = touchHandler
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runTouchHandler))
            spinnerView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    //Invoke touch-handler
    @objc internal static func runTouchHandler() {
        if touchHandler != nil {
            touchHandler!()
        }
    }
    
    //Start spinner
    static func start() {
        ActivityIndicator.spin(style: .whiteLarge)
    }
    
    //Stop spinner
    static func stop() {
        //if available, stop and remove from superView, make it nill
        if let _ = spinnerView {
            spinnerView!.stopAnimating()
            spinnerView!.removeFromSuperview()
            spinnerView = nil
        }
    }
}
