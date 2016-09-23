//
//  INotifier.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

/** 
 * The interface definition for a PureMVC Notifier.
 *
 * <P>
 * <code>MacroCommand, Command, Mediator</code> and <code>Proxy</code>
 * all have a need to send <code>Notifications</code>. </P>
 *
 * <P>
 * The <code>INotifier</code> interface provides a common method called
 * <code>sendNotification</code> that relieves implementation code of
 * the necessity to actually construct <code>Notifications</code>.</P>
 *
 * <P>
 * The <code>Notifier</code> class, which all of the above mentioned classes
 * extend, also provides an initialized reference to the <code>Facade</code>
 * Singleton, which is required for the convienience method
 * for sending <code>Notifications</code>, but also eases implementation as these
 * classes have frequent <code>Facade</code> interactions and usually require
 * access to the facade anyway.</P>
 *
 * @see IFacade, INotification
 */

protocol INotifier {

    /** 
     * Send a <code>INotification</code>.
     *
     * <P>
     * Convenience method to prevent having to construct new
     * notification instances in our implementation code.</P>
     *
     * @param notificationName the name of the notification to send
     * @param body the body of the notification
     * @param type the type of the notification
     */
    func sendNotification(notificationName: String)
    func sendNotification(notificationName: String, body: AnyObject)
    func sendNotification(notificationName: String, body: AnyObject, type: String)
    func sendNotification(notificationName: String, type: String)
}
