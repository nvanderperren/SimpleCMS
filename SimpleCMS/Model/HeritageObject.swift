//
//  HeritageObject.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 29/07/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageObject {
    // MARK:- Properties
    
    // source: https://www.projectcest.be/wiki/Publicatie:PACKED_Dataprofielen
    var id: String
    var category: [HeritageObjectCategory]
    var license: String // enum van maken
    var currentLocation: String // klasse van maken met eigenschappen.
    var photos: [UIImage]? = []
    var description: String?
    var dimensions: [ObjectDimension]? = []
    
    // MARK: - Initializers
    init(id: String, category: [HeritageObjectCategory], location: String, license: String){
        self.id = id
        self.category = category
        self.currentLocation = location
        self.license = license
    }
    
}
