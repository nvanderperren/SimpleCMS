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
    
    required init(id: String, name: String, artefactType: String, acquisitionSource: String, acquisitionMethod: String, acquisitionDate: String, rightsLicense: String, creditLine: String) {
        self.artefactType = artefactType
        super.init(id: id, name: name, category: HeritageObjectCategory.artefact.rawValue)
        self.acquisitionMethod = acquisitionMethod
        self.acquisitionSource = acquisitionSource
        self.acquisitionDate = acquisitionDate
        self.rightsLicense = rightsLicense
        self.creditLine = creditLine
        
    }
    
    convenience init(id: String, name: String, artefactType: String, pictureURL: String?, acquisitionSource: String, acquisitionMethod: String, acquisitionDate: String, rightsLicense: String, creditLine: String, creator: String?, creationPlace: String?, creationDate: String?, creationPeriod: String?, material: String?, technique: String?, description: String?, size: String?) {
        self.init(id: id, name: name, artefactType: artefactType, acquisitionSource: acquisitionSource, acquisitionMethod: acquisitionMethod, acquisitionDate: acquisitionDate, rightsLicense: rightsLicense, creditLine: creditLine)
        self.pictureURL = pictureURL
        self.creator = creator
        self.creationPlace = creationPlace
        self.creationDate = creationDate
        self.creationPeriod = creationPeriod
        self.description = description
        self.material = material
        self.technique = technique
        self.size = size
    }
    
    
}
