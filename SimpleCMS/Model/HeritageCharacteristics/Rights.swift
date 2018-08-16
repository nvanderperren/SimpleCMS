//
//  Rights.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 12/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Rights: Object {
    dynamic var status: String = "" //lijst
    dynamic var creditLine: String? = nil
    
    convenience init(status: String, creditLine: String) {
        self.init()
        self.status = status
        self.creditLine = creditLine
    }
}
