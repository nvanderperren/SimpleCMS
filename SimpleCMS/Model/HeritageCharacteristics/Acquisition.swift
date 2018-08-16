//
//  Acquisition.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Acquisition: Object {
    dynamic var method: String = "" //lijst
    dynamic var date: String = ""
    dynamic var source: String = ""
    dynamic var depositPlace: String? = nil
    
    
    convenience init(method: String, date: String, source: String, depositPlace: String?){
        self.init()
        self.method = method
        self.date = date
        self.source = source
        self.depositPlace = depositPlace
    }
}
