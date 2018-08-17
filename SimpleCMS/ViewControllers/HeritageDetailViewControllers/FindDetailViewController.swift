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
    @IBOutlet weak var findLocationTextField: UITextField!
    @IBOutlet weak var findTechniqueTextField: UITextField!
    @IBOutlet weak var findInscriptionTextField: UITextField!
    @IBOutlet weak var findPlaceTypePickerField: UIPickerView!
    private var findPlaceType: String? {
        didSet {
            if (findPlaceType == "Kies type") {
                findPlaceType = nil
            }
        }
    }
    private var findPlaceTypes = Seeder.service.getHeritagePlaceTypes()
    
    
    
    private var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, acquisitionSourceTextField, findDateTextField, findLocationTextField, heritageDescriptionTextField, heritageMaterialTextField, findTechniqueTextField, findInscriptionTextField]
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
        print("save button clicked")
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
        let acquistionMethodStatus = acquisitionMethods.index(of: find.acquisitionMethod ?? "Kies methode")
        acquisitionMethodPicker.selectRow(acquistionMethodStatus!, inComponent: 0, animated: true)
        acquisitionSourceTextField.text = find.acquisitionSource
        //acquisitionDateTextField.text = find.acquisitionDate
        findDateTextField.text = find.findDate
        let findplaceStatus = findPlaceTypes.index(of: find.findPlaceType ?? "Kies type")
        findPlaceTypePickerField.selectRow(findplaceStatus!, inComponent: 0, animated: true)
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
            find.acquisitionMethod = acquisitionMethod
            find.acquisitionSource = acquisitionSourceTextField.text
            find.acquisitionDate = nil
            find.findDate = findDateTextField.text
            find.findPlaceType = findPlaceType
            find.findPlace = findLocationTextField.text
            find.description = heritageDescriptionTextField.text
            find.material = heritageMaterialTextField.text
            find.technique = findTechniqueTextField.text
            find.inscription = findInscriptionTextField.text
            find.pictureURL = pictureURL
        } else {
            find = FindViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, objectType: heritageTypeTextField.text!, pictureURL: pictureURL, findDate: findDateTextField.text, findPlaceType: findPlaceType, findPlace: findLocationTextField.text, inscription: findInscriptionTextField.text)
        }
    }
    
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch (pickerView.tag){
        default:
            return 1
        }
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView.tag){
        case 0:
            return acquisitionMethods.count
        case 1:
            return findPlaceTypes.count
        default:
            fatalError()
        }
    }
    
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView.tag){
        case 0:
            acquisitionMethod = acquisitionMethods[row]
            print(acquisitionMethod ?? "method is nil")
        case 1:
            findPlaceType = findPlaceTypes[row]
            print(findPlaceType ?? "findplacetype is nil")
        default:
            fatalError()
        }
        
    }
    
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (pickerView.tag){
        case 0:
            return acquisitionMethods[row]
        case 1:
            return findPlaceTypes[row]
        default:
            fatalError()
        }
        
    }
}

    

