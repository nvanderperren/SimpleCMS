//
//  ObjectCreation.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class ObjectCreation: Object {
    dynamic var creator: String? = nil
    dynamic var placeOfCreation: String? = nil
    dynamic var dateOfCreation: Date? = nil
    dynamic var period: String? = nil
    
    convenience init(creator: String?, placeOfCreation: String?, dateOfCreation: Date?, period: String?){
        self.init()
        self.creator = creator
        self.placeOfCreation = placeOfCreation
        self.dateOfCreation = dateOfCreation
        self.period = period
    }
}
