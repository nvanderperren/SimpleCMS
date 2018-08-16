//
//  HeritageObject.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 29/07/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

@objcMembers class HeritageObject: Object {
    // MARK:- Properties
    
    // source: https://www.projectcest.be/wiki/Publicatie:PACKED_Dataprofielen
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var photo: String? = nil
    
    // MARK: - Initializers
    convenience init(id: String, name: String, photo: String?){
        self.init()
        self.id = id
        self.name = name
        self.photo = photo
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    
    
    
}
