//
//  RecordsAddInputCell.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 22.09.15.
//  Copyright © 2015 Stephan Schulz. All rights reserved.
//

import UIKit

class RecordsAddInputCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtInput: UITextField!

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
}
