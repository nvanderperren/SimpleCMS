//
//  FindViewModel.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 11/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class FindViewModel : HeritageViewModel {
    var objectType: String
    var findPlaceType: String?
    var findPlace: String?
    var technique: String?
    var inscription: String?
    
    required init(id: String, name: String, objectType: String) {
        self.objectType = objectType
        super.init(id: id, name: name, category: HeritageObjectCategory.metalDetectingFind.rawValue)
    }
    
    convenience init(id: String, name: String, objectType: String, pictureURL: String?, findPlaceType: String?, findPlace: String?, inscription: String?) {
        self.init(id: id, name: name, objectType: objectType)
        self.pictureURL = pictureURL
        self.findPlaceType = findPlaceType
        self.inscription = inscription
    }
}
