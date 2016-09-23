//
//  DetailViewController.swift
//  asdfsdfasdf
//
//  Created by Stephan Schulz on 06.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import UIKit

class RecordsDetailController: UIViewController {

    @IBOutlet weak var txtAlbum: UILabel!
    @IBOutlet weak var txtInterpret: UILabel!
    @IBOutlet weak var txtGenres: UILabel!
    @IBOutlet weak var txtYear: UILabel!

    var record: RecordVO? {
        didSet {
            // Update the view.
            self.update()
        }
    }

    func update() {
        // Update the user interface for the detail item.
        if (record != nil) {
            if let interpret = self.txtInterpret {
                interpret.text = record?.interpret
            }
            if let album = self.txtAlbum {
                album.text = record?.album
            }
            if let genres = self.txtGenres {
                genres.text = record?.sortedGenres()
            }
            if let year = self.txtYear {
                year.text = record?.year
            }
        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        self.update()
    }
}
