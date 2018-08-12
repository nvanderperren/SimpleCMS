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
    var identificaion: HeritageIdentification
    
    // characteristics
    var location: Location //via webservice?
    var characteristics: ObjectCharacteristics
    // creation
    var creation: ObjectCreation
    
    // rights
    var rights: Rights
    
    //MARK: Initializers
    init(monumentId: String, name: String, type: String, photo: String?, location: Location, rightsStatus: String, creditLine: String, creator: String?, period: String?, description: String?, style: String?, material: String?) {
        self.identificaion = HeritageIdentification(id: monumentId, name: name, type: type, photo: photo)
        self.rights = Rights(status: rightsStatus, creditLine: creditLine)
        self.location = location
        self.creation = ObjectCreation(creator: creator, placeOfCreation: nil, dateOfCreation: nil, period: period)
        self.characteristics = ObjectCharacteristics(usedMaterial: material, usedTechnique: nil, inscription: nil, description: description, style: style)
    }
    
    
}
