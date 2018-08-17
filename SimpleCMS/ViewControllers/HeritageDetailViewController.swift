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
    var pictureURL: String?
    
    @IBOutlet weak var heritageIdTextField: UITextField!
    @IBOutlet weak var heritageNameTextField: UITextField!
    @IBOutlet weak var heritageTypeTextField: UITextField!
    @IBOutlet weak var heritageImageView: UIImageView!
    @IBOutlet weak var acquisitionMethodTextField: UITextField!
    @IBOutlet weak var acquisitionSourceTextField: UITextField!
    @IBOutlet weak var acquisitionDateTextField: UITextField!
    @IBOutlet weak var rightsLicenseTextField: UITextField!
    @IBOutlet weak var creditLineTextField: UITextField!
    @IBOutlet weak var heritageDescriptionTextField: UITextField!
    @IBOutlet weak var heritageMaterialTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
//    var allTextFields = [UITextField?]()
    
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
        updateFields()
//        setupAllTextFields()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: ImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage  else {
            fatalError("Expected a dictionary containing an image, but is was provided following: \(info)")
        }
        saveImage(selectedImage)
        heritageImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Private and internal methods
    
    private func setupTableView() {
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        self.tableView.allowsSelection = false
        self.tableView.allowsSelectionDuringEditing = false
    }
    
    func setupNavBar(for item: HeritageViewModel?) {
        if let heritageItem = item {
            navigationItem.title = heritageItem.id
        }
    }
    
    private func setupImagePickerController(type: UIImagePickerControllerSourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    private func updateFields() {
        heritageIdTextField.text = heritageId
        heritageNameTextField.text = heritageName
    }
    
    func updateSaveButtonState(with requiredFields: [UITextField]) {
        var strings = [String]()
        for textField in requiredFields {
            let text = textField.text ?? ""
            strings.append(text)
        }
        let count = strings.filter{$0.isEmpty}.count
        if (count > 0) {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    func setupTextFields(with allTextFields: [UITextField], for viewModel: HeritageViewModel?) {
        for text in allTextFields {
            text.delegate = self
            text.autocapitalizationType = .sentences
            if (viewModel != nil) {
                text.isEnabled = false
            }
            
        }
    }
    
    private func saveImage(_ image:UIImage) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("\(heritageId!).jpg")
        try! UIImageJPEGRepresentation(image, 1.0)?.write(to: imagePath!)
        let path = imagePath!.absoluteString
        print(path)
        pictureURL = path
        
    }
    
    // use this in the main table view
    private func loadImage(with pathAbsoluteString: String){
        let url = URL(string: pathAbsoluteString)
        DispatchQueue.global().async {
            let imageData: Data? = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.heritageImageView.image = UIImage(data: imageData!)
            }
            
        }
    }
    
    
}
