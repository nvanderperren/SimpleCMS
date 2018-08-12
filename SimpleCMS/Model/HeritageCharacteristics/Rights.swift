//
//  Rights.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 12/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation

struct Rights {
    var status: String //lijst
    var creditLine: String?
    
    init(status: String) {
        self.status = status
    }
    
    init(status: String, creditLine: String) {
        self.init(status: status)
        self.creditLine = creditLine
    }
}
