//
//  Observer.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

/**
* A base <code>IObserver</code> implementation.
*
* <P>
* An <code>Observer</code> is an object that encapsulates information
* about an interested object with a method that should
* be called when a particular <code>INotification</code> is broadcast. </P>
*
* <P>
* In PureMVC, the <code>Observer</code> class assumes these responsibilities:
* <UL>
* <LI>Encapsulate the notification (callback) method of the interested object.</LI>
* <LI>Encapsulate the notification context (this) of the interested object.</LI>
* <LI>Provide methods for setting the notification method and context.</LI>
* <LI>Provide a method for notifying the interested object.</LI>
* </UL>
*
* @see View, Notification
*/

class Observer : IObserver
{
    
    var notifyMethod : ( notification: INotification ) -> Void
    var notifyContext : AnyObject
    
    /**
    * Static Convienence Constructor.
    */
    class func withNotifyMethod( notifyMethod: ( notification: INotification ) -> Void , notifyContext: AnyObject ) -> Observer
    {
        return Observer( notifyMethod: notifyMethod , notifyContext: notifyContext )
    }
    
    /**
    * Constructor.
    *
    * <P>
    * The notification method on the interested object should take
    * one parameter of type <code>INotification</code></P>
    *
    * @param notifyMethod the notification method of the interested object
    * @param notifyContext the notification context of the interested object
    */
    init( notifyMethod: ( notification: INotification ) -> Void , notifyContext: AnyObject )
    {
        self.notifyMethod = notifyMethod;
        self.notifyContext = notifyContext;
    }
    
    /**
    * Compare an object to the notification context.
    *
    * @param object the object to compare
    * @return boolean indicating if the object and the notification context are the same
    */
    func compareNotifyContext( object: AnyObject ) -> Bool
    {
        return object.isEqual( notifyContext );
    }
    
    /**
    * Notify the interested object.
    *
    * @param notification the <code>INotification</code> to pass to the interested object's notification method.
    */
    func notifyObserver( notification: INotification )
    {
        self.notifyMethod( notification: notification )
    }
    
}
