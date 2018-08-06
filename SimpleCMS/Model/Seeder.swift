//
//  Seeder.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 3/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

struct Seeder {
    
    func createHeritageObjects() -> [HeritageObject] {
        var collection = [HeritageObject]()
        collection.append(HeritageObject(id: "TILE1", name: "armband", category: HeritageObjectCategory.metalDetectingFind, photos: [UIImage(named:"armband")]))
        collection.append(HeritageObject(id: "TILE2", name: "munitie", category: HeritageObjectCategory.metalDetectingFind, photos: [UIImage(named:"munitie")]))
        collection.append(HeritageObject(id: "TILE3", name: "een oud boek", category: HeritageObjectCategory.publication, photos: [UIImage(named:"boek")]))
        collection.append(HeritageObject(id: "TILE4", name: "een schilderij", category: HeritageObjectCategory.artefact, photos: [UIImage(named:"schilderij")]))
        collection.append(HeritageObject(id: "TILE5", name: "een muziekinstrument", category: HeritageObjectCategory.artefact, photos: [UIImage(named: "kalimba")]))
        return collection
    }
}
