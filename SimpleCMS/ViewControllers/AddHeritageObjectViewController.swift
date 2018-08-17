//
//  AddHeritageObjectViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 2/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class AddHeritageObjectViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties and outlets
    
    @IBOutlet weak var idHeritageTextField: UITextField!
    @IBOutlet weak var nameHeritageTextField: UITextField!
    @IBOutlet weak var typeHeritageSegmentControl: UISegmentedControl!
    @IBOutlet weak var registrationButton: UIButton!

    @IBAction func startRegistering(_ sender: UIButton) {
        print(getSegueIdentifier(with: objectType))
        performSegue(withIdentifier: getSegueIdentifier(with: objectType), sender: AddHeritageObjectViewController())
        
    }
    
    var objectId: String?
    var objectName: String?
    var objectTypes: [HeritageObjectCategory] = [.artefact, .metalDetectingFind, .monument, .publication]
    var objectType : HeritageObjectCategory {
        return objectTypes[typeHeritageSegmentControl.selectedSegmentIndex]
    }
    
    // MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        idHeritageTextField.delegate = self
        nameHeritageTextField.delegate = self
        registrationButton.layer.cornerRadius = 5
        updateRegistrationButton()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? HeritageDetailViewController {
            viewController.heritageId = objectId
            viewController.heritageName = objectName
            viewController.navigationItem.title = "Voeg \(objectType.rawValue) toe"
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateRegistrationButton()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateRegistrationButton()
        textField.resignFirstResponder()
    }
    
    // MARK: - Private methods
    
    private func updateRegistrationButton() {
        objectId = idHeritageTextField?.text
        objectName = nameHeritageTextField.text
        registrationButton?.isHidden = objectId!.isEmpty || objectName!.isEmpty
        
    }
    
    private func getSegueIdentifier(with category: HeritageObjectCategory) -> String {
        switch(category){
        case .artefact:
            return "Add artefact"
        case .monument:
            return "Add monument"
        case .metalDetectingFind:
            return "Add find"
        case .publication:
            return "Add publication"
        }
    }
    
    

    

}
