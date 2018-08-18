//
//  MonumentDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 10/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class MonumentDetailViewController: HeritageDetailViewController {
    
    // MARK: Properties and outlets
    
    // monument
    var monument: MonumentViewModel?
    
    // outlets
    @IBOutlet weak var monumentIsProtectedSwitch: UISwitch!
    @IBOutlet weak var monumentStreetNameTextField: UITextField!
    @IBOutlet weak var monumentMunicipalityTextField: UITextField!
    @IBOutlet weak var monumentStreetNumberTextField: UITextField!
    @IBOutlet weak var monumentPostalCodeTextField: UITextField!
    @IBOutlet weak var monumentCreatorTextField: UITextField!
    @IBOutlet weak var monumentStyleTextField: UITextField!
    
    private var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, creditLineTextField, monumentCreatorTextField, heritageMaterialTextField, monumentStreetNameTextField, monumentStreetNumberTextField, monumentPostalCodeTextField, monumentMunicipalityTextField, monumentStyleTextField]
    }
    
    private var requiredTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, creditLineTextField, monumentMunicipalityTextField]
    }
    
    // MARK: ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(for: monument)
        setupTextFields(with: allTextFields, for: monument)
        if let monument = monument {
            updateVariables(monument)
            setupMonumentModel(monument)}
        setupAllControls()
        updateSaveButtonState(with: requiredTextFields)
        print("Monument showing")
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print(segue.identifier!)
        switch(segue.identifier) {
        case "did add monument"?:
            updateViewModel()
            guard let monument = monument else {
                fatalError("monument is nil")
            }
            monument.primaryKey = UUID().uuidString
            DatabaseService.service.create(monument)
            print("item saved")
        case "did edit monument"?:
            updateViewModel()
            guard let monument = monument else {
                fatalError("monument is nil")
            }
            DatabaseService.service.update(monument, with: .update)
        default:
            fatalError("Unknown segue")
            
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if monument == nil {
            performSegue(withIdentifier: "did add monument", sender: MonumentDetailViewController())
        } else {
            performSegue(withIdentifier: "did edit monument", sender: MonumentDetailViewController())
        }
        
    }
    
    // MARK: - TextFieldDelegate methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState(with: requiredTextFields)
    }
    
    // MARK: - Private methods
    
    private func setupAllControls() {
        if monument != nil {
            monumentIsProtectedSwitch.isUserInteractionEnabled = false
        }
    }
    
    private func setupMonumentModel(_ monument: MonumentViewModel){
        heritageIdTextField.text = monument.id
        heritageNameTextField.text = monument.name
        heritageTypeTextField.text = monument.monumentType
        monumentIsProtectedSwitch.isOn = monument.isProtected
        heritageImageView.image = monument.picture
        let rightsStatusIndex = rightsLicenses.index(of: rightsStatus ?? "Kies status")
        rightsLicensePicker.selectRow(rightsStatusIndex!, inComponent: 0, animated: false)
        creditLineTextField.text = monument.creditLine
        monumentMunicipalityTextField.text = monument.monumentLocationMunicipality
        monumentStreetNameTextField.text = monument.monumentLocationStreetName
        monumentPostalCodeTextField.text = monument.monumentLocationPostalCode
        monumentStreetNumberTextField.text = monument.monumentLocationNumber
        monumentCreatorTextField.text = monument.creator
        let creationPeriodIndex = creationPeriods.index(of: monument.period ?? "Kies periode")
        creationPeriodPicker.selectRow(creationPeriodIndex!, inComponent: 0, animated: false)
        heritageDescriptionTextView.text = monument.description
        heritageMaterialTextField.text = monument.material
        monumentStyleTextField.text = monument.style
        
    }
    
    private func updateViewModel() {
        if let monument = monument {
            monument.id = heritageId!
            monument.name = heritageNameTextField.text!
            monument.monumentType = heritageTypeTextField.text!
            monument.isProtected = monumentIsProtectedSwitch.isOn
            monument.rightsLicense = rightsStatus!
            monument.creditLine = creditLineTextField.text!
            monument.monumentLocationMunicipality = monumentMunicipalityTextField.text!
            monument.monumentLocationStreetName = monumentStreetNameTextField.text
            monument.monumentLocationNumber = monumentStreetNumberTextField.text
            monument.monumentLocationPostalCode = monumentPostalCodeTextField.text
            monument.creator = monumentCreatorTextField.text
            monument.period = heritageCreationPeriod
            monument.description = heritageDescription
            monument.material = heritageMaterialTextField.text
            monument.style = monumentStyleTextField.text
            monument.pictureURL = pictureURL
        }
        else {
            monument = MonumentViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, monumentType: heritageTypeTextField.text!, pictureURL: pictureURL, protection: monumentIsProtectedSwitch.isOn, municipality: monumentMunicipalityTextField.text!, street: monumentStreetNameTextField.text!, houseNumber: monumentStreetNumberTextField.text, postalCode: monumentPostalCodeTextField.text, license: rightsStatus!, creditLine: creditLineTextField.text!, creator: monumentCreatorTextField.text, period: heritageCreationPeriod, style: monumentStyleTextField.text)
            
        }
    }
    
    private func updateVariables(_ monument: MonumentViewModel) {
        self.heritageId = monument.id
        self.rightsStatus = monument.rightsLicense
        self.heritageCreationPeriod = monument.period
    }
        

}
