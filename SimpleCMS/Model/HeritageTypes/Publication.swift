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
    var id: Identification
    
    // characteristics
    var numberOfPages: Int?
    var isPartOfSeries: Bool
    var contents: Contents?
    
    // publication
    var publication: PublicationEvent?
    
    // acquisition
    var acquisition: Acquisition
    
    // rights
    var rights: Rights
    
    // MARK: Initializers
    
    init(id: Identification, isPartOfSeries: Bool = false, acquisition: Acquisition, rights: Rights){
        self.id = id
        self.isPartOfSeries = isPartOfSeries
        self.acquisition = acquisition
        self.rights = rights
    }
    
    // MARK: Internal structs
    
    struct Identification {
        var idNumber: String
        var author: [String]
        var title: String
    }
    
    struct PublicationEvent {
        var placeOfPublication: Location?
        var publisher: [String]?
        var dateOfPublication: Date?
    }
    
    struct Contents {
        var genre: String?
        var shortDescription: String?
    }
    
    struct Rights {
        var status: String //lijst
        var creditline: String?
    }
    
    
    
}
