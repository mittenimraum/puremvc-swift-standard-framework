//
//  StartupCommand.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 03.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import UIKit

class StartupCommand : SimpleCommand
{
    
    override func execute(notification: INotification)
    {
        
        let root = notification.body as! UISplitViewController
        let overview = root.viewControllers[ 0 ] as! UINavigationController
        
        facade.registerProxy( RecordProxy( proxyName: RecordProxy.NAME()))
        
        facade.registerMediator( ApplicationMediator( mediatorName: ApplicationMediator.NAME() , viewComponent: root ))
        facade.registerMediator( OverviewMediator( mediatorName: OverviewMediator.NAME() , viewComponent: overview.topViewController ))
        
    }
    
}