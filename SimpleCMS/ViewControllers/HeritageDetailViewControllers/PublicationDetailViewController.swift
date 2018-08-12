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
    
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var publicationPlaceTextField: UITextField!
    @IBOutlet weak var publicationDateTextField: UITextField!
    @IBOutlet weak var numberOfPagesTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var editionTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Publication showing")
        setupAllTextFields()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func setupAllTextFields() {
        let allTextFields = [heritageIdTextField, heritageNameTextField, authorTextField, acquisitionMethodTextField, acquisitionSourceTextField, acquisitionDateTextField, rightsLicenseTextField, creditLineTextField, publisherTextField, publicationDateTextField, publicationPlaceTextField, numberOfPagesTextField, contentTextField, editionTextField]
        
        for text in allTextFields {
            if let text = text {
                text.delegate = self
            }

        }
    }

}
