//
//  AddHeritageObjectViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 2/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class AddHeritageObjectViewController: UIViewController, UITextFieldDelegate {
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idHeritageTextField.delegate = self
        nameHeritageTextField.delegate = self
        registrationButton.layer.cornerRadius = 5
        updateRegistrationButton()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateRegistrationButton()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateRegistrationButton()
        textField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let viewController = segue.destination as? UINavigationController,
                let targetController = viewController.topViewController as? HeritageDetailViewController {
                targetController.heritageId = objectId
                targetController.heritageName = objectName
                targetController.navigationItem.title = "Voeg \(objectType.rawValue) toe"
            
            
        }
    }
    
    
    
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
