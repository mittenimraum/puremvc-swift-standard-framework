//
//  Facade.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

/**
* A base Singleton <code>IFacade</code> implementation.
*
* <P>
* In PureMVC, the <code>Facade</code> class assumes these
* responsibilities:
* <UL>
* <LI>Initializing the <code>Model</code>, <code>View</code>
* and <code>Controller</code> Singletons.</LI>
* <LI>Providing all the methods defined by the <code>IModel,
* IView, & IController</code> interfaces.</LI>
* <LI>Providing the ability to override the specific <code>Model</code>,
* <code>View</code> and <code>Controller</code> Singletons created.</LI>
* <LI>Providing a single point of contact to the application for
* registering <code>Commands</code> and notifying <code>Observers</code></LI>
* </UL>
* <P>
*
* @see Model, View, Controller, Notification, Mediator, Proxy, SimpleCommand, MacroCommand
*/

class Facade : IFacade
{
    
    struct Static
    {
        static var onceToken : dispatch_once_t = 0
        static var instance : Facade? = nil
    }
    
    var controller : IController?
    var model : IModel?
    var view : IView?
    
    /**
    * Constructor.
    *
    * <P>
    * This <code>IFacade</code> implementation is a Singleton,
    * so you should not call the constructor
    * directly, but instead call the static Singleton
    * Factory method <code>[Facade getInstance]</code>
    *
    * @throws NSException if Singleton instance has already been constructed
    *
    */
    init ()
    {
        
        assert( Static.instance == nil, "Facade Singleton already initialized!" )
        
        self.initializeFacade()
        
    }
    
    /**
    * Initialize the Singleton <code>Facade</code> instance.
    *
    * <P>
    * Called automatically by the constructor. Override in your
    * subclass to do any subclass specific initializations. Be
    * sure to call <code>[super initializeFacade]</code>, though.</P>
    */
    func initializeFacade()
    {
        self.initializeModel()
        self.initializeController()
        self.initializeView()
    }
    
    /**
    * Facade Singleton Factory method
    *
    * @return the Singleton instance of the Facade
    */
    class func getInstance() -> Facade
    {
        dispatch_once(&Static.onceToken,
        {
            Static.instance = Facade()
        })
        return Static.instance!
    }

    
    /**
    * Initialize the <code>Model</code>.
    *
    * <P>
    * Called by the <code>initializeFacade</code> method.
    * Override this method in your subclass of <code>Facade</code>
    * if one or both of the following are true:
    * <UL>
    * <LI> You wish to initialize a different <code>IModel</code>.</LI>
    * <LI> You have <code>Proxy</code>s to register with the Model that do not
    * retrieve a reference to the Facade at construction time.</code></LI>
    * </UL>
    * If you don't want to initialize a different <code>IModel</code>,
    * call <code>[super initializeModel]</code> at the beginning of your
    * method, then register <code>Proxy</code>s.
    * <P>
    * Note: This method is <i>rarely</i> overridden; in practice you are more
    * likely to use a <code>Command</code> to create and register <code>Proxy</code>s
    * with the <code>Model</code>, since <code>Proxy</code>s with mutable data will likely
    * need to send <code>INotification</code>s and thus will likely want to fetch a reference to
    * the <code>Facade</code> during their construction.
    * </P>
    */
    func initializeModel ()
    {
        if ( model != nil )
        {
            return;
        }
        self.model = Model.getInstance
    }
    
    /**
    * Initialize the <code>Controller</code>.
    *
    * <P>
    * Called by the <code>initializeFacade</code> method.
    * Override this method in your subclass of <code>Facade</code>
    * if one or both of the following are true:
    * <UL>
    * <LI> You wish to initialize a different <code>IController</code>.</LI>
    * <LI> You have <code>Commands</code> to register with the <code>Controller</code> at startup.</code>. </LI>
    * </UL>
    * If you don't want to initialize a different <code>IController</code>,
    * call <code>[super initializeController]</code> at the beginning of your
    * method, then register <code>Command</code>s.
    * </P>
    */
    func initializeController ()
    {
        if ( controller != nil )
        {
            return;
        }
        self.controller = Controller.getInstance
    }
    
    /**
    * Initialize the <code>View</code>.
    *
    * <P>
    * Called by the <code>initializeFacade</code> method.
    * Override this method in your subclass of <code>Facade</code>
    * if one or both of the following are true:
    * <UL>
    * <LI> You wish to initialize a different <code>IView</code>.</LI>
    * <LI> You have <code>Observers</code> to register with the <code>View</code></LI>
    * </UL>
    * If you don't want to initialize a different <code>IView</code>,
    * call <code>[super initializeView]</code> at the beginning of your
    * method, then register <code>IMediator</code> instances.
    * <P>
    * Note: This method is <i>rarely</i> overridden; in practice you are more
    * likely to use a <code>Command</code> to create and register <code>Mediator</code>s
    * with the <code>View</code>, since <code>IMediator</code> instances will need to send
    * <code>INotification</code>s and thus will likely want to fetch a reference
    * to the <code>Facade</code> during their construction.
    * </P>
    */
    func initializeView ()
    {
        if ( view != nil )
        {
            return;
        }
        self.view = View.getInstance
    }
    
    
    /**
    * Create and send an <code>INotification</code>.
    *
    * <P>
    * Keeps us from having to construct new notification
    * instances in our implementation code.
    * @param notificationName the name of the notiification to send
    * @param body the body of the notification
    * @param type the type of the notification
    */
    func sendNotification( notificationName: String , body: AnyObject? , type: String? )
    {
        self.notifyObservers( Notification.withName( notificationName , body: body , type: type ))
    }
    
