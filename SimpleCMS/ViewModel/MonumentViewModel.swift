//
//  monumentViewModel.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 12/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class MonumentViewModel: HeritageViewModel {
    var monumentType: String
    var monumentLocationMunicipality: String
    var monumentLocationStreetName: String?
    var monumentLocationNumber: String?
    var monumentLocationPostalCode: String
    var creator: String?
    var period: String?
    var style: String?
    
    required init(id: String, name: String, monumentType: String, municipality: String, street: String?, houseNumber: String?, postalCode: String, license: String) {
        self.monumentType = monumentType
        self.monumentLocationNumber = houseNumber
        self.monumentLocationPostalCode = postalCode
        self.monumentLocationStreetName = street
        self.monumentLocationMunicipality = municipality
        super.init(id: id, name: name, category: HeritageObjectCategory.monument.rawValue)
        self.rightsLicense = license
    }
    
    
}
