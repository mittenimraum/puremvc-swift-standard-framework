//
//  Controller.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

/**
* A Singleton <code>IController</code> implementation.
*
* <P>
* In PureMVC, the <code>Controller</code> class follows the
* 'Command and Controller' strategy, and assumes these
* responsibilities:
* <UL>
* <LI> Remembering which <code>ICommand</code>s
* are intended to handle which <code>INotifications</code>.</LI>
* <LI> Registering itself as an <code>IObserver</code> with
* the <code>View</code> for each <code>INotification</code>
* that it has an <code>ICommand</code> mapping for.</LI>
* <LI> Creating a new instance of the proper <code>ICommand</code>
* to handle a given <code>INotification</code> when notified by the <code>View</code>.</LI>
* <LI> Calling the <code>ICommand</code>'s <code>execute</code>
* method, passing in the <code>INotification</code>.</LI>
* </UL>
*
* <P>
* Your application must register <code>ICommands</code> with the
* Controller.
* <P>
* The simplest way is to subclass </code>Facade</code>,
* and use its <code>initializeController</code> method to add your
* registrations.
*
* @see View, Observer, Notification, SimpleCommand, MacroCommand
*/

import Foundation

class Controller : IController
{
    
    struct Static
    {
        static var onceToken : dispatch_once_t = 0
        static var instance : Controller? = nil
    }
    
    var commandMap: Dictionary<String,Notifier.Type>
    var view: IView?
    
    /**
    * Constructor.
    *
    * <P>
    * This <code>IController</code> implementation is a Singleton,
    * so you should not call the constructor
    * directly, but instead call the static Singleton
    * Factory method <code>Controller.getInstance</code>
    *
    * @throws NSException if Singleton instance has already been constructed
    *
    */
    init ()
    {
        
        assert( Static.instance == nil, "Controller Singleton already initialized!" )
        
        self.commandMap = Dictionary<String,Notifier.Type>()
        
        self.initializeController()
        
    }
    
    /**
    * Initialize the Singleton <code>Controller</code> instance.
    *
    * <P>Called automatically by the constructor.</P>
    *
    * <P>Note that if you are using a subclass of <code>View</code>
    * in your application, you should <i>also</i> subclass <code>Controller</code>
    * and override the <code>initializeController</code> method in the
    * following way:</P>
    *
    * @code
    *		// ensure that the Controller is talking to my IView implementation
    *		func initializeController () 
    *       {
    *			self.view = MyView.getIntance;
    *		}
    * @endcode
    *
    * @return void
    */
    func initializeController ()
    {
        self.view = View.getInstance
    }
    
    /**
    * <code>Controller</code> Singleton Factory method.
    *
    * @return the Singleton instance of <code>Controller</code>
    */
    class var getInstance : Controller
    {
        dispatch_once(&Static.onceToken,
        {
            Static.instance = Controller()
        })
        return Static.instance!
    }
    
    /**
    * If an <code>ICommand</code> has previously been registered
    * to handle a the given <code>INotification</code>, then it is executed.
    *
    * @param notification an <code>INotification</code>
    */
    func executeCommand ( notification: INotification )
    {
        
        var commandClass : Notifier.Type = self.commandMap[ notification.name! ]!;

        var commandInstance = commandClass()
        
        if ( commandInstance is SimpleCommand )
        {
            ( commandInstance as SimpleCommand ).execute( notification )
        }
        
        if ( commandInstance is MacroCommand )
        {
            ( commandInstance as MacroCommand ).execute( notification )
        }

    }
    
    /**
    * Check if a Command is registered for a given Notification
    *
    * @param notificationName
    * @return whether a Command is currently registered for the given <code>notificationName</code>.
    */
    func hasCommand ( notificationName: String ) -> Bool
    {
        return self.commandMap[ notificationName ] != nil;
    }

    /**
    * Register a particular <code>ICommand</code> class as the handler
    * for a particular <code>INotification</code>.
    *
    * <P>
    * If an <code>ICommand</code> has already been registered to
    * handle <code>INotification</code>s with this name, it is no longer
    * used, the new <code>ICommand</code> is used instead.</P>
    *
    * The Observer for the new ICommand is only created if this the
    * first time an ICommand has been regisered for this Notification name.
    *
    * @param notificationName the name of the <code>INotification</code>
    * @param commandClass the <code>Class</code> of the <code>ICommand</code>
    */
    func registerCommand ( notificationName: String , commandClass: Notifier.Type )
    {
        
        if ( self.commandMap[ notificationName ] == nil )
        {
            
            var observer : IObserver = Observer.withNotifyMethod ( executeCommand , notifyContext: self )
            
            self.view?.registerObserver( notificationName , observer: observer )
            
        }

        self.commandMap.updateValue( commandClass , forKey: notificationName )
        
    }
    
    /**
    * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping.
    *
    * @param notificationName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
    */
    func removeCommand( notificationName: String )
    {
        if ( self.hasCommand( notificationName ))
        {
            
            self.view?.removeObserver( notificationName , notifyContext: self )
            
            self.commandMap.removeValueForKey( notificationName )
            
        }
    }
    
}
