//
//  HeritageDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 10/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageDetailViewController: UITableViewController, UINavigationControllerDelegate  {
    
    // MARK: - Properties and outlets
    
    // variables
    var heritageId: String?
    var heritageName: String?
    var pictureURL: String?
    var acquisitionDate: String?
    
    var acquisitionMethod: String? {
        didSet {
            if (acquisitionMethod == "Kies methode") {
                acquisitionMethod = nil
            }
        }
    }
   
    var rightsStatus: String? {
        didSet {
            if (rightsStatus == "Kies status") {
                rightsStatus = nil
            }
        }
    }
//    var collapsedSections: NSMutableSet = []
    
    // readonly
    var acquisitionMethods = Seeder.service.getAcquisitionMethods()
    var rightsLicenses = Seeder.service.getRightsLicenses()
    
    
    // outlets
    @IBOutlet weak var heritageIdTextField: UITextField!
    @IBOutlet weak var heritageNameTextField: UITextField!
    @IBOutlet weak var heritageTypeTextField: UITextField!
    @IBOutlet weak var heritageImageView: UIImageView!
    @IBOutlet weak var acquisitionSourceTextField: UITextField!
    @IBOutlet weak var creditLineTextField: UITextField!
    @IBOutlet weak var heritageDescriptionTextField: UITextField!
    @IBOutlet weak var heritageMaterialTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var acquisitionMethodPicker: UIPickerView!
    @IBOutlet weak var acquistionDatePicker: UIDatePicker!
    @IBOutlet weak var rightsLicensePicker: UIPickerView!
    
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //acquistionDatePicker.maximumDate = Date()
        setupTableView()
        updateFields()
//        setupAllTextFields()

    }
    
    // MARK: - Camera and Photo methods
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
    
    // MARK: - DataPicker methods
    @IBAction func acquistionDateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "nl_BE")
        acquisitionDate = dateFormatter.string(from: acquistionDatePicker.date)
        print(acquisitionDate ?? "no date???")
        
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 25))
//        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
//
//        let headerLbl = UILabel(frame: CGRect(x: 12, y: 4, width: tableView.bounds.size.width-12, height: 18))
//        headerLbl.tag = 111
//        headerLbl.textColor = UIColor.white
//        if section == 0{
//            headerLbl.text = "Section1"
//        }
//        else{
//            headerLbl.text = "Section2"
//        }
//        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 25))
//        btn.addTarget(self, action: #selector(collapseTableHeader(_:)), for: .touchUpInside)
//        btn.tag = section
//        view.addSubview(btn)
//        view.addSubview(headerLbl)
//        return view
//    }
    
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
    
    func convertStringToDate(_ dateString: String?) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "nl_BE")
        if let date = dateString {
            return dateFormatter.date(from: date) ?? Date()
        } else {
            return Date()
        }
    }
    
//    @objc private func collapseTableHeader(_ sender: UIButton) {
//        tableView.beginUpdates()
//        var section = Int()
//        section = sender.tag
//        var shouldCollapse = Bool()
//        shouldCollapse = !collapsedSections.contains(section)
//
//        if shouldCollapse {
//            collapsedSections.add(section)
//        }
//        else {
//            collapsedSections.remove(section)
//        }
//        self.tableView.endUpdates()
//    }
//
//    private func indexPathsForSection(section: Int, with numberOfRows: Int) -> [IndexPath] {
//        var indexPaths = [IndexPath]()
//        var indexPath = IndexPath()
//
//        for row in 0..<numberOfRows {
//            indexPath = IndexPath(row: row, section: section)
//            indexPaths.append(indexPath)
//        }
//        return indexPaths
//    }
    
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

// MARK: - Extensions

extension HeritageDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension HeritageDetailViewController: UIImagePickerControllerDelegate {
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
    
    private func setupImagePickerController(type: UIImagePickerControllerSourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
}

extension HeritageDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch (pickerView.tag){
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView.tag){
        case 0:
            return acquisitionMethods.count
        case 2:
            return rightsLicenses.count
        default:
            fatalError()
        }
    }
}

extension HeritageDetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView.tag){
        case 0:
            acquisitionMethod = acquisitionMethods[row]
            print(acquisitionMethod ?? "method is nil")
        case 2:
            rightsStatus = rightsLicenses[row]
            print(rightsStatus ?? "rightslicense is nil")
        default:
            fatalError()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (pickerView.tag){
        case 0:
            return acquisitionMethods[row]
        case 2:
            return rightsLicenses[row]
        default:
            fatalError()
        }
    }
}
