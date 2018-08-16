//
//  HeritagePublication.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 6/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Publication: Object {
    
    // MARK: Properties

    // identification
    dynamic var publicationId: String = ""
    dynamic var title: String = ""
    dynamic var author: String = ""
    dynamic var photo: String? = nil
    
    // characteristics
    dynamic var numberOfPages = RealmOptional<Int>()
    dynamic var genre: String? = nil
    dynamic var shortDescription: String? = nil
    dynamic var edition = RealmOptional<Int>()
    
    
    // acquisition
    dynamic var method: String = "" //lijst
    dynamic var date: String = ""
    dynamic var source: String = ""
    dynamic var depositPlace: String? = nil
    
    // rights
    dynamic var rightsStatus: String = ""
    dynamic var creditLine: String = ""
    
    // publication
    dynamic var placeOfPublication: String? = nil
    dynamic var publisher: String? = nil
    dynamic var yearOfPublication: String? = nil
    
    // MARK: Initializers
    convenience init(publicationId: String, title: String, author: String, photo: String?, acquisitionMethod: String, acquisitionDate: String, acquisitionSource: String, depositPlace: String?, rightsLicense: String, creditLine: String, publisher: String?, placeOfPublication: String?, yearOfPublication: String?, genre: String?, shortDescription: String?, numberOfPages: Int?, edition: Int?){
        self.init()
        self.publicationId = publicationId
        self.title = title
        self.author = author
        self.photo = photo
        self.method = acquisitionMethod
        self.source = acquisitionSource
        self.date = acquisitionDate
        self.depositPlace = depositPlace
        self.rightsStatus = rightsLicense
        self.creditLine = creditLine
        self.publisher = publisher
        self.placeOfPublication = placeOfPublication
        self.yearOfPublication = yearOfPublication
        self.genre = genre
        self.shortDescription = shortDescription
        self.numberOfPages.value = numberOfPages
       self.edition.value = edition
    }
}
