//
//  Artefact.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class Artefact {
    
    // MARK:Properties
    
    // identification - dit komt onder HeritageObject
    var objectId: String
    var objectName: String //lijst
    var name: String
    var pictures: [String]?
    
    // charcteristics
    var description: String?
    var material: [String]? //lijst
    var objectDimension: [ObjectDimension]?
    var technique: [String]?
    
    // creation
    var objectCreation: ObjectCreation?
    
    // collection management
    var acquisition: Acquisition
    
    // rights
    var rightsStatus: String // lijst
    var creditLine: String
    
    init(objectId: String, objectName: String, name: String, acquisition: Acquisition, rightsStatus: String, creditLine: String) {
        self.objectId = objectId
        self.objectName = objectName
        self.name = name
        self.acquisition = acquisition
        self.rightsStatus = rightsStatus
        self.creditLine = creditLine
    }
    
    
    
}
