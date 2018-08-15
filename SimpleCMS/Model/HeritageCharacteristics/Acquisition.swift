//
//  Acquisition.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 7/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

struct Acquisition {
    var method: String //lijst
    var date: Date
    var source: String
    var depositPlace: String?
    
    
    init(method: String, date: Date, source: String, depositPlace: String?){
        self.method = method
        self.date = date
        self.source = source
        self.depositPlace = depositPlace
    }
}
