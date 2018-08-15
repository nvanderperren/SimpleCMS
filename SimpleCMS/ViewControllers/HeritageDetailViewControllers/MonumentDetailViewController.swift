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
    
    // MARK: Methods
//    @IBAction func saveMonumentItem(_ sender: UIBarButtonItem) {
//        monument = MonumentViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, monumentType: heritageTypeTextField.text!, protection: monumentIsProtectedSwitch.isOn, municipality: monumentMunicipalityTextField.text!, street: monumentStreetNameTextField.text!, houseNumber: nil, postalCode: nil, license: rightsLicenseTextField.text!, creditLine: creditLineTextField.text!, creator: monumentCreatorTextField.text, period: monumentCreationPeriodTextField.text, style: monumentStyleTextField.text)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            print("er ging iets fout")
            return
        }
        monument = MonumentViewModel(id: heritageIdTextField.text!, name: heritageNameTextField.text!, monumentType: heritageTypeTextField.text!, pictureURL: pictureURL, protection: monumentIsProtectedSwitch.isOn, municipality: monumentMunicipalityTextField.text!, street: monumentStreetNameTextField.text!, houseNumber: nil, postalCode: nil, license: rightsLicenseTextField.text!, creditLine: creditLineTextField.text!, creator: monumentCreatorTextField.text, period: monumentCreationPeriodTextField.text, style: monumentStyleTextField.text)
    }
    
    // MARK: ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(for: monument)
        setupTextFields(with: allTextFields, for: monument)
        setupAllControls()
        updateSaveButtonState(with: requiredTextFields)
        print("Monument showing")
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
        

}
