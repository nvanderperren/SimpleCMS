//
//  PublicationDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 11/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class PublicationDetailViewController: HeritageDetailViewController {
    
    var publication: PublicationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Publication showing")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

}
