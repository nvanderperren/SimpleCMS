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
    dynamic var id: HeritageIdentification? = nil
    dynamic var author: String = ""
    
    // characteristics
    dynamic var numberOfPages = RealmOptional<Int>()
    dynamic var contents: Contents? = nil
    dynamic var publication: PublicationEvent? = nil
    
    // acquisition
    dynamic var acquisition: Acquisition? = nil
    
    // rights
    dynamic var rights: Rights? = nil
    
    // MARK: Initializers
    convenience init(publicationId: String, title: String, author: String, photo: String?, acquisitionMethod: String, acquisitionDate: Date, acquisitionSource: String, depositPlace: String?, rightsLicense: String, creditLine: String, publisher: String?, placeOfPublication: String?, yearOfPublication: String?, genre: String?, shortDescription: String?, numberOfPages: Int?, edition: Int?){
        self.init()
        self.id = HeritageIdentification(id: publicationId, name: title, type: nil, photo: photo)
        self.author = author
        self.acquisition = Acquisition(method: acquisitionMethod, date: acquisitionDate, source: acquisitionSource, depositPlace: depositPlace)
        self.rights = Rights(status: rightsLicense, creditLine: creditLine)
        self.publication = PublicationEvent(publisher: publisher, placeOfPublication: placeOfPublication, yearOfPublication: yearOfPublication)
        self.numberOfPages.value = numberOfPages
        self.contents = Contents(genre: genre, shortDescription: shortDescription, edition: edition)
    }
}

@objcMembers class PublicationEvent: Object {
    dynamic var placeOfPublication: String? = nil
    dynamic var publisher: String? = nil
    dynamic var yearOfPublication: String? = nil
    
    convenience init(publisher: String?, placeOfPublication: String?, yearOfPublication: String?){
        self.init()
        self.publisher = publisher
        self.placeOfPublication = placeOfPublication
        self.yearOfPublication = yearOfPublication
    }
}

@objcMembers class Contents: Object {
    dynamic var genre: String? = nil
    dynamic var shortDescription: String? = nil
    dynamic var edition = RealmOptional<Int>()
    
    convenience init(genre: String?, shortDescription: String?, edition: Int?){
        self.init()
        self.genre = genre
        self.shortDescription = shortDescription
        self.edition.value = edition
    }
}
