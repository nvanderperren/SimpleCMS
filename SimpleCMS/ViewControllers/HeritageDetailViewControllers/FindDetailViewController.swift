//
//  FindDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 11/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class FindDetailViewController: HeritageDetailViewController {
    
    // MARK: - Properties and outlets
    
    var find: FindViewModel?
    
    @IBOutlet weak var findDateTextField: UITextField!
    @IBOutlet weak var findPlaceTypeTextField: UITextField!
    @IBOutlet weak var findLocationTextField: UITextField!
    @IBOutlet weak var findTechniqueTextField: UITextField!
    @IBOutlet weak var findInscriptionTextField: UITextField!
    
    private var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, acquisitionMethodTextField, acquisitionSourceTextField, acquisitionDateTextField, findDateTextField, findLocationTextField, findPlaceTypeTextField,heritageDescriptionTextField, heritageMaterialTextField, findTechniqueTextField, findInscriptionTextField]
    }
    
    private var requiredTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField]
    }
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Find showing")
        setupNavBar(for: find)
        setupTextFields(with: allTextFields, for: find)
        updateSaveButtonState(with: requiredTextFields)
        if let find = find {
            setupFindModel(find)
        }
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print(segue.identifier!)
        switch(segue.identifier) {
        case "did add find"?:
            find = FindViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, objectType: heritageTypeTextField.text!, pictureURL: pictureURL, findDate: findDateTextField.text, findPlaceType: findPlaceTypeTextField.text, findPlace: findLocationTextField.text, inscription: findInscriptionTextField.text)
            guard let find = find else {
                fatalError("find is nil")
            }
            find.primaryKey = UUID().uuidString
            DatabaseService.service.create(find)
            print("item saved")
        case "did edit find"?:
            guard let find = find else {
                fatalError("find is nil")
            }
            DatabaseService.service.update(find)
        default:
            fatalError("Unknown segue")
        }
        // controleer dit!
        
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if find == nil {
            performSegue(withIdentifier: "did add find", sender: FindDetailViewController())
        } else {
            performSegue(withIdentifier: "did edit find", sender: FindDetailViewController())
        }
        
    }
    
    // MARK: - TextFieldDelegate methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState(with: requiredTextFields)
    }
    
    // MARK: - Private methods
    
    private func setupFindModel(_ find: FindViewModel){
        heritageIdTextField.text = find.id
        heritageNameTextField.text = find.name
        heritageTypeTextField.text = find.objectType
        heritageImageView.image = find.picture
        acquisitionMethodTextField.text = find.acquisitionMethod
        acquisitionSourceTextField.text = find.acquisitionSource
        acquisitionDateTextField.text = find.acquisitionDate
        findDateTextField.text = find.findDate
        findPlaceTypeTextField.text = find.findPlaceType
        findLocationTextField.text = find.findPlace
        heritageDescriptionTextField.text = find.description
        heritageMaterialTextField.text = find.material
        findTechniqueTextField.text = find.technique
        findInscriptionTextField.text = find.inscription
        self.heritageId = find.id
    }
}
