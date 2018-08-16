//
//  Artefact.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Artefact: Object {
    
    // MARK: Properties
    
    // identification
    dynamic var objectId: String = ""
    dynamic var objectType: String = ""
    dynamic var name: String = ""
    dynamic var photo: String? = nil
    
    // acquisition
    dynamic var method: String = "" //lijst
    dynamic var date: String = ""
    dynamic var source: String = ""
    dynamic var depositPlace: String? = nil
    
    // charcteristics
    dynamic var objectDimensions = List<ObjectDimension>()
    dynamic var usedMaterial: String? = nil
    dynamic var usedTechnique: String? = nil
    dynamic var objectDescription: String? = nil
    
    // creation
    dynamic var creator: String? = nil
    dynamic var placeOfCreation: String? = nil
    dynamic var dateOfCreation: String? = nil
    dynamic var period: String? = nil
    
    // rights
    dynamic var rightsStatus: String = "" //lijst
    dynamic var creditLine: String = ""
    
    
    // MARK: Initializers
    convenience init(objectId: String, objectType: String, name: String, photo: String?, acquisitionMethod: String, acquisitionDate: String, acquisitionSource: String, depositPlace: String?, rightsStatus: String, creditLine: String, creator: String?, placeOfCreation: String?, dateOfCreation: String?, period: String?, description: String?, material: String?, technique: String?, dimensions: [ObjectDimension]?) {
        self.init()
        self.objectId = objectId
        self.objectType = objectType
        self.name = name
        self.photo = photo
        self.method = acquisitionMethod
        self.date = acquisitionDate
        self.source = acquisitionSource
        self.depositPlace = depositPlace
        if let dimensions = dimensions {
            self.objectDimensions.append(objectsIn: dimensions)
        }
        self.rightsStatus = rightsStatus
        self.creditLine = creditLine
        self.creator = creator
        self.placeOfCreation = placeOfCreation
        self.dateOfCreation = dateOfCreation
        self.period = period
        self.objectDescription = description
        self.usedMaterial = material
        self.usedTechnique = technique
        
    }
    
}
