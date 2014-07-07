//
//  Proxy.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

class Proxy : IProxy
{
    
    /**
    * A base <code>IProxy</code> implementation.
    *
    * <P>
    * In PureMVC, <code>Proxy</code> classes are used to manage parts of the
    * application's data model. </P>
    *
    * <P>
    * A <code>Proxy</code> might simply manage a reference to a local data object,
    * in which case interacting with it might involve setting and
    * getting of its data in synchronous fashion.</P>
    *
    * <P>
    * <code>Proxy</code> classes are also used to encapsulate the application's
    * interaction with remote services to save or retrieve data, in which case,
    * we adopt an asyncronous idiom; setting data (or calling a method) on the
    * <code>Proxy</code> and listening for a <code>Notification</code> to be sent
    * when the <code>Proxy</code> has retrieved the data from the service. </P>
    * 
    * @see Model
    */
    
    var data: AnyObject?
    var proxyName: String?
    
    class func NAME () -> String
    {
        return "Proxy";
    }
    
    class func proxy () -> Proxy
    {
        return Proxy( proxyName: nil , data: nil )
    }
    
    class func withProxyName( proxyName: String ) -> Proxy
    {
        return Proxy( proxyName: proxyName , data: nil )
    }
    
    class func withProxyName( proxyName: String , data: AnyObject ) -> Proxy
    {
        return Proxy( proxyName: proxyName , data: data )
    }
    
    class func withData( data: AnyObject ) -> Proxy
    {
        return Proxy( proxyName: nil , data: data )
    }
    
    init( proxyName: String? , data: AnyObject? )
    {
        
        self.proxyName = proxyName!;
        self.data = data!;
        
        self.initializeProxy()
        
    }
    
    /**
    * Initialize the Proxy instance.
    *
    * <P>
    * Called automatically by the constructor, this
    * is your opportunity to initialize the Proxy
    * instance in your subclass without overriding the
    * constructor.</P>
    *
    * @return void
    */
    func initializeProxy ()
    {
    }
    
    /**
    * Called by the Model when the Proxy is registered
    */ 
    func onRegister ()
    {
    }
    
    /**
    * Called by the Model when the Proxy is removed
    */ 
    func onRemove ()
    {
    }

}
