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
    
    var monument: MonumentViewModel?
    
    @IBOutlet weak var monumentIsProtectedSwitch: UISwitch!
    @IBOutlet weak var monumentStreetNameTextField: UITextField!
    @IBOutlet weak var monumentMunicipalityTextField: UITextField!
    @IBOutlet weak var monumentCreatorTextField: UITextField!
    @IBOutlet weak var monumentCreationPeriodTextField: UITextField!
    @IBOutlet weak var monumentStyleTextField: UITextField!
    
    private var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, rightsLicenseTextField,  creditLineTextField, monumentCreatorTextField, monumentCreationPeriodTextField,heritageDescriptionTextField, heritageMaterialTextField, monumentStreetNameTextField, monumentMunicipalityTextField, monumentStyleTextField]
    }
    
    private var requiredTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, heritageTypeTextField, rightsLicenseTextField, creditLineTextField, monumentMunicipalityTextField]
    }
    
    // MARK: ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(for: monument)
        setupTextFields(with: allTextFields, for: monument)
        if let monument = monument {
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
        rightsLicenseTextField.text = monument.rightsLicense
        creditLineTextField.text = monument.creditLine
        monumentMunicipalityTextField.text = monument.monumentLocationMunicipality
        monumentCreatorTextField.text = monument.creator
        monumentCreationPeriodTextField.text = monument.period
        heritageDescriptionTextField.text = monument.description
        heritageMaterialTextField.text = monument.material
        monumentStyleTextField.text = monument.style
        self.heritageId = monument.id
    }
    
    private func updateViewModel() {
        if let monument = monument {
            monument.id = heritageId!
            monument.name = heritageNameTextField.text!
            monument.monumentType = heritageTypeTextField.text!
            monument.isProtected = monumentIsProtectedSwitch.isOn
            monument.rightsLicense = rightsLicenseTextField.text!
            monument.creditLine = creditLineTextField.text!
            monument.monumentLocationMunicipality = monumentMunicipalityTextField.text!
            monument.creator = monumentCreatorTextField.text
            monument.period = monumentCreationPeriodTextField.text
            monument.description = heritageDescriptionTextField.text
            monument.material = heritageMaterialTextField.text
            monument.style = monumentStyleTextField.text
            monument.pictureURL = pictureURL
        }
        else {
            monument = MonumentViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, monumentType: heritageTypeTextField.text!, pictureURL: pictureURL, protection: monumentIsProtectedSwitch.isOn, municipality: monumentMunicipalityTextField.text!, street: monumentStreetNameTextField.text!, houseNumber: nil, postalCode: nil, license: rightsLicenseTextField.text!, creditLine: creditLineTextField.text!, creator: monumentCreatorTextField.text, period: monumentCreationPeriodTextField.text, style: monumentStyleTextField.text)
            
        }
    }
        

}
