//
//  Mediator.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

/**
* A base <code>IMediator</code> implementation.
*
* @see View
*/

class Mediator : IMediator
{
    
    var name: String?
    var viewComponent: AnyObject?
    
    /**
    * The name of the <code>Mediator</code>.
    *
    * <P>
    * Typically, a <code>Mediator</code> will be written to serve
    * one specific control or group controls and so,
    * will not have a need to be dynamically named.</P>
    */
    class func NAME () -> String
    {
        return "Mediator"
    }
    
    class func mediator () -> Mediator
    {
        return Mediator( mediatorName: nil , viewComponent: nil )
    }
    
    class func withMediatorName ( mediatorName: String ) -> Mediator
    {
        return Mediator( mediatorName: mediatorName , viewComponent: nil )
    }
    
    class func withMediatorName ( mediatorName: String , viewComponent: AnyObject ) -> Mediator
    {
        return Mediator( mediatorName: mediatorName , viewComponent: viewComponent )
    }
    
    class func withViewComponent ( viewComponent: AnyObject ) -> Mediator
    {
        return Mediator( mediatorName: nil , viewComponent: viewComponent )
    }
    
    init( mediatorName: String? , viewComponent: AnyObject? )
    {
        
        self.name = mediatorName!;
        self.viewComponent = viewComponent!;
        
        self.initializeMediator()
        
    }
    
    /**
    * The instance of the Mediator.
    *
    * @return the <code>IMediator</code> instance
    */
    func context () -> AnyObject
    {
        return self
    }
    
    /**
    * Initialize the Mediator instance.
    *
    * <P>
    * Called automatically by the constructor, this
    * is your opportunity to initialize the Mediator
    * instance in your subclass without overriding the
    * constructor.</P>
    *
    * @return void
    */
    func initializeMediator ()
    {
    }
    
    /**
    * Handle <code>INotification</code>s.
    *
    * <P>
    * Typically this will be handled in a switch statement,
    * with one 'case' entry per <code>INotification</code>
    * the <code>Mediator</code> is interested in.
    */
    func handleNotification (notification: INotification )
    {
    }
    
    /**
    * List the <code>INotification</code> names this
    * <code>Mediator</code> is interested in being notified of.
    *
    * @return Array the list of <code>INotification</code> names
    */
    func listNotificationInterests () -> Array<String>
    {
        return Array<String>()
    }
    
    /**
    * Called by the View when the Mediator is registered
    */ 
    func onRegister ()
    {
    }
    
    /**
    * Called by the View when the Mediator is removed
    */ 
    func onRemove ()
    {
    }
    
}