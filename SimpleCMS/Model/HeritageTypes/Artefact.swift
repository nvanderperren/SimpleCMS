//
//  Artefact.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class Artefact {
    
    // MARK: Properties
    
    // identification - dit komt onder HeritageObject
    var identification: HeritageIdentification
    
    // charcteristics
    var objectDimensions: [ObjectDimension]?
    var objectCharacteristics: ObjectCharacteristics?
    
    // creation
    var objectCreation: ObjectCreation?
    
    // collection management
    var acquisition: Acquisition
    
    // rights
    var rights: Rights
    
    
    // MARK: Initializers
    init(objectId: String, objectType: String, name: String, photo: String?, acquisitionMethod: String, acquisitionDate: Date, acquisitionSource: String, depositPlace: String?, rightsStatus: String, creditLine: String, creator: String?, placeOfCreation: String?, dateOfCreation: Date?, period: String?, description: String?, material: String?, techique: String?, dimensions: [ObjectDimension]?) {
        self.identification = HeritageIdentification(id: objectId, name: name, type: objectType, photo: photo)
        self.acquisition = Acquisition(method: acquisitionMethod, date: acquisitionDate, source: acquisitionSource, depositPlace: depositPlace)
        self.rights = Rights(status: rightsStatus, creditLine: creditLine)
        self.objectCreation = ObjectCreation(creator: creator, placeOfCreation: placeOfCreation, dateOfCreation: dateOfCreation, period: period)
        self.objectCharacteristics = ObjectCharacteristics(usedMaterial: material, usedTechnique: techique, inscription: nil, description: description, style: nil)
        self.objectDimensions = dimensions
    }
    
    
    
}
