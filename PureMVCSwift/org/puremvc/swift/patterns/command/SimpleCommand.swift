//
//  SimpleCommand.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

class SimpleCommand: Notifier, ICommand {

    /** 
     * Static Convenience Constructor.
     */
    class func command() -> SimpleCommand {
        return SimpleCommand()
    }

    /** 
     * Fulfill the use-case initiated by the given <code>INotification</code>.
     *
     * <P>
     * In the Command Pattern, an application use-case typically
     * begins with some user action, which results in an <code>INotification</code> being broadcast, which
     * is handled by business logic in the <code>execute</code> method of an
     * <code>ICommand</code>.</P>
     *
     * @param notification the <code>INotification</code> to handle.
     */
    func execute(notification: INotification) {
    }
}
