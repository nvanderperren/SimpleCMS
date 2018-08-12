//
//  HeritageObjectDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 8/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class ArtefactDetailViewController: HeritageDetailViewController {
    
    @IBOutlet weak var objectIdTextField: UITextField!
    @IBOutlet weak var objectNameTextField: UITextField!
    @IBOutlet weak var objectTypeTextField: UITextField!
    
    var artefact: ArtefactViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Artefact showing")
        updateFields()
        objectIdTextField.isUserInteractionEnabled = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
  
    private func updateFields() {
        objectIdTextField.text = heritageId
        objectNameTextField.text = heritageName
        
        
    }
    
    
    

}
