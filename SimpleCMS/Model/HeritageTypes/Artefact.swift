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
    dynamic var identification: HeritageIdentification? = nil
    
    // charcteristics
    dynamic var objectDimensions: [ObjectDimension]? = nil
    dynamic var objectCharacteristics: ObjectCharacteristics? = nil
    
    // creation
    dynamic var objectCreation: ObjectCreation? = nil
    
    // collection management
    dynamic var acquisition: Acquisition? = nil
    
    // rights
    dynamic var rights: Rights? = nil
    
    
    // MARK: Initializers
    convenience init(objectId: String, objectType: String, name: String, photo: String?, acquisitionMethod: String, acquisitionDate: Date, acquisitionSource: String, depositPlace: String?, rightsStatus: String, creditLine: String, creator: String?, placeOfCreation: String?, dateOfCreation: Date?, period: String?, description: String?, material: String?, techique: String?, dimensions: [ObjectDimension]?) {
        self.init()
        self.identification = HeritageIdentification(id: objectId, name: name, type: objectType, photo: photo)
        self.acquisition = Acquisition(method: acquisitionMethod, date: acquisitionDate, source: acquisitionSource, depositPlace: depositPlace)
        self.rights = Rights(status: rightsStatus, creditLine: creditLine)
        self.objectCreation = ObjectCreation(creator: creator, placeOfCreation: placeOfCreation, dateOfCreation: dateOfCreation, period: period)
        self.objectCharacteristics = ObjectCharacteristics(usedMaterial: material, usedTechnique: techique, inscription: nil, description: description, style: nil)
        self.objectDimensions = dimensions
    }
    
    
    
}
