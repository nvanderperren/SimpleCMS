//
//  monumentViewModel.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 12/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class MonumentViewModel: HeritageViewModel {
    
    // MARK: Properties
    var monumentType: String
    var isProtected: Bool
    var monumentLocationMunicipality: String
    var monumentLocationStreetName: String?
    var monumentLocationNumber: String?
    var monumentLocationPostalCode: String?
    var creator: String?
    var period: String?
    var style: String?
    
    // MARK: Initializers
    
    // REMINDER: postal code is mandatory!
    required init(id: String, name: String, monumentType: String, protection: Bool, municipality: String, postalCode: String?, license: String, creditLine: String) {
        self.monumentType = monumentType
        self.isProtected = protection
        self.monumentLocationPostalCode = postalCode
        self.monumentLocationMunicipality = municipality
        super.init(id: id, name: name, category: HeritageObjectCategory.monument.rawValue)
        self.rightsLicense = license
        self.creditLine = creditLine
    }
    
    
    // REMINDER: postal code is mandatory!
    convenience init(id: String, name: String, monumentType: String, pictureURL: String?, protection: Bool, municipality: String, street: String?, houseNumber: String?, postalCode: String?, license: String, creditLine: String, creator: String?, period: String?, style: String?) {
        self.init(id: id, name: name, monumentType: monumentType, protection: protection, municipality: municipality, postalCode: postalCode, license: license, creditLine: creditLine)
        self.pictureURL = pictureURL
        self.monumentLocationStreetName = street
        self.monumentLocationNumber = houseNumber
        self.creator = creator
        self.period = period
        self.creditLine = creditLine
    }
    
    
    
    
}
