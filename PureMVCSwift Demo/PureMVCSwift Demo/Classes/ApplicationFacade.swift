//
//  ApplicationFacade.swift
//  PureMVC Swift
//
//  Created by Stephan Schulz on 02.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

let COMMAND_STARTUP = "CommandStartup"

let EVENT_RECORD_WILL_ADD = "EventRecordWillAdd"
let EVENT_RECORD_DID_ADD = "EventRecordDidAdd"
let EVENT_RECORD_SHOULD_ADD = "EventRecordShouldAdd"
let EVENT_RECORD_SHOULD_REMOVE = "EventRecordShouldRemove"
let EVENT_RECORD_WILL_REMOVE = "EventRecordWillRemove"
let EVENT_RECORD_DID_REMOVE = "EventRecordDidRemove"

let SEGUE_OVERVIEW_DETAIL = "OverviewDetailSegue"
let SEGUE_ADD_GENRES = "AddGenreSegue"

let STORYBOARD_MAIN = "Main"
let STORYBOARD_ADD_RECORD = "RecordsAddNavigationController"

let COLOR_LIGHT_GRAY = "#C4C4C9"

let EPSILON = 0.001

class ApplicationFacade : Facade
{

    func startup( root : AnyObject )
    {
        sendNotification( COMMAND_STARTUP , body: root )
    }
    
    override class func getInstance() -> ApplicationFacade
    {
        dispatch_once( &Static.onceToken ,
        {
            Static.instance = ApplicationFacade ()
        })
        return Static.instance! as! ApplicationFacade
    }
    
    override func initializeController ()
    {
    
        super.initializeController()

        registerCommand( COMMAND_STARTUP , commandClass: StartupCommand.self )
    
    }
    
}
