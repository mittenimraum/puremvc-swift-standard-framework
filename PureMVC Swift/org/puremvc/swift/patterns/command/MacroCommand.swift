//
//  MacroCommand.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 01.07.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

@objc(MacroCommand)

class MacroCommand : Notifier, ICommand
{
    
    var subCommands : Array<String>?
    
    /**
    * Static Convenience Constructor.
    */
    class func command () -> MacroCommand
    {
        return MacroCommand()
    }
    
    /**
    * Constructor.
    *
    * <P>
    * You should not need to define a constructor,
    * instead, override the <code>initializeMacroCommand</code>
    * method.</P>
    *
    * <P>
    * If your subclass does define a constructor, be
    * sure to call <code>super.init()</code>.</P>
    */
    init ()
    {
        
        super.init()
        
        self.subCommands = Array<String>()
        
        self.initializeMacroCommand()
        
    }
    
    /**
    * Initialize the <code>MacroCommand</code>.
    *
    * <P>
    * In your subclass, override this method to
    * initialize the <code>MacroCommand</code>'s <i>SubCommand</i>
    * list with <code>ICommand</code> class references like
    * this:</P>
    *
    * @code
    *		// Initialize MyMacroCommand
    *		func initializeMacroCommand ()
    *       {
    *			self.addSubCommand( "FirstCommand" );
    *			self.addSubCommand( "SecondCommand" );
    *			self.addSubCommand( "ThirdCommand" );
    *		}
    * @endcode
    *
    * <P>
    * Note that <i>SubCommand</i>s may be any <code>ICommand</code> implementor,
    * <code>MacroCommand</code>s or <code>SimpleCommands</code> are both acceptable.
    */
    func initializeMacroCommand ()
    {
        
    }
    
    /**
    * Add a <i>SubCommand</i>.
    *
    * <P>
    * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
    * order.</P>
    *
    * @param commandClassRef a reference to the <code>Class</code> of the <code>ICommand</code>.
    */
    func addSubCommand( commandClassRef : String? )
    {
        //self.subCommands!.append( commandClassRef! )
    }
    
    /**
    * Execute this <code>MacroCommand</code>'s <i>SubCommands</i>.
    *
    * <P>
    * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
    * order.
    *
    * @param notification the <code>INotification</code> object to be passsed to each <i>SubCommand</i>.
    */
    func execute( notification: INotification )
    {
        for commandClassRef : String in self.subCommands!
        {
           
            let commandClass = NSClassFromString( commandClassRef ) as NSObject.Type
            let commandInstance = commandClass() as ICommand
            
            commandInstance.execute( notification )
            
        }
    }
    
}