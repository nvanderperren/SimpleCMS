//
//  MetalDetectingFind.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class MetalDetectingFind {
    
    // MARK: Properties
    var objectId: String
    var name: String
    var objectCategory: [String]
    var findDate: Date
    var findPlaceType: [String]?
    var localPlaceName: String?
    var location: Location
    var pictures: [String]
    var usedMaterial: [String]?
    var usedTechnique: [String]?
    var inscription: String?
    var objectDimensions: [Dimension]
    var description: String?
    
    // MARK: Initializers
    init(objectId: String, name: String, objectCategory: [String], findDate: Date, location: Location, pictures: [String], dimensions: [Dimension]) {
        self.objectId = objectId
        self.name = name
        self.findDate = findDate
        self.objectCategory = objectCategory
        self.location = location
        self.pictures = pictures
        self.objectDimensions = dimensions
    }
    
    
}


