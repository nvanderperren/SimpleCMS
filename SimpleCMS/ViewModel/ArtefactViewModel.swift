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
    var sizeLength: String?
    var sizeLengthUnit: String?
    var sizeWidth: String?
    var sizeWidthUnit: String?
    var sizeDepth: String?
    var sizeDepthUnit: String?
    
    
    required init(id: String, name: String, artefactType: String, acquisitionSource: String, acquisitionMethod: String, acquisitionDate: String, rightsLicense: String, creditLine: String) {
        self.artefactType = artefactType
        super.init(id: id, name: name, category: HeritageObjectCategory.artefact.rawValue)
        self.acquisitionMethod = acquisitionMethod
        self.acquisitionSource = acquisitionSource
        self.acquisitionDate = acquisitionDate
        self.rightsLicense = rightsLicense
        self.creditLine = creditLine
        
    }
    
    convenience init(id: String, name: String, artefactType: String, pictureURL: String?, acquisitionSource: String, acquisitionMethod: String, acquisitionDate: String, rightsLicense: String, creditLine: String, creator: String?, creationPlace: String?, creationDate: String?, creationPeriod: String?, material: String?, description: String?) {
        self.init(id: id, name: name, artefactType: artefactType, acquisitionSource: acquisitionSource, acquisitionMethod: acquisitionMethod, acquisitionDate: acquisitionDate, rightsLicense: rightsLicense, creditLine: creditLine)
        self.pictureURL = pictureURL
        self.creator = creator
        self.creationPlace = creationPlace
        self.creationDate = creationDate
        self.creationPeriod = creationPeriod
        self.description = description
        self.material = material
    }
    
    convenience init(id: String, name: String, artefactType: String, pictureURL: String?, acquisitionSource: String, acquisitionMethod: String, acquisitionDate: String, rightsLicense: String, creditLine: String, creator: String?, creationPlace: String?, creationDate: String?, creationPeriod: String?, material: String?, description: String?, length: String?, lengthUnit: String?, width: String?, widthUnit: String?, depth: String?, depthUnit: String?) {
        self.init(id: id, name: name, artefactType: artefactType, acquisitionSource: acquisitionSource, acquisitionMethod: acquisitionMethod, acquisitionDate: acquisitionDate, rightsLicense: rightsLicense, creditLine: creditLine)
        self.pictureURL = pictureURL
        self.creator = creator
        self.creationPlace = creationPlace
        self.creationDate = creationDate
        self.creationPeriod = creationPeriod
        self.description = description
        self.material = material
        self.sizeLength = length
        self.sizeLengthUnit = lengthUnit
        self.sizeWidth = width
        self.sizeWidthUnit = widthUnit
        self.sizeDepth = depth
        self.sizeDepthUnit = depthUnit
    }
    
    
}
