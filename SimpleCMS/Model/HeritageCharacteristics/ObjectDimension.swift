//
//  ObjectDimension.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 1/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class ObjectDimension: Object {
    dynamic var dimensionType: String = ""
    dynamic var unit: String = ""
    dynamic var value: Double = 0
    
    convenience init(dimensionType: ObjectDimensionType.RawValue, value: Double, unit: ObjectDimensionUnit.RawValue) {
        self.init()
        self.dimensionType = dimensionType
        self.value = value
        self.unit = unit
    }
}

enum ObjectDimensionType: String {
    case diameter = "diameter"
    case radius = "straal"
    case length = "lengte"
    case width = "breedte"
    case height = "hoogte"
    case depth = "diepte"
}

enum ObjectDimensionUnit: String {
    case mm = "mm"
    case cm = "cm"
    case m = "m"
}
