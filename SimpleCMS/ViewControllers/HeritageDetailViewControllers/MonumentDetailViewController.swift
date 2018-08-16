//
//  MonumentDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 10/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class MonumentDetailViewController: HeritageDetailViewController {
    // MARK: Properties
    
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
            setupMonumentModel(monument)
        }
        setupAllControls()
        updateSaveButtonState(with: requiredTextFields)
        print("Monument showing")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            print("er ging iets fout")
            return
        }
        monument = MonumentViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, monumentType: heritageTypeTextField.text!, pictureURL: pictureURL, protection: monumentIsProtectedSwitch.isOn, municipality: monumentMunicipalityTextField.text!, street: monumentStreetNameTextField.text!, houseNumber: nil, postalCode: nil, license: rightsLicenseTextField.text!, creditLine: creditLineTextField.text!, creator: monumentCreatorTextField.text, period: monumentCreationPeriodTextField.text, style: monumentStyleTextField.text)
        if let monument = monument {
            monument.primaryKey = UUID().uuidString
        }
    }
    
   
    
    // MARK: TextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState(with: requiredTextFields)
    }
    
    // MARK: Private methods
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
        

}
