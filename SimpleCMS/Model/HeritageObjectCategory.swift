//
//  HeritageObjectCategory.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 1/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

enum HeritageObjectCategory {
    case publication
    case artefact
    case artwork
    case metalDetectingFind
    
    var textualRepresentation : String {
        switch (self) {
        case .publication:
            return "publicatie"
        case .artefact:
            return "roerend erfgoedobject"
        case .metalDetectingFind:
            return "metaaldetectievondst"
        case .artwork:
            return "kunstwerk"
        }
    }
}

