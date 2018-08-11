//
//  ArtefactViewModel.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 11/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class ArtefactViewModel : HeritageViewModel {
    
    var artefactType: String
    var creator: String?
    var creationPlace: String?
    var creationDate: String?
    var creationPeriod: String?
    var size: String?
//    var sizeType: String
//    var sizeValue: Double
//    var sizeUnit: String
    
    required init(id: String, name: String, category: String, artefactType: String, acquisitionSource: String, acquisitionMethod: String, acquisitionDate: String, rightsLicense: String, creditLine: String) {
        self.artefactType = artefactType
        super.init(id: id, name: name, category: category)
        self.acquisitionMethod = acquisitionMethod
        self.acquisitionSource = acquisitionSource
        self.acquisitionDate = acquisitionDate
        self.rightsLicense = rightsLicense
        self.creditLine = creditLine
        
    }
    
    
}
