//
//  ICommand.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

/**
* The interface definition for a PureMVC Command.
*
* @see INotification
*/

@objc protocol ICommand
{
    
    /**
    * Execute the <code>ICommand</code>'s logic to handle a given <code>INotification</code>.
    *
    * @param notification an <code>INotification</code> to handle.
    */
    
    func execute ( notification: INotification )
    
}

