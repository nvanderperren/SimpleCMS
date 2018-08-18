//
//  MetalDetectingFind.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class MetalDetectingFind: Object {
    
    // MARK: Properties
    dynamic var primaryKey: String = ""

    
    // identification
    dynamic var findId: String = ""
    dynamic var name: String = ""
    dynamic var objectType: String = ""
    dynamic var photo: String? = nil
    
    // characteristics
    dynamic var material: String? = nil
    dynamic var technique: String? = nil
    dynamic var inscription: String? = nil
    dynamic var objectDescription: String? = nil
    dynamic var objectDimensions = List<ObjectDimension>()
    
    // find
    dynamic var findPlaceType: String? = nil
    dynamic var location: String? = nil
    
    // acquisition
    // dynamic var acquisition: Acquisition? = nil
    
    
    // MARK: Initializers
    
    convenience init(findId: String, name: String, objectType: String, photo: String?, findPlaceType: String?, location: String?, material: String?, technique: String?, inscription: String?, description: String?, objectDimensions: [ObjectDimension]?){
        self.init()
        self.findId = findId
        self.name = name
        self.objectType = objectType
        self.photo = photo
        self.findPlaceType = findPlaceType
        self.location = location
        self.material = material
        self.technique = technique
        self.inscription = inscription
        self.objectDescription = description
        if let dimensions = objectDimensions {
            self.objectDimensions.append(objectsIn: dimensions)     
        }
        
    }
    
    
}


