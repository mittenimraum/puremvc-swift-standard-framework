//
//  IFacade.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

/** 
 * The interface definition for a PureMVC Facade.
 *
 * <P>
 * The Facade Pattern suggests providing a single
 * class to act as a central point of communication
 * for a subsystem. </P>
 *
 * <P>
 * In PureMVC, the Facade acts as an interface between
 * the core MVC actors (Model, View, Controller) and
 * the rest of your application.</P>
 *
 * @see IModel, IView, IController, ICommand, INotification
 */

protocol IFacade {

    /** 
     * Check if a Command is registered for a given Notification
     *
     * @param notificationName
     * @return whether a Command is currently registered for the given <code>notificationName</code>.
     */
    func hasCommand(notificationName: String) -> Bool

    /** 
     * Check if a Mediator is registered or not
     *
     * @param mediatorName
     * @return whether a Mediator is registered with the given <code>mediatorName</code>.
     */
    func hasMediator(mediatorName: String) -> Bool

    /** 
     * Check if a Proxy is registered
     *
     * @param proxyName
     * @return whether a Proxy is currently registered with the given <code>proxyName</code>.
     */
    func hasProxy(proxyName: String) -> Bool

    /** 
     * Notify the <code>IObservers</code> for a particular <code>INotification</code>.
     *
     * <P>
     * All previously attached <code>IObservers</code> for this <code>INotification</code>'s
     * list are notified and are passed a reference to the <code>INotification</code> in
     * the order in which they were registered.</P>
     * <P>
     * NOTE: Use this method only if you are sending custom Notifications. Otherwise
     * use the sendNotification method which does not require you to create the
     * Notification instance.</P>
     *
     * @param notification the <code>INotification</code> to notify <code>IObservers</code> of.
     */
    func notifyObservers(notification: INotification)

    /** 
     * Register an <code>ICommand</code> with the <code>Controller</code>.
     *
     * @param notificationName the name of the <code>INotification</code> to associate the <code>ICommand</code> with.
     * @param commandClassRef a reference to the <code>Class</code> of the <code>ICommand</code>.
     */
    func registerCommand(notificationName: String, commandClass: Notifier.Type)

    /** 
     * Register an <code>IMediator</code> instance with the <code>View</code>.
     *
     * @param mediator a reference to the <code>IMediator</code> instance
     */
    func registerMediator(mediator: IMediator)

    /** 
     * Register an <code>IProxy</code> instance with the <code>Model</code>.
     *
     * @param proxy the <code>IProxy</code> to be registered with the <code>Model</code>.
     */
    func registerProxy(proxy: IProxy)

    /** 
     * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping from the Controller.
     *
     * @param notificationName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
     */
    func removeCommand(notificationName: String)

    /** 
     * Remove a <code>IMediator</code> instance from the <code>View</code>.
     *
     * @param mediatorName name of the <code>IMediator</code> instance to be removed.
     * @return the <code>IMediator</code> instance previously registered with the given <code>mediatorName</code>.
     */
    func removeMediator(mediatorName: String) -> IMediator

    /** 
     * Remove an <code>IProxy</code> instance from the <code>Model</code> by name.
     *
     * @param proxyName the <code>IProxy</code> to remove from the <code>Model</code>.
     * @return the <code>IProxy</code> that was removed from the <code>Model</code>
     */
    func removeProxy(proxyName: String) -> IProxy

    /** 
     * Retrieve an <code>IMediator</code> instance from the <code>View</code>.
     *
     * @param mediatorName the name of the <code>IMediator</code> instance to retrievve
     * @return the <code>IMediator</code> previously registered with the given <code>mediatorName</code>.
     */
    func retrieveMediator(mediatorName: String) -> IMediator

    /** 
     * Retrieve a <code>IProxy</code> from the <code>Model</code> by name.
     *
     * @param proxyName the name of the <code>IProxy</code> instance to be retrieved.
     * @return the <code>IProxy</code> previously regisetered by <code>proxyName</code> with the <code>Model</code>.
     */
    func retrieveProxy(proxyName: String) -> IProxy

    /** 
     * Create and send an <code>INotification</code>.
     *
     * @param notificationName the name of the notiification to send
     * @param body the body of the notification
     * @param type the type of the notification
     */
    func sendNotification(notificationName: String)
    func sendNotification(notificationName: String, body: AnyObject?)
    func sendNotification(notificationName: String, body: AnyObject?, type: String?)
    func sendNotification(notificationName: String, type: String?)
}
