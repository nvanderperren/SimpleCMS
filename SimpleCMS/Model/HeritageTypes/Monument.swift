//
//  Monument.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class Monument {
    
    // MARK: Properties
    
    // identification
    var monumentId: String
    var pictures: [String]?
    var name: String
    var type: String // lijst
    
    // characteristics
    var location: Location //via webservice?
    var style: [String]? //lijst
    var description: String?
    
    // creation
    var creator: String?
    var period: String? //lijst
    
    // rights
    var rightsStatus: String // lijst
    var creditLine: String?
    
    //MARK: Initializers
    init(monumentId: String, name: String, type: String, location: Location, rightsStatus: String) {
        self.monumentId = monumentId
        self.name = name
        self.type = type
        self.location = location
        self.rightsStatus = rightsStatus
    }
    
    
}
