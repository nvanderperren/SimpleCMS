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
    
    // model
    var find: FindViewModel?
    var dimensionUnits = ["mm", "cm"]
    
    
    // variables
    private var findPlaceType: String? {
        didSet {
            if (findPlaceType == "Kies type") {
                findPlaceType = nil
            }
        }
    }
    
    private var findTechnique: String? {
        didSet {
            if (findTechnique == "Kies techniek") {
                findTechnique = nil
            }
        }
    }
    
    // readonly
    private var findPlaceTypes = Seeder.service.getHeritagePlaceTypes()
    private var techniques = Seeder.service.getTechniques()
    private var findObjectTypes = Seeder.service.getFindObjectTyptes().sorted{$0 < $1}
    
    // outlets
    @IBOutlet weak var findLocationTextField: UITextField!
    @IBOutlet weak var findInscriptionTextField: UITextField!
    @IBOutlet weak var findPlaceTypePickerField: UIPickerView!
    @IBOutlet weak var findTechniquePicker: UIPickerView!
    @IBOutlet weak var dimensionLengthTextField: UITextField!
    @IBOutlet weak var dimensionWidthTextField: UITextField!
    @IBOutlet weak var dimensionDepthTextField: UITextField!
    @IBOutlet weak var dimensionLengthSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dimensionWidthSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dimensionDepthSegmentedControl: UISegmentedControl!
    
    
    private var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, acquisitionSourceTextField, findLocationTextField, heritageMaterialTextField, findInscriptionTextField, dimensionLengthTextField, dimensionWidthTextField, dimensionDepthTextField]
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
        setupDatePicker()
        saveButton.isEnabled = updateSaveButtonState(with: requiredTextFields, and: nil)
        if let find = find {
            updateVariables(find)
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
        case "choose findtype"?:
            if let destinationController = segue.destination as? UINavigationController, let target = destinationController.topViewController as? ListTableViewController {
                target.data = findObjectTypes
                target.action = "did choose findType"
            }
        case "choose findMaterial"?:
            if let destinationController = segue.destination as? UINavigationController, let target = destinationController.topViewController as? ListTableViewController {
                target.data = materials
                target.action = "did choose findMaterial"
            }
        default:
            fatalError("Unknown segue")
        }
        // controleer dit!
        
    }
    
    @IBAction func itemInFindListChosen(_ segue: UIStoryboardSegue) {
        switch(segue.identifier) {
        case "did choose findType"?:
            if let source = segue.source as? ListTableViewController {
                heritageTypeTextField.text = source.value
            }
        case "did choose findMaterial"?:
            if let source = segue.source as? ListTableViewController {
                heritageMaterialTextField.text = source.value
            }
        default:
            fatalError("segue does not exist")
        }
        
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
       saveButton.isEnabled = updateSaveButtonState(with: requiredTextFields, and: nil)
    }
    
    // MARK: - Picker
    
    // MARK: PickerDataSource
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
        case 3:
            return creationPeriods.count
        case 4:
            return techniques.count
        default:
            fatalError()
        }
    }
    
    // MARK: PickerDelegate
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView.tag){
        case 0:
            acquisitionMethod = acquisitionMethods[row]
            print(acquisitionMethod ?? "method is nil")
        case 1:
            findPlaceType = findPlaceTypes[row]
            print(findPlaceType ?? "findplacetype is nil")
        case 3:
            heritageCreationPeriod = creationPeriods[row]
            print(heritageCreationPeriod ?? "creationPeriod is nil")
        case 4:
            findTechnique = techniques[row]
            print(findTechnique ?? "findTechnique is nil")
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
        case 3:
            return creationPeriods[row]
        case 4:
            return techniques[row]
        default:
            fatalError()
        }
        
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
        acquistionDatePicker.date = convertStringToDate(acquisitionDate)
        let findplaceStatus = findPlaceTypes.index(of: find.findPlaceType ?? "Kies type")
        findPlaceTypePickerField.selectRow(findplaceStatus!, inComponent: 0, animated: true)
        findLocationTextField.text = find.findPlace
        heritageDescriptionTextView.text = find.description
        heritageMaterialTextField.text = find.material
        let techniqueIndex = techniques.index(of: find.technique ?? "Kies techniek")
        findTechniquePicker.selectRow(techniqueIndex!, inComponent: 0, animated: false)
        findInscriptionTextField.text = find.inscription
        let creationPeriodIndex = creationPeriods.index(of: heritageCreationPeriod ?? "Kies periode")
        creationPeriodPicker.selectRow(creationPeriodIndex!, inComponent: 0, animated: false)
        dimensionLengthTextField.text = find.sizeLength
        dimensionWidthTextField.text = find.sizeWidth
        dimensionDepthTextField.text = find.sizeDepth
        dimensionLengthSegmentedControl.selectedSegmentIndex = dimensionUnits.index(of: find.sizeLengthUnit ?? "mm") ?? 0
        dimensionWidthSegmentedControl.selectedSegmentIndex = dimensionUnits.index(of: find.sizeWidthUnit ?? "mm") ?? 0
        dimensionDepthSegmentedControl.selectedSegmentIndex = dimensionUnits.index(of: find.sizeDepthUnit ?? "mm") ?? 0
        
        
    }
    
    private func updateViewModel() {
        if let find = find {
            find.id = heritageId!
            find.name = heritageNameTextField.text!
            find.objectType = heritageTypeTextField.text!
            find.acquisitionMethod = acquisitionMethod
            find.acquisitionSource = acquisitionSourceTextField.text
            find.acquisitionDate = acquisitionDate
            find.findPlaceType = findPlaceType
            find.findPlace = findLocationTextField.text
            find.description = heritageDescription
            find.material = heritageMaterialTextField.text
            find.technique = findTechnique
            find.inscription = findInscriptionTextField.text
            find.description = heritageDescriptionTextView.text
            find.period = heritageCreationPeriod
            find.pictureURL = pictureURL
            find.sizeLength = dimensionLengthTextField.text
            find.sizeLengthUnit = dimensionUnits[dimensionLengthSegmentedControl.selectedSegmentIndex]
            find.sizeWidth = dimensionWidthTextField.text
            find.sizeWidthUnit = dimensionUnits[dimensionWidthSegmentedControl.selectedSegmentIndex]
            find.sizeDepth = dimensionDepthTextField.text
            find.sizeDepthUnit = dimensionUnits[dimensionDepthSegmentedControl.selectedSegmentIndex]
            find.acquisitionSource = acquisitionSourceTextField.text
            find.acquisitionDate = acquisitionDate
            find.acquisitionMethod = acquisitionMethod
            
        } else {
            find = FindViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, objectType: heritageTypeTextField.text!, pictureURL: pictureURL, findPlaceType: findPlaceType, findPlace: findLocationTextField.text, inscription: findInscriptionTextField.text, description: heritageDescriptionTextView.text, period: heritageCreationPeriod, technique: findTechnique, length: dimensionLengthTextField.text, lengthUnit: dimensionUnits[dimensionLengthSegmentedControl.selectedSegmentIndex], width: dimensionWidthTextField.text, widthUnit: dimensionUnits[dimensionWidthSegmentedControl.selectedSegmentIndex], depth: dimensionDepthTextField.text, depthUnit: dimensionUnits[dimensionDepthSegmentedControl.selectedSegmentIndex], acquisitionSource: acquisitionSourceTextField.text, acquisitionMethod: acquisitionMethod, acquisitionDate: acquisitionDate)
        }
    }
    
    private func updateVariables(_ find: FindViewModel) {
        heritageId = find.id
        findPlaceType = find.findPlaceType
        acquisitionMethod = find.acquisitionMethod
        acquisitionDate = find.acquisitionDate
        self.pictureURL = find.pictureURL

        
    }
    
    private func setupDatePicker() {
        if find != nil {
            acquistionDatePicker.maximumDate = convertStringToDate(find?.acquisitionDate)
        } else {
            acquistionDatePicker.maximumDate = Date()
        }
    }
}
