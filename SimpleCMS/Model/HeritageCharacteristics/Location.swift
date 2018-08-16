//
//  Location.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Location: Object {
    dynamic var municipality: String? = nil //lijst
    dynamic var postalCode: String? = nil //lijst
    dynamic var street: String? = nil //lijst
    dynamic var houseNumber: String? = nil //lijst
    
    // placesAPI =  AIzaSyCZ2U06exSk2RHvOVEJs-pBFbbxaD3z8QE
    
    convenience init(municipality: String?, postalCode: String?, street: String?, houseNumber: String?){
        self.init()
        self.municipality = municipality
        self.postalCode = postalCode
        self.street = street
        self.houseNumber = houseNumber
    }
    
}
