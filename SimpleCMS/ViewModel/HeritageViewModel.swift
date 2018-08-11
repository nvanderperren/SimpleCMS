//
//  HeritageViewModel.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 10/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageViewModel {
    var id: String
    var name: String
    var category: String
    var description: String?
    var picture: UIImage?
    var pictureURL: String? {
        didSet {
            if let URL = pictureURL {
                picture = UIImage(named: URL)
            }
        }
    }
    
    var rightsLicense: String?
    var creditLine: String?
    var acquisitionMethod: String?
    var acquisitionSource: String?
    var acquisitionDate: String?
    var material: String?
    var technique: String?
    
    init(id: String, name: String, category: String) {
        self.id = id
        self.name = name
        self.category = category
    }
    
    
    
    
}

