//
//  Location.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

struct Location {
    var municipality: String //lijst
    var postalCode: String //lijst
    var street: String? //lijst
    var houseNumber: String? //lijst
    
    // placesAPI =  AIzaSyCZ2U06exSk2RHvOVEJs-pBFbbxaD3z8QE
    
    init(municipality: String, postalCode: String, street: String?, houseNumber: String?){
        self.municipality = municipality
        self.postalCode = postalCode
        self.street = street
        self.houseNumber = houseNumber
    }
    
}
