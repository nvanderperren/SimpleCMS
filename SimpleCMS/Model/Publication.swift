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

    
    var id: Identification
    var numberOfPages: Int?
    var isPartOfSeries: Bool
    var publication: Publication?
    var contents: Contents?
    var acquisition: Acquisition
    var rights: Rights
    var record: Record
    
    // MARK: Initializers
    
    init(id: Identification, isPartOfSeries: Bool = false, acquisition: Acquisition, rights: Rights, record: Record){
        self.id = id
        self.isPartOfSeries = isPartOfSeries
        self.acquisition = acquisition
        self.rights = rights
        self.record = record
    }
    
    // MARK: Internal structs
    
    struct Identification {
        var idNumber: String
        var author: [String]
        var title: String
    }
    
    struct Publication {
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
        var creditline: String
    }
    
    struct Record {
        var date = Date()
    }
    
    
}
