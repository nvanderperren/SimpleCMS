//
//  PublicationViewModel.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 11/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class PublicationViewModel : HeritageViewModel {
    var author: String
    var title: String
    var publisher: String?
    var publicationDate: String?
    var publicationPlace: String?
    var amountOfPages: Int?
    var edition: Int?
    
    required init(id: String, name: String, author: String, title: String, acquisitionMethod: String, acquisitionSource: String, acquisitionDate: String, rightsLicense: String, creditLine: String) {
        self.author = author
        self.title = title
        super.init(id: id, name: name, category: HeritageObjectCategory.publication.rawValue)
        self.acquisitionMethod = acquisitionMethod
        self.acquisitionSource = acquisitionSource
        self.acquisitionDate = acquisitionDate
        self.rightsLicense = rightsLicense
        self.creditLine = creditLine
    }
    
    
    
    
    
}
