//
//  Artefact.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

class Artefact {
    var objectId: String
    var objectName: String //lijst
    var name: String
    var owner: String
    var shelf: String?
    var pictures: [String?]
    var description: String?
    var material: [String]? //lijst
    var objectDimension: [ObjectDimension]?
    var creator: String
    var placeOfCreationo: Location?
    var technique: [String]?
    var dateOfCreation: Date
    var contentDescription: String?
    var acquisition: Acquisition
    var rightsstatus: String // lijst
    var creditline: String
    var recordingDate = Date()
    
    
    
}
