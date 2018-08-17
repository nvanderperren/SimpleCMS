//
//  HeritageDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 10/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageDetailViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: - Properties and outlets
    
    var heritageId: String?
    var heritageName: String?
    var pictureURL: String?
    var acquisitionMethods = Seeder.service.getAcquisitionMethods()
    var acquisitionMethod: String? {
        didSet {
            if (acquisitionMethod == "Kies methode") {
                acquisitionMethod = nil
            }
        }
    }
    var acquisitionDate: String?
    
    @IBOutlet weak var heritageIdTextField: UITextField!
    @IBOutlet weak var heritageNameTextField: UITextField!
    @IBOutlet weak var heritageTypeTextField: UITextField!
    @IBOutlet weak var heritageImageView: UIImageView!
    @IBOutlet weak var acquisitionSourceTextField: UITextField!
    @IBOutlet weak var rightsLicenseTextField: UITextField!
    @IBOutlet weak var creditLineTextField: UITextField!
    @IBOutlet weak var heritageDescriptionTextField: UITextField!
    @IBOutlet weak var heritageMaterialTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var acquisitionMethodPicker: UIPickerView!
    
    @IBOutlet weak var acquistionDatePicker: UIDatePicker!
    
    @IBAction func acquistionDateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "nl_BE")
        acquisitionDate = dateFormatter.string(from: acquistionDatePicker.date)
        print(acquisitionDate ?? "no date???")
        
    }
    
    
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acquistionDatePicker.maximumDate = Date()
        setupTableView()
        updateFields()
//        setupAllTextFields()

    }
    
    // MARK: - Camera en Photo methods
    @IBAction func chooseImageFromSavedPhotos(_ sender: UIButton) {
        setupImagePickerController(type: .photoLibrary)
    }
    
    @IBAction func takePicture(_ sender: UIButton) {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = createAlertsWithOneAction(has: "Het toestel heeft geen camera.")
            self.present(alertController, animated: true)
            
        }
        else {
            setupImagePickerController(type: .camera)
        }
    }
    
    // MARK: - TextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - ImagePickerControllerDelegate methods
    
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
    
    // MARK: - Private and internal methods
    
    func setupNavBar(for item: HeritageViewModel?) {
        if let heritageItem = item {
            navigationItem.title = heritageItem.id
        }
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
//                text.isEnabled = false
            }
            
        }
    }
    
    private func saveImage(_ image:UIImage) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("\(heritageId!).jpg")
        do {
            try UIImageJPEGRepresentation(image, 1.0)?.write(to: imagePath!)
            let path = imagePath!.absoluteString
            print(path)
            pictureURL = path
        } catch {
            print(error)
        }
        
    }
    
    private func setupTableView() {
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        self.tableView.allowsSelection = false
        self.tableView.allowsSelectionDuringEditing = false
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
    
    
    
    private func checkForNumericValue(_ value: String){
        guard Double(value) != nil else {
            let alertController = createAlertsWithOneAction(has: "Geef een getal in.")
            self.present(alertController, animated: true)
            return
        }
        print("value is a number")
    }
    
    private func checkIfStringHasEnoughCharacters(_ value: String, count: Int){
        guard value.count < count || value.count > count else {
            let alertController = createAlertsWithOneAction(has: "Geef \(count) tekens in")
            self.present(alertController, animated: true)
            return
        }
        print("genoeg tekens")
    }
    
    private func createAlertsWithOneAction(has message: String) -> UIAlertController{
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        return alertController
    }
    
    func updateAcquistionVariables() {
        let index = acquisitionMethodPicker.selectedRow(inComponent: 0)
        if (index != 0) {
            acquisitionMethod = acquisitionMethods[index]
        } else {
            acquisitionMethod = nil
        }
        
    }
        
    
    
    
//    // use this in the main table view or in viewmodel
//    private func loadImage(with pathAbsoluteString: String){
//        let url = URL(string: pathAbsoluteString)
//        DispatchQueue.global().async {
//            let imageData: Data? = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                self.heritageImageView.image = UIImage(data: imageData!)
//            }
//
//        }
//    }
    
}
extension HeritageDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return acquisitionMethods.count
    }
}

extension HeritageDetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        acquisitionMethod = acquisitionMethods[row]
        print(acquisitionMethod ?? "method is nil")
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return acquisitionMethods[row]
    }
}
