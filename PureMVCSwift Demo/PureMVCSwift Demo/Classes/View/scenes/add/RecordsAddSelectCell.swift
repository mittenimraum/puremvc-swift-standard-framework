//
//  RecordsAddSelectCell.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 22.09.15.
//  Copyright © 2015 Stephan Schulz. All rights reserved.
//

import UIKit

class RecordsAddSelectCell : UITableViewCell
{
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtSelect: UILabel!
    
    required init?( coder aDecoder: NSCoder )
    {
        
        super.init( coder: aDecoder )
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
}
