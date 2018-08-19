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
    var period: String?
    var technique: String?
    var inscription: String?
    var sizeLength: String?
    var sizeLengthUnit: String?
    var sizeWidth: String?
    var sizeWidthUnit: String?
    var sizeDepth: String?
    var sizeDepthUnit: String?
    
    required init(id: String, name: String, objectType: String) {
        self.objectType = objectType
        super.init(id: id, name: name, category: HeritageObjectCategory.metalDetectingFind.rawValue)
    }
    
    convenience init(id: String, name: String, objectType: String, pictureURL: String?, findPlaceType: String?, findPlace: String?, inscription: String?, period: String?, technique: String?, description: String?, acquisitionSource: String?, acquisitionMethod: String?, acquisitionDate: String?) {
        self.init(id: id, name: name, objectType: objectType)
        self.pictureURL = pictureURL
        self.findPlaceType = findPlaceType
        self.inscription = inscription
        self.period = period
        self.technique = technique
        self.description = description
        self.acquisitionSource = acquisitionSource
        self.acquisitionDate = acquisitionDate
        self.acquisitionMethod = acquisitionMethod
    }
    
    convenience init(id: String, name: String, objectType: String, pictureURL: String?, findPlaceType: String?, findPlace: String?, inscription: String?, description: String?, period: String?, technique: String?, length: String?, lengthUnit: String?, width: String?, widthUnit: String?, depth: String?, depthUnit: String?, acquisitionSource: String?, acquisitionMethod: String?, acquisitionDate: String?) {
        self.init(id: id, name: name, objectType: objectType)
        self.pictureURL = pictureURL
        self.findPlaceType = findPlaceType
        self.inscription = inscription
        self.period = period
        self.technique = technique
        self.sizeLength = length
        self.sizeLengthUnit = lengthUnit
        self.sizeWidth = width
        self.sizeWidthUnit = widthUnit
        self.sizeDepth = depth
        self.sizeDepthUnit = depthUnit
        self.description = description
        self.acquisitionSource = acquisitionSource
        self.acquisitionDate = acquisitionDate
        self.acquisitionMethod = acquisitionMethod
    }
}
