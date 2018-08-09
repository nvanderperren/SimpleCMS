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
    
    var objectId: String?
    var objectName: String?
    var objectTypes: [HeritageObjectCategory] = [.artefact, .metalDetectingFind, .monument, .publication]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idHeritageTextField.delegate = self
        nameHeritageTextField.delegate = self
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
        let objectType = objectTypes[typeHeritageSegmentControl.selectedSegmentIndex]
        if case segue.identifier = getSegueIdentifier(with: objectType) {
            switch(segue.identifier) {
            case "Add artefact":
                print("artefact")
            default:
                print("iets")
            }
        }
        if let destinationViewController = segue.destination as? UINavigationController,
        let targetController = destinationViewController.topViewController as?
        HeritageObjectDetailViewController {
            targetController.objectId = objectId
            targetController.objectName = objectName
            targetController.navigationItem.title = "Voeg \(objectType.rawValue.lowercased()) toe"
        
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
