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
    var monumentId: String
    var pictures: [String]?
    var name: String
    var type: String // lijst
    var location: Location //via webservice?
    var period: String? //lijst
    var style: [String]? //lijst
    var description: String?
    
    //MARK: Initializers
    init(monumentId: String, name: String, type: String, location: Location) {
        self.monumentId = monumentId
        self.name = name
        self.type = type
        self.location = location
    }
    
    
}
