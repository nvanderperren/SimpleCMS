//
//  MonumentDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 10/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class MonumentDetailViewController: HeritageDetailViewController {
    
    @IBOutlet weak var monumentIdTextField: UITextField!
    @IBOutlet weak var monumentNameTextField: UITextField!
    
    var monument: MonumentViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Monument showing")
        updateFields()
    }
    
    private func updateFields() {
        monumentIdTextField.text = heritageId
        monumentNameTextField.text = heritageName
        
        
    }
        

}
