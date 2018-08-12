//
//  HeritagePublication.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 6/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation


class Publication {
    
    // MARK: Properties

    // identification
    private var id: HeritageIdentification
    private var author: String
    
    // characteristics
    private var numberOfPages: Int?
    private var contents: Contents?
    private var publication: PublicationEvent?
    
    // acquisition
    private var acquisition: Acquisition
    
    // rights
    private var rights: Rights
    
    // MARK: Initializers
    
    init(publicationId: String, title: String, author: String, photo: String?, acquisitionMethod: String, acquisitionDate: Date, acquisitionSource: String, depositPlace: String?, rightsLicense: String, creditLine: String, publisher: String?, placeOfPublication: String?, dateOfPublication: Date?, genre: String?, shortDescription: String?, numberOfPages: Int?, edition: String?){
        
        self.id = HeritageIdentification(id: publicationId, name: title, type: nil, photo: photo)
        self.author = author
        self.acquisition = Acquisition(method: acquisitionMethod, date: acquisitionDate, source: acquisitionSource, depositPlace: depositPlace)
        self.rights = Rights(status: rightsLicense, creditLine: creditLine)
        self.publication = PublicationEvent(placeOfPublication: placeOfPublication, publisher: publisher, dateOfPublication: dateOfPublication)
        self.numberOfPages = numberOfPages
        self.contents = Contents(genre: genre, shortDescription: shortDescription, edition: edition)
    }
    
    // MARK: Private structs
    private struct PublicationEvent {
        var placeOfPublication: String?
        var publisher: String?
        var dateOfPublication: Date?
    }
    
    private struct Contents {
        var genre: String?
        var shortDescription: String?
        var edition: String?
    }
    
    
    
    
    
    
}
