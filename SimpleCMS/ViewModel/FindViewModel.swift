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
    var findDate: String?
    var findPlaceType: String?
    var findPlace: String?
    var inscription: String?
    
    required init(id: String, name: String, category: String, objectType: String) {
        self.objectType = objectType
        super.init(id: id, name: name, category: category)
    }
}