    func sendNotification ( notificationName: String )
    {
        self.sendNotification( notificationName , body:nil , type:nil )
    }
    
    func sendNotification ( notificationName: String , body: AnyObject? )
    {
        self.sendNotification ( notificationName , body: body , type: nil )
    }
    
    func sendNotification ( notificationName: String , type: String? )
    {
        self.sendNotification ( notificationName , body: nil , type: type )
    }
    
    /**
    * Check if a Command is registered for a given Notification
    *
    * @param notificationName
    * @return whether a Command is currently registered for the given <code>notificationName</code>.
    */
    func hasCommand( notificationName: String ) -> Bool
    {
        return controller!.hasCommand( notificationName )
    }
    
    /**
    * Check if a Mediator is registered or not
    *
    * @param mediatorName
    * @return whether a Mediator is registered with the given <code>mediatorName</code>.
    */
    func hasMediator ( mediatorName: String ) -> Bool
    {
        return view!.hasMediator( mediatorName )
    }
    
    /**
    * Check if a Proxy is registered
    *
    * @param proxyName
    * @return whether a Proxy is currently registered with the given <code>proxyName</code>.
    */
    func hasProxy ( proxyName: String ) -> Bool
    {
        return model!.hasProxy ( proxyName )
    }
    
    /**
    * Notify <code>Observer</code>s.
    * <P>
    * This method is left public mostly for backward
    * compatibility, and to allow you to send custom
    * notification classes using the facade.</P>
    *<P>
    * Usually you should just call sendNotification
    * and pass the parameters, never having to
    * construct the notification yourself.</P>
    *
    * @param notification the <code>INotification</code> to have the <code>View</code> notify <code>Observers</code> of.
    */
    func notifyObservers( notification: INotification )
    {
        view!.notifiyObservers( notification )
    }
    
    /**
    * Register an <code>ICommand</code> with the <code>Controller</code> by Notification name.
    *
    * @param notificationName the name of the <code>INotification</code> to associate the <code>ICommand</code> with
    * @param commandClassRef a reference to the Class of the <code>ICommand</code>
    */
    func registerCommand ( notificationName: String , commandClass: Notifier.Type )
    {
        controller!.registerCommand( notificationName, commandClass: commandClass )
    }
    
    /**
    * Register a <code>IMediator</code> with the <code>View</code>.
    *
    * @param mediator a reference to the <code>IMediator</code>
    */
    func registerMediator ( mediator: IMediator )
    {
        view!.registerMediator( mediator )
    }
    
    /**
    * Register an <code>IProxy</code> with the <code>Model</code> by name.
    *
    * @param proxy the <code>IProxy</code> instance to be registered with the <code>Model</code>.
    */
    func registerProxy ( proxy: IProxy )
    {
        model!.registerProxy( proxy )
    }
    
    /**
    * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping from the Controller.
    *
    * @param notificationName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
    */
    func removeCommand ( notificationName: String )
    {
        controller!.removeCommand( notificationName )
    }
    
    /**
    * Remove an <code>IMediator</code> from the <code>View</code>.
    *
    * @param mediatorName name of the <code>IMediator</code> to be removed.
    * @return the <code>IMediator</code> that was removed from the <code>View</code>
    */
    func removeMediator ( mediatorName: String ) -> IMediator
    {
        return view!.removeMediator( mediatorName )
    }
    
    /**
    * Remove an <code>IProxy</code> from the <code>Model</code> by name.
    *
    * @param proxyName the <code>IProxy</code> to remove from the <code>Model</code>.
    * @return the <code>IProxy</code> that was removed from the <code>Model</code>
    */
    func removeProxy ( proxyName: String ) -> IProxy
    {
        return model!.removeProxy( proxyName )
    }
    
    /**
    * Retrieve an <code>IMediator</code> from the <code>View</code>.
    * 
    * @param mediatorName
    * @return the <code>IMediator</code> previously registered with the given <code>mediatorName</code>.
    */
    func retrieveMediator ( mediatorName: String ) -> IMediator
    {
        return view!.retrieveMediator( mediatorName )
    }
    
    /**
    * Retrieve an <code>IProxy</code> from the <code>Model</code> by name.
    * 
    * @param proxyName the name of the proxy to be retrieved.
    * @return the <code>IProxy</code> instance previously registered with the given <code>proxyName</code>.
    */
    func retrieveProxy ( proxyName: String ) -> IProxy
    {
        return model!.retrieveProxy( proxyName )
    }
}