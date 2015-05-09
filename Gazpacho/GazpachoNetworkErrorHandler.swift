//
//  GazpachoNetworkErrorHandler.swift
//  Gazpacho
//
//  Created by Francisco de la Pena on 5/8/15.
//  Copyright (c) 2015 Twister Labs, LLC. All rights reserved.
//

import UIKit

class GazpachoNetworkErrorHandler {
    
    class func displayErrorMessage (currentViewController: UINavigationController, displayMessage: Bool) {
        
        if displayMessage && (currentViewController.view.viewWithTag(7777) == nil) {
            
            var originNavBar = currentViewController.navigationBar.frame.origin
            var heightNavBar = currentViewController.navigationBar.frame.size.height
            var originErrorMessage = CGPoint(x: 0, y: 64)
            var sizeErrorMesage = CGSize(width: currentViewController.view.frame.width, height: 40)
            var errorMessage = UIView(frame: CGRect(origin: originErrorMessage, size: sizeErrorMesage))
            errorMessage.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
            errorMessage.tag = 7777
            var warningIconView = UIImageView(image: UIImage(named: "AlertMessage_white")!)
            warningIconView.center = CGPoint(x: currentViewController.view.frame.width / 2, y: 20)
            errorMessage.addSubview(warningIconView)
            currentViewController.view.addSubview(errorMessage)
            
        } else if !displayMessage {
        
            currentViewController.view.viewWithTag(7777)?.removeFromSuperview()
            
        }
    }
}