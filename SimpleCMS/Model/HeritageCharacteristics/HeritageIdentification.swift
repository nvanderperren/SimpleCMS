//
//  HeritageIdentification.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 12/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class HeritageIdentification: Object {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var type: String? = nil
    dynamic var photo: String? = nil
    
    convenience init(id: String, name: String, type: String?, photo: String?){
        self.init()
        self.id = id
        self.name = name
        self.type = type
        self.photo = photo
    }
    
}
