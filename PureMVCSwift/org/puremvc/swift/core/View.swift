//
//  View.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

/**
* A Singleton <code>IView</code> implementation.
*
* <P>
* In PureMVC, the <code>View</code> class assumes these responsibilities:
* <UL>
* <LI>Maintain a cache of <code>IMediator</code> instances.</LI>
* <LI>Provide methods for registering, retrieving, and removing <code>IMediators</code>.</LI>
* <LI>Notifiying <code>IMediators</code> when they are registered or removed.</LI>
* <LI>Managing the observer lists for each <code>INotification</code> in the application.</LI>
* <LI>Providing a method for attaching <code>IObservers</code> to an <code>INotification</code>'s observer list.</LI>
* <LI>Providing a method for broadcasting an <code>INotification</code>.</LI>
* <LI>Notifying the <code>IObservers</code> of a given <code>INotification</code> when it broadcast.</LI>
* </UL>
*
* @see Mediator, Observer, Notification
*/

class View : IView
{
    
    struct Static
    {
        static var onceToken : dispatch_once_t = 0
        static var instance : View? = nil
    }
    
    var mediatorMap : Dictionary<String,IMediator>
    var observerMap : Dictionary<String,Array<IObserver>>
    
    /**
    * Constructor.
    *
    * <P>
    * This <code>IView</code> implementation is a Singleton,
    * so you should not call the constructor
    * directly, but instead call the static Singleton
    * Factory method <code>[View getInstance]</code>
    *
    * @throws NSException if Singleton instance has already been constructed
    *
    */
    init ()
    {
        
        assert( Static.instance == nil, "View Singleton already initialized!" )
        
        self.mediatorMap = Dictionary<String,IMediator>()
        self.observerMap = Dictionary<String,Array<IObserver>>()
        
        self.initializeView()
        
    }
    
    /**
    * Initialize the Singleton View instance.
    *
    * <P>
    * Called automatically by the constructor, this
    * is your opportunity to initialize the Singleton
    * instance in your subclass without overriding the
    * constructor.</P>
    *
    * @return void
    */
    func initializeView ()
    {
    }
    
    /**
    * View Singleton Factory method.
    *
    * @return the Singleton instance of <code>View</code>
    */
    class var getInstance : View
    {
        dispatch_once(&Static.onceToken,
        {
            Static.instance = View()
        })
        return Static.instance!
    }

    /**
    * Check if a Mediator is registered or not
    *
    * @param mediatorName
    * @return whether a Mediator is registered with the given <code>mediatorName</code>.
    */
    func hasMediator( mediatorName: String ) -> Bool
    {
        return self.mediatorMap[ mediatorName ] != nil;
    }
    
    /**
    * Notify the <code>IObservers</code> for a particular <code>INotification</code>.
    *
    * <P>
    * All previously attached <code>IObservers</code> for this <code>INotification</code>'s
    * list are notified and are passed a reference to the <code>INotification</code> in
    * the order in which they were registered.</P>
    *
    * @param notification the <code>INotification</code> to notify <code>IObservers</code> of.
    */
    func notifiyObservers( notification: INotification )
    {
        if let observers : Array<IObserver> = self.observerMap[ notification.name! ]
        {
            for observer in observers
            {
                observer.notifyObserver( notification );
            }
        }
    }
    
    /**
    * Register an <code>IMediator</code> instance with the <code>View</code>.
    *
    * <P>
    * Registers the <code>IMediator</code> so that it can be retrieved by name,
    * and further interrogates the <code>IMediator</code> for its
    * <code>INotification</code> interests.</P>
    * <P>
    * If the <code>IMediator</code> returns any <code>INotification</code>
    * names to be notified about, an <code>Observer</code> is created encapsulating
    * the <code>IMediator</code> instance's <code>handleNotification</code> method
    * and registering it as an <code>Observer</code> for all <code>INotifications</code> the
    * <code>IMediator</code> is interested in.</p>
    *
    * @param mediator a reference to the <code>IMediator</code> instance
    */
    func registerMediator( mediator: IMediator )
    {
        
        if ( self.mediatorMap[ mediator.name! ] != nil )
        {
            return;
        }
     
        self.mediatorMap[ mediator.name! ] = mediator
        
        var interests : Array<String> = mediator.listNotificationInterests()

        if ( interests.count > 0 )
        {
            
            var observer : IObserver = Observer.withNotifyMethod( mediator.handleNotification! , notifyContext: mediator.context() )

            for notificationName in interests
            {
                self.registerObserver( notificationName , observer: observer )
            }

        }
        
        mediator.onRegister()

    }
    
    /**
    * Register an <code>IObserver</code> to be notified
    * of <code>INotifications</code> with a given name.
    *
    * @param notificationName the name of the <code>INotifications</code> to notify this <code>IObserver</code> of
    * @param observer the <code>IObserver</code> to register
    */
    func registerObserver( notificationName: String , observer: IObserver )
    {
        
        var observers : Array<IObserver>? = self.observerMap[ notificationName ]
        
        if ( observers != nil )
        {
            observers?.append( observer )
        }
        else
        {
            observers = [ observer ]
        }
        
        self.observerMap[ notificationName ] = observers

    }
    
    /**
    * Remove an <code>IMediator</code> from the <code>View</code>.
    *
    * @param mediatorName name of the <code>IMediator</code> instance to be removed.
    * @return the <code>IMediator</code> that was removed from the <code>View</code>
    */
    func removeMediator( mediatorName: String ) -> IMediator
    {
        
        var mediator : IMediator? = self.mediatorMap[ mediatorName ]!
        
        if ( mediator != nil )
        {
            
            var interests : Array<String> = mediator!.listNotificationInterests()
            
            for notificationName in interests
            {
                self.removeObserver( notificationName , notifyContext: mediator!.context() )
            }
            mediator!.onRemove()
            mediatorMap.removeValueForKey( mediatorName )
        }
        
        return mediator!
        
    }
    
    /**
    * Remove the observer for a given notifyContext from an observer list for a given Notification name.
    * <P>
    * @param notificationName which observer list to remove from
    * @param notifyContext remove the observer with this object as its notifyContext
    */
    func removeObserver( notificationName: String , notifyContext: AnyObject )
    {
        
        var observers : Array<IObserver>? = self.observerMap[ notificationName ]!
        
        if ( observers != nil )
        {
            
            for var i : Int = 0; i < observers!.count; ++i
            {
                
                var observer : IObserver = observers![ i ]
                
                if ( observer.compareNotifyContext( notifyContext ))
                {
                    
                    observers!.removeAtIndex( i )
                    
                    break
                    
                }
            }
            
        }
        
        if ( observers!.count == 0 )
        {
            self.observerMap.removeValueForKey( notificationName )
        }
        
    }
    
    /**
    * Retrieve an <code>IMediator</code> from the <code>View</code>.
    * 
    * @param mediatorName the name of the <code>IMediator</code> instance to retrieve.
    * @return the <code>IMediator</code> instance previously registered with the given <code>mediatorName</code>.
    */
    func retrieveMediator( mediatorName: String ) -> IMediator
    {
        return self.mediatorMap[ mediatorName ]!;
    }
}