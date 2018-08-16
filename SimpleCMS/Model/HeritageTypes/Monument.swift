//
//  Monument.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Monument: Object {
    
    // MARK: Properties
    
    // identification
    dynamic var monumentId: String = ""
    dynamic var name: String = ""
    dynamic var monumentType: String = ""
    dynamic var isProtected: Bool = false
    dynamic var photo: String? = nil
    
    // characteristics
    dynamic var location: String? = nil //via webservice?
    dynamic var objectDescription: String? = nil
    dynamic var style: String? = nil
    dynamic var material: String? = nil
    
    // creation
    dynamic var creator: String? = nil
    dynamic var period: String? = nil
    
    // rights
    dynamic var rightsStatus: String = ""
    dynamic var creditLine: String = ""
    
    //MARK: Initializers
    convenience init(monumentId: String, name: String, type: String, isProtected: Bool, photo: String?, location: String, rightsStatus: String, creditLine: String, creator: String?, period: String?, description: String?, style: String?, material: String?) {
        self.init()
        self.monumentId = monumentId
        self.name = name
        self.monumentType = type
        self.isProtected = isProtected
        self.photo = photo
        self.location = location
        self.rightsStatus = rightsStatus
        self.creditLine = creditLine
        self.creator = creator
        self.period = period
        self.objectDescription = description
        self.style = style
        self.material = material
    }
    
    
}
