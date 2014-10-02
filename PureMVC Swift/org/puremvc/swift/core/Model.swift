//
//  Model.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

/**
* A Singleton <code>IModel</code> implementation.
*
* <P>
* In PureMVC, the <code>Model</code> class provides
* access to model objects (Proxies) by named lookup.
*
* <P>
* The <code>Model</code> assumes these responsibilities:</P>
*
* <UL>
* <LI>Maintain a cache of <code>IProxy</code> instances.</LI>
* <LI>Provide methods for registering, retrieving, and removing
* <code>IProxy</code> instances.</LI>
* </UL>
*
* <P>
* Your application must register <code>IProxy</code> instances
* with the <code>Model</code>. Typically, you use an
* <code>ICommand</code> to create and register <code>IProxy</code>
* instances once the <code>Facade</code> has initialized the Core
* actors.</p>
*
* @see Proxy, IProxy
*/

class Model : IModel
{
    
    struct Static
    {
        static var onceToken : dispatch_once_t = 0
        static var instance : Model? = nil
    }
    
    var proxyMap : Dictionary<String,IProxy>
    
    /**
    * Constructor.
    *
    * <P>
    * This <code>IModel</code> implementation is a Singleton,
    * so you should not call the constructor
    * directly, but instead call the static Singleton
    * Factory method <code>[Model getInstance]</code>
    *
    * @throws NSException if Singleton instance has already been constructed
    *
    */
    init ()
    {
        
        assert( Static.instance == nil, "Model Singleton already initialized!" )
        
        self.proxyMap = Dictionary<String,IProxy>()
        
        self.initializeModel()
        
    }
    
    /**
    * Initialize the Singleton <code>Model</code> instance.
    *
    * <P>
    * Called automatically by the constructor, this
    * is your opportunity to initialize the Singleton
    * instance in your subclass without overriding the
    * constructor.</P>
    *
    * @return void
    */
    func initializeModel ()
    {
    }
    
    /**
    * <code>Model</code> Singleton Factory method.
    *
    * @return the Singleton instance
    */
    class var getInstance : Model
    {
        dispatch_once(&Static.onceToken,
        {
            Static.instance = Model()
        })
        return Static.instance!
    }
    
    /**
    * Check if a Proxy is registered
    *
    * @param proxyName
    * @return whether a Proxy is currently registered with the given <code>proxyName</code>.
    */
    func hasProxy( proxyName: String ) -> Bool
    {
        return self.proxyMap[ proxyName ] != nil;
    }
    
    /**
    * Register an <code>IProxy</code> with the <code>Model</code>.
    *
    * @param proxy an <code>IProxy</code> to be held by the <code>Model</code>.
    */
    func registerProxy( proxy: IProxy )
    {
        
        self.proxyMap[ proxy.proxyName! ] = proxy;
        
        proxy.onRegister()
        
    }
    
    /**
    * Remove an <code>IProxy</code> from the <code>Model</code>.
    *
    * @param proxyName name of the <code>IProxy</code> instance to be removed.
    * @return the <code>IProxy</code> that was removed from the <code>Model</code>
    */
    func removeProxy( proxyName: String ) -> IProxy
    {
        
        var proxy : IProxy? = self.proxyMap[ proxyName ]!;
        
        if ( proxy != nil )
        {
            
            proxy!.onRemove();
            
            self.proxyMap[ proxyName ] = nil;
            
        }
        return proxy!;
    }
    
    /**
    * Retrieve an <code>IProxy</code> from the <code>Model</code>.
    * 
    * @param proxyName
    * @return the <code>IProxy</code> instance previously registered with the given <code>proxyName</code>.
    */
    func retrieveProxy( proxyName: String ) -> IProxy
    {
        return self.proxyMap[ proxyName ]!
    }
    
}