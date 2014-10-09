//
//  IProxy.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

/**
* The interface definition for a PureMVC Proxy.
*
* <P>
* In PureMVC, <code>IProxy</code> implementors assume these responsibilities:</P>
* <UL>
* <LI>Implement a common method which returns the name of the Proxy.</LI>
* <LI>Provide methods for setting and getting the data object.</LI>
* </UL>
* <P>
* Additionally, <code>IProxy</code>s typically:</P>
* <UL>
* <LI>Maintain references to one or more pieces of model data.</LI>
* <LI>Provide methods for manipulating that data.</LI>
* <LI>Generate <code>INotifications</code> when their model data changes.</LI>
* <LI>Expose their name as a <code>static method</code> called <code>NAME</code>, if they are not instantiated multiple times.</LI>
* <LI>Encapsulate interaction with local or remote services used to fetch and persist model data.</LI>
* </UL>
*/


protocol IProxy
{
    
    /**
    * Get the data object
    *
    * @return the data as type id
    */
    var data: AnyObject? { get }
    
    /**
    * Get the Proxy name
    *
    * @return the Proxy instance name
    */
    var proxyName: String? { get }
    
    /**
    * Called by the Model when the Proxy is registered
    */
    func onRegister ()
    
    /**
    * Called by the Model when the Proxy is removed
    */
    func onRemove ()
    
}