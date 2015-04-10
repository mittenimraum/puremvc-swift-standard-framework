//
//  ApplicationMediator.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 06.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation
import UIKit

class ApplicationMediator : Mediator, IMediator, UISplitViewControllerDelegate
{
    
    override class func NAME () -> String
    {
        return "ApplicationMediator"
    }
    
    var controller : UISplitViewController
    {
        get
        {
            return self.viewComponent as! UISplitViewController
        }
    }
    
    override func initializeMediator()
    {
        
        let splitViewController = viewComponent as! UISplitViewController
        splitViewController.delegate = self
        
        let navigationController = splitViewController.viewControllers[ splitViewController.viewControllers.count - 1 ] as! UINavigationController
        navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        
    }
    
    override func listNotificationInterests() -> Array<String>
    {
        return []
    }
    
    override func handleNotification( notification: INotification )
    {
        
    }
    
    // MARK: - Split view
    
    func splitViewController( splitViewController: UISplitViewController,
                              collapseSecondaryViewController secondaryViewController: UIViewController!,
                              ontoPrimaryViewController primaryViewController: UIViewController! ) -> Bool
    {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController
        {
            if let topAsDetailController = secondaryAsNavController.topViewController as? RecordsDetailController
            {
                if topAsDetailController.record == nil
                {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }
    
    func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool
    {
        return false
    }
    
}