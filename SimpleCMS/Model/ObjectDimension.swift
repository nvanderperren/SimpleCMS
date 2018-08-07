//
//  ObjectDimension.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 1/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

struct ObjectDimension {
    var dimensionType : ObjectDimensionType
    var unit : ObjectDimensionUnit
    var value : Double
    
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
}
