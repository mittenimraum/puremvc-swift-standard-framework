//
//  RecordsCreateController.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 06.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation
import UIKit

var kAddInputCell : String = "RecordsAddInputCell"
var kAddSelectCell : String = "RecordsAddSelectCell"
var kGenreCell : String = "RecordsGenreCell"

var kLanguageInterpret : String = "Interpret"
var kLanguageAlbum : String = "Album"
var kLanguageGenres : String = "Genres"
var kLanguageYear : String = "Year"

var kLanguageEnterInterpret = "Enter Interpret Name"
var kLanguageEnterAlbum = "Enter Album Name"
var kLanguageSelectYear = "Select Year"
var kLanguageSelectGenres = "Select Genres"

class RecordsAddController : UITableViewController, UITextFieldDelegate, RecordsGenreDelegate
{

    var years : Array<String> = []
    var genres : Array<String> = []
    var genresSelected : Array<String> = []
    
    var txtInterpret: UITextField?
    var txtAlbum: UITextField?
    var txtYear: UILabel?
    var txtGenre: UILabel?
    
    @IBOutlet weak var btnDone: UIBarButtonItem!

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        for index in 1900...2099
        {
            
            var year = String( format: "%i", index )
            
            years.append( year )
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        
        super.viewDidAppear( animated )
        
        if ( txtInterpret!.text.isEmpty )
        {
            txtInterpret?.becomeFirstResponder()
        }
        
    }
    
    override func viewDidLayoutSubviews()
    {
        validate()
        update()
    }
    
    func validate()
    {
        self.btnDone.enabled = !txtInterpret!.text.isEmpty && !txtAlbum!.text.isEmpty && genres.count > 0 && txtYear?.tag > 0
    }
    
    func update ()
    {
        
        txtGenre?.text = genresSelected.count > 0 ? genresSelected.combine( ", " ) : kLanguageSelectGenres
        txtGenre?.textColor = genresSelected.count > 0 ? UIColor.blackColor() : UIColor( rgba: COLOR_LIGHT_GRAY )
        txtYear?.textColor = txtYear?.tag > 0 ? UIColor.blackColor() : UIColor( rgba: COLOR_LIGHT_GRAY )
        
    }
    
    func close ()
    {
        
        self.view.endEditing( true )
        
        self.dismissViewControllerAnimated( true , completion: nil )
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField.returnKeyType == UIReturnKeyType.Next
        {
            
            let current = self.tableView.indexPathForCell( textField.superview?.superview? as UITableViewCell )
            let next = tableView.cellForRowAtIndexPath( NSIndexPath( forRow: current!.row + 1 , inSection: 0 ))

            ( next as RecordsAddInputCell ).txtInput.becomeFirstResponder()
            
        }
        else if  textField.returnKeyType == UIReturnKeyType.Done
        {
            textField.resignFirstResponder()
        }
        return true;
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        
        delay( EPSILON )
        {
            self.validate()
        }
        
        return true
        
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool
    {
        
        validate()
        
        return true
        
    }
    
    @IBAction func onCancelTouched(sender: AnyObject)
    {
        close()
    }
    
    @IBAction func onDoneTouched(sender: AnyObject)
    {
        
        ApplicationFacade.getInstance().sendNotification( EVENT_RECORD_WILL_ADD , body: RecordVO( interpret: txtInterpret?.text , album: txtAlbum?.text , year: txtYear?.text , genres: txtGenre?.text ))
        
        close()
        
    }
    
    func onYearSelected ( selectedIndex: NSNumber! , origin: AnyObject! )
    {
        
        txtYear?.text = years[ selectedIndex.integerValue ]
        txtYear?.tag = 1
        
        validate()
        update()
        
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell : UITableViewCell?
        
        switch indexPath.row
        {
        case 0, 1:
            
            let c = tableView.dequeueReusableCellWithIdentifier( kAddInputCell , forIndexPath: indexPath ) as RecordsAddInputCell
            
            c.txtInput.delegate = self
            
            switch indexPath.row
            {
            case 0:
                
                c.txtTitle.text = kLanguageInterpret
                c.txtInput.placeholder = kLanguageEnterInterpret
                
                txtInterpret = c.txtInput
                
            case 1:
                
                c.txtTitle.text = kLanguageAlbum
                c.txtInput.placeholder = kLanguageEnterAlbum
                c.txtInput.returnKeyType = UIReturnKeyType.Done
                
                txtAlbum = c.txtInput

            default :()
                
            }
            
            cell = c
            
        case 2, 3:
            
            let c = tableView.dequeueReusableCellWithIdentifier( kAddSelectCell , forIndexPath: indexPath ) as RecordsAddSelectCell
            
            switch indexPath.row
            {
            case 2:
                
                c.txtTitle.text = kLanguageYear
                c.txtSelect.text = kLanguageSelectYear
                
                txtYear = c.txtSelect
                
            case 3:
                
                c.txtTitle.text = kLanguageGenres
                c.txtSelect.text = kLanguageSelectGenres
                c.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
                txtGenre = c.txtSelect
                
            default :()
            }
            
            cell = c

        default: ()
            
        }
        
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        switch indexPath.row
        {
        case 2:
            
            ActionSheetStringPicker.showPickerWithTitle( kLanguageSelectYear , rows: years , initialSelection: 114 , target: self , successAction: "onYearSelected:origin:" , cancelAction: nil , origin: txtYear )
            
        case 3:
        
            performSegueWithIdentifier( SEGUE_ADD_GENRES , sender: self )
            
        default: ()
        }

    }
    
    // MARK: - Segues
    
    override func prepareForSegue( segue: UIStoryboardSegue, sender: AnyObject? )
    {
        if segue.identifier == SEGUE_ADD_GENRES
        {

            let genreController = segue.destinationViewController as RecordsAddGenreController
            
            genreController.delegate = self
            
        }
    }

    
}

class RecordsAddInputCell : UITableViewCell
{
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtInput: UITextField!
    
    required init( coder aDecoder: NSCoder )
    {
        
        super.init( coder: aDecoder )
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
}

class RecordsAddSelectCell : UITableViewCell
{
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtSelect: UILabel!
    
    required init( coder aDecoder: NSCoder )
    {
        
        super.init( coder: aDecoder )
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
}

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
        
        let cell = tableView.dequeueReusableCellWithIdentifier( kGenreCell , forIndexPath: indexPath ) as UITableViewCell
        let genre = delegate!.genres[ indexPath.row ]
        
        cell.textLabel?.text = genre
        cell.accessoryType = delegate!.genresSelected.contains( genre ) ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None

        return cell
        
    }
    
    override func tableView( tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath )
    {
        
        let cell = tableView.cellForRowAtIndexPath( indexPath )
        let genre = delegate!.genres[ indexPath.row ]
        
        if var d = delegate?
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
        
        delegate!.genresSelected.sort { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        
        super.viewDidDisappear( animated )
        
        delegate = nil
        
    }
}