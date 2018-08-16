//
//  HeritageObjectDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 8/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class ArtefactDetailViewController: HeritageDetailViewController {
    
    var artefact: ArtefactViewModel?
    
    @IBOutlet weak var artefactCreatorTextField: UITextField!
    @IBOutlet weak var artefactCreationPlaceTextField: UITextField!
    @IBOutlet weak var artefactCreationDateTextField: UITextField!
    @IBOutlet weak var artefactCreationPeriodTextField: UITextField!
    @IBOutlet weak var artefactTechniqueTextField: UITextField!
    
    var requiredFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, acquisitionDateTextField, acquisitionSourceTextField, acquisitionMethodTextField, rightsLicenseTextField, creditLineTextField]
    }
    
    var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, acquisitionMethodTextField, acquisitionSourceTextField, acquisitionDateTextField, rightsLicenseTextField,  creditLineTextField, artefactCreatorTextField, artefactCreationPlaceTextField, artefactCreationDateTextField, artefactCreationPeriodTextField,heritageDescriptionTextField, heritageMaterialTextField, artefactTechniqueTextField]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Artefact showing")
        setupNavBar(for: artefact)
        setupTextFields(with: allTextFields, for: artefact)
        updateSaveButtonState(with: requiredFields)

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if let artefact = artefact {
            setupArtefactModel(artefact)
            saveButton = self.editButtonItem
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            print("er ging iets fout")
            return
        }
        artefact = ArtefactViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, artefactType: heritageTypeTextField.text!, pictureURL: pictureURL, acquisitionSource: acquisitionSourceTextField.text!, acquisitionMethod: acquisitionMethodTextField.text!, acquisitionDate: acquisitionDateTextField.text!, rightsLicense: rightsLicenseTextField.text!, creditLine: creditLineTextField.text!, creator: artefactCreatorTextField.text, creationPlace: artefactCreationPlaceTextField.text, creationDate: artefactCreationDateTextField.text, creationPeriod: artefactCreationPeriodTextField.text, material: heritageMaterialTextField.text, technique: artefactTechniqueTextField.text, description: heritageDescriptionTextField.text, size: nil)
        if let artefact = artefact {
            artefact.primaryKey = UUID().uuidString
        }
        print("item saved")
        print("\(artefact!.creditLine!)")
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState(with: requiredFields)
    }
    
    private func setupArtefactModel(_ artefact: ArtefactViewModel){
        heritageIdTextField.text = artefact.id
        heritageNameTextField.text = artefact.name
        heritageTypeTextField.text = artefact.artefactType
        heritageImageView.image = artefact.picture
        acquisitionMethodTextField.text = artefact.acquisitionMethod
        acquisitionSourceTextField.text = artefact.acquisitionSource
        acquisitionDateTextField.text = artefact.acquisitionDate
        rightsLicenseTextField.text = artefact.rightsLicense
        creditLineTextField.text = artefact.creditLine
        artefactCreatorTextField.text = artefact.creator
        artefactCreationDateTextField.text = artefact.creationDate
        artefactCreationPlaceTextField.text = artefact.creationPlace
        artefactCreationPeriodTextField.text = artefact.creationPeriod
        heritageDescriptionTextField.text = artefact.description
        heritageMaterialTextField.text = artefact.material
        artefactTechniqueTextField.text = artefact.technique
        self.heritageId = artefact.id
    }


}
