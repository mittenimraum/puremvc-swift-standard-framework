//
//  IModel.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

/** 
 * The interface definition for a PureMVC Model.
 *
 * <P>
 * In PureMVC, <code>IModel</code> implementors provide
 * access to <code>IProxy</code> objects by named lookup. </P>
 *
 * <P>
 * An <code>IModel</code> assumes these responsibilities:</P>
 *
 * <UL>
 * <LI>Maintain a cache of <code>IProxy</code> instances</LI>
 * <LI>Provide methods for registering, retrieving, and removing <code>IProxy</code> instances</LI>
 * </UL>
 */

protocol IModel {

    /** 
     * Check if a Proxy is registered
     *
     * @param proxyName
     * @return whether a Proxy is currently registered with the given <code>proxyName</code>.
     */
    func hasProxy(proxyName: String) -> Bool

    /** 
     * Register an <code>IProxy</code> instance with the <code>Model</code>.
     *
     * @param proxy an object reference to be held by the <code>Model</code>.
     */
    func registerProxy(proxy: IProxy)

    /** 
     * Remove an <code>IProxy</code> instance from the Model.
     *
     * @param proxyName name of the <code>IProxy</code> instance to be removed.
     * @return the <code>IProxy</code> that was removed from the <code>Model</code>
     */
    func removeProxy(proxyName: String) -> IProxy

    /** 
     * Retrieve an <code>IProxy</code> instance from the Model.
     *
     * @param proxyName
     * @return the <code>IProxy</code> instance previously registered with the given <code>proxyName</code>.
     */
    func retrieveProxy(proxyName: String) -> IProxy
}
