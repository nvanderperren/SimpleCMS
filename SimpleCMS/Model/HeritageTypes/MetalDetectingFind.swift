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
    
    // identification
    dynamic var id: HeritageIdentification? = nil
    
    // characteristics
    dynamic var objectCharacteristics: ObjectCharacteristics? = nil
    dynamic var objectDimensions: [ObjectDimension]? = nil
    
    // find
    dynamic var findEvent: FindEvent? = nil
    
    // acquisition
    dynamic var acquisition: Acquisition? = nil
    
    
    // MARK: Initializers
    
    convenience init(findId: String, name: String, objectType: String, photo: String?, acquisition: Acquisition?, publisher: String?, findDate: Date?, findPlaceType: String?, location: Location?, material: String?, technique: String?, inscription: String?, description: String?, objectDimensions: [ObjectDimension]?){
        self.init()
        self.id = HeritageIdentification(id: findId, name: name, type: objectType, photo: photo)
        self.acquisition = acquisition
        self.findEvent = FindEvent(findDate: findDate, findPlaceType: findPlaceType, location: location)
        self.objectCharacteristics = ObjectCharacteristics(usedMaterial: material, usedTechnique: technique, inscription: inscription, description: description, style: nil)
        self.objectDimensions = objectDimensions
        
    }
    
    
}

@objcMembers class FindEvent: Object {
    dynamic var findDate: Date? = nil
    dynamic var findPlaceType: String? = nil
    dynamic var location: Location? = nil
    
    convenience init(findDate: Date?, findPlaceType: String?, location: Location?){
        self.init()
        self.findDate = findDate
        self.findPlaceType = findPlaceType
        self.location = location
    }
}


