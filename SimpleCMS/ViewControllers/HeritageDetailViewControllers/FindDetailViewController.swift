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
            updateViewModel()
            guard let find = find else {
                fatalError("find is nil")
            }
            find.primaryKey = UUID().uuidString
            DatabaseService.service.create(find)
            print("item saved")
        case "did edit find"?:
            updateViewModel()
            guard let find = find else {
                fatalError("find is nil")
            }
            DatabaseService.service.update(find, with: .update)
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
    
    private func updateViewModel() {
        if let find = find {
            find.id = heritageId!
            find.name = heritageNameTextField.text!
            find.objectType = heritageTypeTextField.text!
            find.acquisitionMethod = acquisitionMethodTextField.text
            find.acquisitionSource = acquisitionSourceTextField.text
            find.acquisitionDate = acquisitionDateTextField.text
            find.findDate = findDateTextField.text
            find.findPlaceType = findPlaceTypeTextField.text
            find.findPlace = findLocationTextField.text
            find.description = heritageDescriptionTextField.text
            find.material = heritageMaterialTextField.text
            find.technique = findTechniqueTextField.text
            find.inscription = findInscriptionTextField.text
            find.pictureURL = pictureURL
        } else {
            find = FindViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, objectType: heritageTypeTextField.text!, pictureURL: pictureURL, findDate: findDateTextField.text, findPlaceType: findPlaceTypeTextField.text, findPlace: findLocationTextField.text, inscription: findInscriptionTextField.text)
        }
    }
}
