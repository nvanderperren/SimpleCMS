//
//  PublicationViewModel.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 11/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class PublicationViewModel : HeritageViewModel {
    
    // MARK: Properties
    var author: String
    var publisher: String?
    var publicationDate: String?
    var publicationPlace: String?
    var numberOfPages: Int?
    var edition: Int?
    
    // MARK: Initializers
    required init(id: String, title: String, author: String, acquisitionMethod: String, acquisitionSource: String, acquisitionDate: String, rightsLicense: String, creditLine: String) {
        self.author = author
        super.init(id: id, name: title, category: HeritageObjectCategory.publication.rawValue)
        self.acquisitionMethod = acquisitionMethod
        self.acquisitionSource = acquisitionSource
        self.acquisitionDate = acquisitionDate
        self.rightsLicense = rightsLicense
        self.creditLine = creditLine
    }
    
    convenience init(id: String, author: String, title: String, pictureURL: String?, acquisitionMethod: String, acquisitionSource: String, acquisitionDate: String, rightsLicense: String, creditLine: String, publisher: String?, publicationDate: String?, publicationPlace: String?, numberOfPages: String?, edition: String?) {
        self.init(id: id, title: title, author: author, acquisitionMethod: acquisitionMethod, acquisitionSource: acquisitionSource, acquisitionDate: acquisitionDate, rightsLicense: rightsLicense, creditLine: creditLine)
        self.pictureURL = pictureURL
        self.publisher = publisher
        self.publicationDate = publicationDate
        self.publicationPlace = publicationPlace
        self.numberOfPages = convertOptionalStringtoOptionalInt(with: numberOfPages)
        self.edition = convertOptionalStringtoOptionalInt(with: edition)
    }
    
    private func convertOptionalStringtoOptionalInt(with value: String?) -> Int? {
        if let value = value {
            return Int(value)
        } else {
            return nil
        }
    }
    
    
    
    
    
    
    
}
