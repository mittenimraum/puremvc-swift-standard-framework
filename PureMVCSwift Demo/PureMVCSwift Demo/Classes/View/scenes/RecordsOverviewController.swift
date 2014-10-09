//
//  MasterViewController.swift
//  asdfsdfasdf
//
//  Created by Stephan Schulz on 06.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import UIKit

var kOverviewCell : String = "RecordsOverviewCell"

class RecordsOverviewController : UITableViewController
{

    var detailViewController: RecordsDetailController? = nil

    var records : Array<RecordVO>?
    {
        didSet
        {
            
            if ( oldValue != nil )
            {
                
                self.tableView.beginUpdates()
                
                for ( index, record ) in enumerate( oldValue! )
                {
                    
                    let recordWasRemoved = !self.records!.contains( record )
                    
                    if ( recordWasRemoved )
                    {
                        self.tableView.deleteRowsAtIndexPaths( [ NSIndexPath( forRow: index , inSection: 0 ) ], withRowAnimation: .Fade )
                    }
                    
                }
                
                for ( index, record ) in enumerate( self.records! )
                {
                    
                    let recordWasAdded = !oldValue!.contains( record )
                    
                    if ( recordWasAdded )
                    {
                        self.tableView.insertRowsAtIndexPaths( [ NSIndexPath( forRow: index , inSection: 0 ) ], withRowAnimation: .Fade )
                    }
                    
                }

                self.tableView.endUpdates()

            }
            else
            {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onAddRecord:" )
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    override func viewDidLayoutSubviews()
    {
        
        
    }
    
    override func viewWillAppear( animated: Bool )
    {
        
        super.viewWillAppear( animated )
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            self.tableView.selectRowAtIndexPath( NSIndexPath( forRow: 0 , inSection: 0 ) , animated: false, scrollPosition: UITableViewScrollPosition.Top )
            self.performSegueWithIdentifier( SEGUE_OVERVIEW_DETAIL , sender: self )
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {

        if segue.identifier == SEGUE_OVERVIEW_DETAIL
        {
            
            detailViewController = ( segue.destinationViewController as UINavigationController ).topViewController as? RecordsDetailController
            
            showDetailViewController( detailViewController! )
            
        }
    }
    
    func showDetailViewController( vc: RecordsDetailController )
    {
        
        if let indexPath = self.tableView.indexPathForSelectedRow()
        {
            
            let record = records?[ indexPath.row ]
            
            vc.record = record
            vc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            vc.navigationItem.leftItemsSupplementBackButton = true
            
        }

    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let count = self.records?.count
        {
            return count
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier( kOverviewCell , forIndexPath: indexPath)  as UITableViewCell
        let record = records?[ indexPath.row ]

        cell.textLabel?.text = record?.interpret
        
        return cell
        
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            showDetailViewController( self.detailViewController! )
        }
        else
        {
            performSegueWithIdentifier( SEGUE_OVERVIEW_DETAIL , sender: self )
        }
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            ApplicationFacade.getInstance().sendNotification( EVENT_RECORD_SHOULD_REMOVE , body: self.records?[ indexPath.row ] );
        }
    }

    func onAddRecord( sender: AnyObject )
    {
        ApplicationFacade.getInstance().sendNotification( EVENT_RECORD_SHOULD_ADD )
    }
    
    
}

