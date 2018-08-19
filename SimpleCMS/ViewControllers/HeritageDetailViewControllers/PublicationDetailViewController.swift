//
//  PublicationDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 11/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class PublicationDetailViewController: HeritageDetailViewController {
    
    // MARK: - Properties and outlets
    
    // model
    var publication: PublicationViewModel?
    
    // variables
    
    override var acquisitionMethod: String? {
        didSet {
            if (acquisitionMethod == "Kies methode") {
                acquisitionMethod = nil
            }
            saveButton.isEnabled = updateSaveButtonState(with: requiredTextFields, and: requiredVariables)
        }
    }
    
    override var rightsStatus: String? {
        didSet {
            if (rightsStatus == "Kies status") {
                rightsStatus = nil
            }
            saveButton.isEnabled = updateSaveButtonState(with: requiredTextFields, and: requiredVariables)
        }
    }
    
    override var acquisitionDate: String? {
        didSet {
            saveButton.isEnabled = updateSaveButtonState(with: requiredTextFields, and: requiredVariables)
        }
    }
    
    
    // readonly
    var genres = Seeder.service.getGenres().sorted{$0 < $1}
    
    
    // outlets
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var publicationPlaceTextField: UITextField!
    @IBOutlet weak var publicationDateTextField: UITextField!
    @IBOutlet weak var numberOfPagesTextField: UITextField!
    @IBOutlet weak var editionTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    
    // outlet actions
    @IBAction func chooseGenre(_ sender: UIButton) {
    }
    
    
    private var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, authorTextField, acquisitionSourceTextField, creditLineTextField, publisherTextField, publicationDateTextField, publicationPlaceTextField, numberOfPagesTextField, editionTextField, genreTextField]
    }
    
    private var requiredTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, authorTextField, acquisitionSourceTextField, creditLineTextField]
    }
    
    private var requiredVariables: [String?] {
        return [acquisitionMethod, acquisitionDate, rightsStatus]
    }
    
    // MARK: - ViewController methods

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Publication showing")
        setupNavBar(for: publication)
        setupTextFields(with: allTextFields, for: publication)
        setupDatePicker()
        saveButton.isEnabled = updateSaveButtonState(with: requiredTextFields, and: requiredVariables)
        if let publication = publication {
            updateVariables(publication)
            setupPublicationModel(publication)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print(segue.identifier!)
        switch(segue.identifier) {
        case "did add publication":
            updateViewModel()
            guard let publication = publication else {
                fatalError("publication is nil")
            }
            publication.primaryKey = UUID().uuidString
            DatabaseService.service.create(publication)
            print("item saved")
        case "did edit publication":
            updateViewModel()
            guard let publication = publication else {
                fatalError("publication is nil")
            }
            DatabaseService.service.update(publication, with: .update)
        case "choose genre"?:
            if let destinationController = segue.destination as? UINavigationController, let target = destinationController.topViewController as? ListTableViewController {
                target.data = genres
                target.action = "did choose genre"
            }
        default:
            fatalError("unknown segue")
        }
        
    }
    
    @IBAction func choseGenre(_ segue: UIStoryboardSegue) {
        switch(segue.identifier){
        case "did choose genre":
            if let source = segue.source as? ListTableViewController {
                genreTextField.text = source.value
            }
        default:
            fatalError("segue does not exist")
        }
       
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if publication == nil {
            performSegue(withIdentifier: "did add publication", sender: PublicationDetailViewController())
        } else {
            performSegue(withIdentifier: "did edit publication", sender: PublicationDetailViewController())
        }
        
    }
    
    // MARK: - TextFieldDelegate methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isEnabled = updateSaveButtonState(with: requiredTextFields, and: requiredVariables)
        if textField == editionTextField {
            checkForNumericValue(editionTextField.text ?? "")
        }
        if textField == numberOfPagesTextField {
            checkForNumericValue(numberOfPagesTextField.text ?? "")
        }
        if textField == publicationDateTextField {
            checkIfStringHasEnoughNumbers(publicationDateTextField.text ?? "", count: 4)
        }
    }
    
    // MARK: - Private methods
    
    private func setupPublicationModel(_ publication: PublicationViewModel){
        heritageIdTextField.text = publication.id
        heritageNameTextField.text = publication.name
        authorTextField.text = publication.author
        heritageImageView.image = publication.picture
        let acquistionMethodStatus = acquisitionMethods.index(of: publication.acquisitionMethod ?? "Kies methode")
        acquisitionMethodPicker.selectRow(acquistionMethodStatus!, inComponent: 0, animated: true)
        acquisitionSourceTextField.text = publication.acquisitionSource
        acquistionDatePicker.date = convertStringToDate(acquisitionDate!)
        let rightsStatusIndex = rightsLicenses.index(of: rightsStatus ?? "Kies status")
        rightsLicensePicker.selectRow(rightsStatusIndex!, inComponent: 0, animated: false)
        creditLineTextField.text = publication.creditLine
        publisherTextField.text = publication.publisher
        publicationDateTextField.text = publication.publicationDate
        publicationPlaceTextField.text = publication.publicationPlace
        if let pages = publication.numberOfPages {
            numberOfPagesTextField.text = String(pages)
        }
        if let edition = publication.edition {
            editionTextField.text = String(edition)
        }
        heritageDescriptionTextView.text = publication.description
        genreTextField.text = publication.genre
    }
    
    private func updateVariables(_ publication: PublicationViewModel) {
        self.heritageId = publication.id
        self.acquisitionMethod = publication.acquisitionMethod
        self.acquisitionDate = publication.acquisitionDate
        self.rightsStatus = publication.rightsLicense
        self.pictureURL = publication.pictureURL

    }
    
    private func updateViewModel() {
        if let publication = publication {
            publication.id = heritageId!
            publication.name = heritageNameTextField.text!
            publication.author = authorTextField.text!
            publication.acquisitionMethod = acquisitionMethod!
            publication.acquisitionSource = acquisitionSourceTextField.text!
            publication.acquisitionDate = acquisitionDate!
            publication.rightsLicense = rightsStatus!
            publication.creditLine =  creditLineTextField.text!
            publication.publisher = publisherTextField.text
            publication.publicationDate = publicationDateTextField.text
            publication.publicationPlace = publicationPlaceTextField.text
            if let pages = numberOfPagesTextField.text {
                publication.numberOfPages = Int(pages)
            }
            if let edition = editionTextField.text {
                publication.edition = Int(edition)
            }
            publication.description = heritageDescription
            publication.genre = genreTextField.text
            publication.pictureURL = pictureURL
        }
        else {
            publication = PublicationViewModel(id: heritageIdTextField.text!, author: authorTextField.text!, title: heritageNameTextField.text!, pictureURL: pictureURL, acquisitionMethod: acquisitionMethod!, acquisitionSource: acquisitionSourceTextField.text!, acquisitionDate: acquisitionDate!, rightsLicense: rightsStatus!, creditLine: creditLineTextField.text!, publisher: publisherTextField.text, publicationDate: publicationDateTextField.text, publicationPlace: publicationPlaceTextField.text, numberOfPages: numberOfPagesTextField.text, edition: editionTextField.text, genre: genreTextField.text)
        }
    }
    
    private func setupDatePicker() {
        if publication != nil {
            acquistionDatePicker.maximumDate = convertStringToDate(publication?.acquisitionDate)
        } else {
            acquistionDatePicker.maximumDate = Date()
        }
    }
    
    
    

}
