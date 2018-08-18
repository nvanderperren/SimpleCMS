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
    
    // variables
    
    
    // readonly
    
    
    // outlets
    @IBOutlet weak var artefactCreatorTextField: UITextField!
    @IBOutlet weak var artefactCreationPlaceTextField: UITextField!
    @IBOutlet weak var artefactCreationDateTextField: UITextField!
    @IBOutlet weak var artefactCreationPeriodTextField: UITextField!
    @IBOutlet weak var artefactTechniqueTextField: UITextField!
    
    var requiredFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, acquisitionSourceTextField, creditLineTextField]
    }
    
    var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, acquisitionSourceTextField, creditLineTextField, artefactCreatorTextField, artefactCreationPlaceTextField, artefactCreationDateTextField, artefactCreationPeriodTextField,heritageDescriptionTextField, heritageMaterialTextField, artefactTechniqueTextField]
    }
    
    
    
    // MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Artefact showing")
        setupNavBar(for: artefact)
        setupTextFields(with: allTextFields, for: artefact)
        setupDatePicker()
        updateSaveButtonState(with: requiredFields)
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
        default:
            fatalError("Unknown segue")
            
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
        updateSaveButtonState(with: requiredFields)
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
        rightsLicenseTextField.text = artefact.rightsLicense
        creditLineTextField.text = artefact.creditLine
        artefactCreatorTextField.text = artefact.creator
        artefactCreationDateTextField.text = artefact.creationDate
        artefactCreationPlaceTextField.text = artefact.creationPlace
        artefactCreationPeriodTextField.text = artefact.creationPeriod
        heritageDescriptionTextField.text = artefact.description
        heritageMaterialTextField.text = artefact.material
        artefactTechniqueTextField.text = artefact.technique
        
    }
    
    private func updateVariables(_ artefact: ArtefactViewModel) {
        self.heritageId = artefact.id
        self.acquisitionMethod = artefact.acquisitionMethod
        self.acquisitionDate = artefact.acquisitionDate
        self.rightsStatus = artefact.rightsLicense
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
            artefact.creationPeriod = artefactCreationPeriodTextField.text
            artefact.description = heritageDescriptionTextField.text
            artefact.material = heritageMaterialTextField.text
            artefact.technique = artefactTechniqueTextField.text
            artefact.pictureURL = pictureURL
        }
        else {
            artefact = ArtefactViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, artefactType: heritageTypeTextField.text!, pictureURL: pictureURL, acquisitionSource: acquisitionSourceTextField.text!, acquisitionMethod: acquisitionMethod!, acquisitionDate: acquisitionDate!, rightsLicense: rightsStatus!, creditLine: creditLineTextField.text!, creator: artefactCreatorTextField.text, creationPlace: artefactCreationPlaceTextField.text, creationDate: artefactCreationDateTextField.text, creationPeriod: artefactCreationPeriodTextField.text, material: heritageMaterialTextField.text, technique: artefactTechniqueTextField.text, description: heritageDescriptionTextField.text, size: nil)
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


