//
//  Seeder.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 3/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

struct Seeder {
    
    var heritageObjects: [HeritageViewModel] {
        let item1 = HeritageViewModel(id: "TILE1", name: "armband", category: HeritageObjectCategory.metalDetectingFind.rawValue)
        let item2 = HeritageViewModel(id: "TILE2", name: "munitie", category: HeritageObjectCategory.metalDetectingFind.rawValue)
        let item3 = HeritageViewModel(id: "TILE3", name: "een oud boek", category: HeritageObjectCategory.publication.rawValue)
        let item4 = HeritageViewModel(id: "TILE4", name: "een schilderij", category: HeritageObjectCategory.artefact.rawValue)
        let item5 = HeritageViewModel(id: "TILE5", name: "een muziekinstrument", category: HeritageObjectCategory.artefact.rawValue)
        item1.picture = UIImage(named:"armband")
        item2.picture = UIImage(named:"munitie")
        item3.picture = UIImage(named:"boek")
        item4.picture = UIImage(named: "schilderij")
        item5.picture = UIImage(named: "kalimba")
        return [item1, item2, item3, item4, item5]
        
    }
    
    
}
