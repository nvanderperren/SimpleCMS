//
//  HeritageObject.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 29/07/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class HeritageObject: Object {
    // MARK:- Properties
    
    // source: https://www.projectcest.be/wiki/Publicatie:PACKED_Dataprofielen
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var category: String = ""
    dynamic var photo: String? = nil
    
    // MARK: - Initializers
    convenience init(id: String, name: String, category: HeritageObjectCategory, photo: String?){
        self.init()
        self.id = id
        self.name = name
        self.category = category.rawValue
        self.photo = photo
    }
    
}
