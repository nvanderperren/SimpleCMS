//
//  Monument.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Monument: Object {
    
    // MARK: Properties
    
    // identification
    dynamic var identification: HeritageIdentification? = nil
    
    // characteristics
    dynamic var location: Location? = nil //via webservice?
    dynamic var characteristics: ObjectCharacteristics? = nil
    // creation
    dynamic var creation: ObjectCreation? = nil
    
    // rights
    dynamic var rights: Rights? = nil
    
    //MARK: Initializers
    convenience init(monumentId: String, name: String, type: String, photo: String?, location: Location, rightsStatus: String, creditLine: String, creator: String?, period: String?, description: String?, style: String?, material: String?) {
        self.init()
        self.identification = HeritageIdentification(id: monumentId, name: name, type: type, photo: photo)
        self.rights = Rights(status: rightsStatus, creditLine: creditLine)
        self.location = location
        self.creation = ObjectCreation(creator: creator, placeOfCreation: nil, dateOfCreation: nil, period: period)
        self.characteristics = ObjectCharacteristics(usedMaterial: material, usedTechnique: nil, inscription: nil, description: description, style: style)
    }
    
    
}
