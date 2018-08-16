//
//  ObjectCharacteristics.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 12/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class ObjectCharacteristics: Object {
    dynamic var usedMaterial: String? = nil
    dynamic var usedTechnique: String? = nil
    dynamic var inscription: String? = nil
    dynamic var objectDescription: String? = nil
    dynamic var style: String? = nil
    
    convenience init(usedMaterial: String?, usedTechnique: String?, inscription: String?, description: String?, style: String?) {
        self.init()
        self.usedMaterial = usedMaterial
        self.usedTechnique = usedTechnique
        self.inscription = inscription
        self.objectDescription = description
        self.style = style
    }

}
