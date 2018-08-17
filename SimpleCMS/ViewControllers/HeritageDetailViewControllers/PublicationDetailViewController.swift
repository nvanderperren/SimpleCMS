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
    
    var publication: PublicationViewModel?
    
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var publicationPlaceTextField: UITextField!
    @IBOutlet weak var publicationDateTextField: UITextField!
    @IBOutlet weak var numberOfPagesTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var editionTextField: UITextField!
    
    private var allTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, authorTextField, acquisitionSourceTextField, rightsLicenseTextField, creditLineTextField, publisherTextField, publicationDateTextField, publicationPlaceTextField, numberOfPagesTextField, contentTextField, editionTextField]
    }
    
    private var requiredTextFields: [UITextField] {
        return [heritageIdTextField, heritageNameTextField, authorTextField, acquisitionSourceTextField, rightsLicenseTextField, creditLineTextField]
    }
    
    // MARK: - ViewController methods

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Publication showing")
        setupNavBar(for: publication)
        setupTextFields(with: allTextFields, for: publication)
        updateSaveButtonState(with: requiredTextFields)
        if let publication = publication {
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
        default:
            fatalError("unknown segue")
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
        updateSaveButtonState(with: requiredTextFields)
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
        //acquisitionDateTextField.text = publication.acquisitionDate
        rightsLicenseTextField.text = publication.rightsLicense
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
        contentTextField.text = publication.description
        self.heritageId = publication.id
    }
    
    private func updateViewModel() {
        if let publication = publication {
            publication.id = heritageId!
            publication.name = heritageNameTextField.text!
            publication.author = authorTextField.text!
            publication.acquisitionMethod = acquisitionMethod!
            publication.acquisitionSource = acquisitionSourceTextField.text!
            publication.acquisitionDate = "datum"
            publication.rightsLicense = rightsLicenseTextField.text!
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
            publication.description = contentTextField.text
            publication.pictureURL = pictureURL
        }
        else {
            publication = PublicationViewModel(id: heritageIdTextField.text!, author: authorTextField.text!, title: heritageNameTextField.text!, pictureURL: pictureURL, acquisitionMethod: acquisitionMethod!, acquisitionSource: acquisitionSourceTextField.text!, acquisitionDate: "een datum", rightsLicense: rightsLicenseTextField.text!, creditLine: creditLineTextField.text!, publisher: publisherTextField.text, publicationDate: publicationDateTextField.text, publicationPlace: publicationPlaceTextField.text, numberOfPages: numberOfPagesTextField.text, edition: editionTextField.text)
        }
    }
    
    

}
