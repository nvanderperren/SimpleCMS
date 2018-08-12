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
    
    // identification
    var id: HeritageIdentification
    
    // characteristics
    var objectCharacteristics: ObjectCharacteristics
    var objectDimensions: [ObjectDimension]?
    
    // find
    private var findEvent: FindEvent
    
    // acquisition
    var acquisition: Acquisition?
    
    
    // MARK: Initializers
    
    init(findId: String, name: String, objectType: String, photo: String?, acquisition: Acquisition?, publisher: String?, findDate: Date?, findPlaceType: String?, location: Location?, material: String?, technique: String?, inscription: String?, description: String?, objectDimensions: [ObjectDimension]?){
        
        self.id = HeritageIdentification(id: findId, name: name, type: objectType, photo: photo)
        self.acquisition = acquisition
        self.findEvent = FindEvent(findDate: findDate, findPlaceType: findPlaceType, location: location)
        self.objectCharacteristics = ObjectCharacteristics(usedMaterial: material, usedTechnique: technique, inscription: inscription, description: description, style: nil)
        self.objectDimensions = objectDimensions
        
    }
    
    private struct FindEvent {
        var findDate: Date?
        var findPlaceType: String?
        var location: Location?
    }
    
    
}


