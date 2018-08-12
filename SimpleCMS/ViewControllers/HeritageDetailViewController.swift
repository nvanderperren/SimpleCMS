//
//  HeritageDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 10/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageDetailViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var heritageId: String?
    var heritageName: String?
    var heritageObject: HeritageViewModel?
    
    @IBOutlet weak var heritageIdTextField: UITextField!
    @IBOutlet weak var heritageNameTextField: UITextField!
    @IBOutlet weak var heritageTypeTextField: UITextField!
    @IBOutlet weak var HeritageImageView: UIImageView!
    
    
    @IBAction func chooseImageFromSavedPhotos(_ sender: UIButton) {
       setupImagePickerController(type: .photoLibrary)
    }
    
    
    @IBAction func takePicture(_ sender: UIButton) {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController(title: nil, message: "Het toestel heeft geen camera.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            
        }
        else {
            setupImagePickerController(type: .camera)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    
    // MARK: ImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage  else {
            fatalError("Expected a dictionary containing an image, but is was provided following: \(info)")
        }
        
        HeritageImageView.image = selectedImage
        if (picker.sourceType == .camera) {
            UIImageWriteToSavedPhotosAlbum(selectedImage, self, nil, nil)
        }
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Private methods
    
    private func setupTableView() {
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        self.tableView.allowsSelection = false
        self.tableView.allowsSelectionDuringEditing = false
    }
    
    private func setupNavBar() {
        if let heritageObject = heritageObject {
            navigationItem.title = heritageObject.id
        }
    }
    
    private func setupImagePickerController(type: UIImagePickerControllerSourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    
}
