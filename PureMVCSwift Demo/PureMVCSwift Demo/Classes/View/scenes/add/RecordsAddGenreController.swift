//
//  RecordsAddGenreController.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 22.09.15.
//  Copyright © 2015 Stephan Schulz. All rights reserved.
//

protocol RecordsGenreDelegate
{
    var genres : Array<String> { get }
    var genresSelected : Array<String> { get set }
}

class RecordsAddGenreController : UITableViewController
{
    
    var delegate : RecordsGenreDelegate?
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return delegate!.genres.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier( kGenreCell , forIndexPath: indexPath )
        let genre = delegate!.genres[ indexPath.row ]
        
        cell.textLabel?.text = genre
        cell.accessoryType = delegate!.genresSelected.contains( genre ) ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        
        return cell
        
    }
    
    override func tableView( tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath )
    {
        
        let cell = tableView.cellForRowAtIndexPath( indexPath )
        let genre = delegate!.genres[ indexPath.row ]
        
        if var d = delegate
        {
            if d.genresSelected.contains( genre )
            {
                
                d.genresSelected.removeObject( genre )
                
                cell?.accessoryType = UITableViewCellAccessoryType.None
                
            }
            else
            {
                
                d.genresSelected.append( genre )
                
                cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                
            }
        }
        
        delegate!.genresSelected.sortInPlace { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        
        super.viewDidDisappear( animated )
        
        delegate = nil
        
    }
}
