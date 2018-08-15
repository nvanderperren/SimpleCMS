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
    dynamic var category: HeritageObjectCategory.RawValue = "artefact"
//    var license: String? // enum van maken
//    var currentLocation: String? // klasse van maken met eigenschappen.
    dynamic var photo: String? = nil
//    var objectDescription: String?
//    var dimensions: [ObjectDimension]? = []
    
    // MARK: - Initializers
//    init(id: String, name: String, category: HeritageObjectCategory, photo: String = "defaultPhoto") {
//        self.id = id
//        self.name = name
//        self.category = category
//        self.photo = photo
//    }
//
//    init(id: String, name: String, category: HeritageObjectCategory, location: String, license: String){
//        self.id = id
//        self.name = name
//        self.category = category
//        self.currentLocation = location
//        self.license = license
//    }
    
}
