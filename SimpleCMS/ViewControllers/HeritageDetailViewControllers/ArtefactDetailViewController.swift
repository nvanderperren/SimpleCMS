//
//  HeritageObjectDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 8/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class ArtefactDetailViewController: HeritageDetailViewController {
    
    // MARK: - Properties and outlets
    
    // model
    var artefact: ArtefactViewModel?
    var dimensionUnits = ["mm", "cm"]
    
    // readonly
    let artefactTypes = Seeder.service.getObjectTypes().sorted{$0 < $1}
    
    override var acquisitionMethod: String? {
        didSet {
            if (acquisitionMethod == "Kies methode") {
                acquisitionMethod = nil
            }
            saveButton.isEnabled = updateSaveButtonState(with: requiredFields, and: requiredVariables)
        }
    }
    
    override var rightsStatus: String? {
        didSet {
            if (rightsStatus == "Kies status") {
                rightsStatus = nil
            }
            saveButton.isEnabled = updateSaveButtonState(with: requiredFields, and: requiredVariables)
        }
    }
    
    override var acquisitionDate: String? {
        didSet {
            saveButton.isEnabled = updateSaveButtonState(with: requiredFields, and: requiredVariables)
        }
    }
    
    // outlets
    @IBOutlet weak var artefactCreatorTextField: UITextField!
    @IBOutlet weak var artefactCreationPlaceTextField: UITextField!
    @IBOutlet weak var artefactCreationDateTextField: UITextField!
    @IBOutlet weak var dimensionLengthTextField: UITextField!
    @IBOutlet weak var dimensionWidthTextField: UITextField!
    @IBOutlet weak var dimensionDepthTextField: UITextField!
    @IBOutlet weak var dimensionLengthSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dimensionWidthSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dimensionDepthSegmentedControl: UISegmentedControl!
    
    
    
    
    var requiredFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, acquisitionSourceTextField, creditLineTextField]
    }
    
    var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, acquisitionSourceTextField, creditLineTextField, artefactCreatorTextField, artefactCreationPlaceTextField, artefactCreationDateTextField, heritageMaterialTextField, dimensionDepthTextField, dimensionWidthTextField, dimensionLengthTextField]
    }
    
    var requiredVariables: [String?] {
        return [acquisitionMethod, rightsStatus, acquisitionDate]
    }
    
    
    
    // MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Artefact showing")
        setupNavBar(for: artefact)
        setupTextFields(with: allTextFields, for: artefact)
        setupDatePicker()
        saveButton.isEnabled = updateSaveButtonState(with: requiredFields, and: requiredVariables)
        if let artefact = artefact {
            updateVariables(artefact)
            setupArtefactModel(artefact)

            
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print(segue.identifier!)
        switch(segue.identifier) {
        case "did add artefact"?:
            updateViewModel()
            guard let artefact = artefact else {
                fatalError("something went wrong, artefact is nil")
            }
            artefact.primaryKey = UUID().uuidString
            DatabaseService.service.create(artefact)
            print("item saved")
            print("\(artefact.creditLine)")
        case "did edit artefact"?:
            updateViewModel()
            guard let artefact = artefact else {
                fatalError("Something went wrong, artefact is nil")
            }
            DatabaseService.service.update(artefact, with: .update)
        case "choose artefact"?:
            if let destinationController = segue.destination as? UINavigationController, let target = destinationController.topViewController as? ListTableViewController {
                target.data = artefactTypes
                target.action = "did choose artefact"
            }
        case "choose material"?:
            if let destinationController = segue.destination as? UINavigationController, let target = destinationController.topViewController as? ListTableViewController {
                target.data = materials
                target.action = "did choose artefactMaterial"
            }
        default:
            fatalError("Unknown segue")
            
        }
        
    }
    
    @IBAction func itemInListChosen(_ segue: UIStoryboardSegue){
        switch (segue.identifier) {
        case "did choose artefact":
            if let source = segue.source as? ListTableViewController {
                heritageTypeTextField.text = source.value
            }
        case "did choose artefactMaterial":
            if let source = segue.source as? ListTableViewController {
                heritageMaterialTextField.text = source.value
            }
        default:
            fatalError()
        }
    
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if artefact == nil {
            performSegue(withIdentifier: "did add artefact", sender: ArtefactDetailViewController())
        } else {
            performSegue(withIdentifier: "did edit artefact", sender: ArtefactDetailViewController())
        }
        
    }
    
    // MARK: - TextFieldDelegate methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isEnabled = updateSaveButtonState(with: requiredFields, and: requiredVariables)
        if textField == artefactCreationDateTextField {
            checkIfStringHasEnoughNumbers(artefactCreationDateTextField.text ?? "", count: 4)
        }
        if textField == dimensionLengthTextField {
            checkForNumericValue(dimensionLengthTextField.text ?? "")
        }
        if textField == dimensionWidthTextField {
            checkForNumericValue(dimensionWidthTextField.text ?? "")
        }
        if textField == dimensionDepthTextField {
            checkForNumericValue(dimensionDepthTextField.text ?? "")
        }
    }
    
    
    
    // MARK: - Private methods
    
    private func setupArtefactModel(_ artefact: ArtefactViewModel){
        heritageIdTextField.text = artefact.id
        heritageNameTextField.text = artefact.name
        heritageTypeTextField.text = artefact.artefactType
        heritageImageView.image = artefact.picture
        let acquistionMethodStatus = acquisitionMethods.index(of: acquisitionMethod ?? "Kies methode")
        acquisitionMethodPicker.selectRow(acquistionMethodStatus!, inComponent: 0, animated: false)
        acquisitionSourceTextField.text = artefact.acquisitionSource
        acquistionDatePicker.date = convertStringToDate(acquisitionDate!)
        let rightsStatusIndex = rightsLicenses.index(of: rightsStatus ?? "Kies status")
        rightsLicensePicker.selectRow(rightsStatusIndex!, inComponent: 0, animated: false)
        creditLineTextField.text = artefact.creditLine
        artefactCreatorTextField.text = artefact.creator
        artefactCreationDateTextField.text = artefact.creationDate
        artefactCreationPlaceTextField.text = artefact.creationPlace
        let creationPeriodIndex = creationPeriods.index(of: heritageCreationPeriod ?? "Kies periode")
        creationPeriodPicker.selectRow(creationPeriodIndex!, inComponent: 0, animated: false)
        heritageDescriptionTextView.text = artefact.description
        heritageMaterialTextField.text = artefact.material
        dimensionLengthTextField.text = artefact.sizeLength
        dimensionWidthTextField.text = artefact.sizeWidth
        dimensionDepthTextField.text = artefact.sizeDepth
        dimensionLengthSegmentedControl.selectedSegmentIndex = dimensionUnits.index(of: artefact.sizeLengthUnit ?? "mm") ?? 0
        dimensionWidthSegmentedControl.selectedSegmentIndex = dimensionUnits.index(of: artefact.sizeWidthUnit ?? "mm") ?? 0
        dimensionDepthSegmentedControl.selectedSegmentIndex = dimensionUnits.index(of: artefact.sizeDepthUnit ?? "mm") ?? 0
        
    }
    
    private func updateVariables(_ artefact: ArtefactViewModel) {
        self.heritageId = artefact.id
        self.acquisitionMethod = artefact.acquisitionMethod
        self.acquisitionDate = artefact.acquisitionDate
        self.rightsStatus = artefact.rightsLicense
        self.heritageCreationPeriod = artefact.creationPeriod
        self.pictureURL = artefact.pictureURL
        
    }
    
    private func updateViewModel() {
        if let artefact = artefact {
            artefact.id = heritageId!
            artefact.name = heritageNameTextField.text!
            artefact.artefactType = heritageTypeTextField.text!
            artefact.acquisitionMethod = acquisitionMethod!
            artefact.acquisitionDate = acquisitionDate!
            artefact.acquisitionSource = acquisitionSourceTextField.text!
            artefact.acquisitionDate = acquisitionDate
            artefact.rightsLicense = rightsStatus!
            artefact.creditLine = creditLineTextField.text!
            artefact.creator = artefactCreatorTextField.text
            artefact.creationDate = artefactCreationDateTextField.text
            artefact.creationPlace = artefactCreationPlaceTextField.text
            artefact.creationPeriod = heritageCreationPeriod
            artefact.description = heritageDescription
            artefact.material = heritageMaterialTextField.text
            artefact.pictureURL = pictureURL
            artefact.sizeLengthUnit = dimensionUnits[dimensionLengthSegmentedControl.selectedSegmentIndex]
            artefact.sizeWidth = dimensionWidthTextField.text
            artefact.sizeWidthUnit = dimensionUnits[dimensionWidthSegmentedControl.selectedSegmentIndex]
            artefact.sizeDepth = dimensionDepthTextField.text
            artefact.sizeDepthUnit = dimensionUnits[dimensionDepthSegmentedControl.selectedSegmentIndex]
        }
        else {
            artefact = ArtefactViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, artefactType: heritageTypeTextField.text!, pictureURL: pictureURL, acquisitionSource: acquisitionSourceTextField.text!, acquisitionMethod: acquisitionMethod!, acquisitionDate: acquisitionDate!, rightsLicense: rightsStatus!, creditLine: creditLineTextField.text!, creator: artefactCreatorTextField.text, creationPlace: artefactCreationPlaceTextField.text, creationDate: artefactCreationDateTextField.text, creationPeriod: heritageCreationPeriod, material: heritageMaterialTextField.text, description: heritageDescription, length: dimensionLengthTextField.text, lengthUnit: dimensionUnits[dimensionLengthSegmentedControl.selectedSegmentIndex], width: dimensionWidthTextField.text, widthUnit: dimensionUnits[dimensionWidthSegmentedControl.selectedSegmentIndex], depth: dimensionDepthTextField.text, depthUnit: dimensionUnits[dimensionDepthSegmentedControl.selectedSegmentIndex])
        }
    }
    
    private func setupDatePicker() {
        if artefact != nil {
            acquistionDatePicker.maximumDate = convertStringToDate(artefact?.acquisitionDate)
        } else {
            acquistionDatePicker.maximumDate = Date()
        }
    }
    
}



