//
//  Notification.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

/**
* A base <code>INotification</code> implementation.
*
* <P>
* PureMVC does not rely upon underlying event models such
* as the one provided with in AppKit or UIKit</P>
*
* <P>
* The Observer Pattern as implemented within PureMVC exists
* to support event-driven communication between the
* application and the actors of the MVC triad.</P>
*
* <P>
* Notifications are not meant to be a replacement for Events
* in AppKit or UIKit. Generally, <code>IMediator</code> implementors
* place event listeners on their view components, which they
* then handle in the usual way. This may lead to the broadcast of <code>Notification</code>s to
* trigger <code>ICommand</code>s or to communicate with other <code>IMediators</code>. <code>IProxy</code> and <code>ICommand</code>
* instances communicate with each other and <code>IMediator</code>s
* by broadcasting <code>INotification</code>s.</P>
*
* @see Observer
*
*/

class Notification : INotification
{
    
    var name : String?
    var type : String?
    var body : AnyObject?
    
    /**
    * Static Convienence Constructor.
    *
    * @param name name of the <code>Notification</code> instance.
    * @param body the <code>Notification</code> body.
    * @param type the type of the <code>Notification</code>
    */
    class func withName ( name: String , body: AnyObject? , type: String? ) -> Notification
    {
        return Notification( name: name , body: body , type: type );
    }
    
    class func withName ( name: String ) -> Notification
    {
        return Notification( name: name , body: nil , type: nil )
    }
    
    class func withName ( name: String , body: AnyObject? ) -> Notification
    {
        return Notification( name: name , body: body , type: nil )
    }
    
    class func withName ( name: String , type: String? ) -> Notification
    {
        return Notification( name: name , body: nil , type: type )
    }
    
    /**
    * Constructor.
    *
    * @param name name of the <code>Notification</code> instance.
    * @param body the <code>Notification</code> body.
    * @param type the type of the <code>Notification</code>
    */
    init ( name: String? , body: AnyObject? , type: String? )
    {
        self.name = name!;
        self.body = body;
        self.type = type;
    }
    
    /**
    * Get the string representation of the <code>Notification</code> instance.
    *
    * @return the string representation of the <code>Notification</code> instance.
    */
    func description () -> String
    {
        
        let str = String("Notification Name: \(self.name) \(self.body) \(self.type)" )
        
        return str
        
    }

    
}