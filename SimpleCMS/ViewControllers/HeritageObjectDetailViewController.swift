//
//  HeritageObjectDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 8/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageObjectDetailViewController: UITableViewController, UITextFieldDelegate {
    
    var objectId: String?
    var objectName: String?
    

    @IBOutlet weak var objectIdTextField: UITextField!
    @IBOutlet weak var objectNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFields()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true) 
    }
    
    private func updateFields() {
        objectIdTextField.text = objectId
        objectNameTextField.text = objectName
        
        
    }
    
    
    

}
