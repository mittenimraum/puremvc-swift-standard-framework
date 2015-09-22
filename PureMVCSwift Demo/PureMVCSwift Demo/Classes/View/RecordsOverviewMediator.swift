//
//  OverviewMediator.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 06.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

class RecordsOverviewMediator : Mediator
{
    
    var recordProxy : RecordProxy?
    
    override class func NAME () -> String
    {
        return "RecordsOverviewMediator"
    }
    
    var controller : RecordsOverviewController
    {
        get
        {
            return self.viewComponent as! RecordsOverviewController
        }
    }
    
    override func initializeMediator()
    {
        
        self.recordProxy = ApplicationFacade.getInstance().retrieveProxy( RecordProxy.NAME() ) as? RecordProxy
        
        self.controller.records = self.recordProxy?.records
        
    }
    
    override func listNotificationInterests() -> Array<String>
    {
        return [
                 EVENT_RECORD_SHOULD_ADD, /* User has pressed Add button */
                 EVENT_RECORD_WILL_ADD, /* User has pressed Done button after entering new record data */
                 EVENT_RECORD_DID_ADD, /* New record has been stored in RecordProxy */
                 EVENT_RECORD_SHOULD_REMOVE, /* User has pressed Delete button */
                 EVENT_RECORD_DID_REMOVE /* Selected Record has been removed from RecordProxy */
               ]
    }
    
    override func handleNotification( notification: INotification )
    {
        
        if ( notification.name == EVENT_RECORD_SHOULD_ADD )
        {
            
            let storyboard = UIStoryboard( name: STORYBOARD_MAIN , bundle: nil )
            let navigationController = storyboard.instantiateViewControllerWithIdentifier( STORYBOARD_ADD_RECORD ) as! UINavigationController
            let viewController = navigationController.viewControllers.first as! RecordsAddController
            viewController.genres = recordProxy!.genres
            
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad
            {

                navigationController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext;
                
                self.controller.detailViewController?.presentViewController( navigationController , animated: true, completion: nil )

            }
            else
            {
                self.controller.presentViewController( navigationController , animated: true, completion: nil )
            }
            
        }
        
        else if ( notification.name == EVENT_RECORD_WILL_ADD )
        {
            
            let record = notification.body as! RecordVO
            
            self.recordProxy?.addRecord ( record )
            
        }
        
        else if ( notification.name == EVENT_RECORD_DID_ADD )
        {
            
            self.controller.records = self.recordProxy?.records

        }
        else if ( notification.name == EVENT_RECORD_SHOULD_REMOVE )
        {
            
            let record = notification.body as! RecordVO
            
            self.recordProxy?.removeRecord( record )
            
            
        }
        else if ( notification.name == EVENT_RECORD_DID_REMOVE )
        {
            
            self.controller.records = self.recordProxy?.records

        }
    }
    
}