//
//  HeritageViewModel.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 10/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageViewModel {
    
    // MARK: Properties
    var id: String
    var name: String
    var category: String
    var description: String?
    var picture: UIImage?
    var rightsLicense: String?
    var creditLine: String?
    var acquisitionMethod: String?
    var acquisitionSource: String?
    var acquisitionDate: String?
    var material: String?
    var technique: String?
    
    var pictureURL: String? {
        didSet {
            if let url = pictureURL {
                print("pictureURL staat aan!")
                print(url)
                loadImage(with: url)
            }
        }
    }
    
    // MARK: Initializers
    init(id: String, name: String, category: String) {
        self.id = id
        self.name = name
        self.category = category
        
    }
    
    // MARK: Private methods
    private func loadImage(with pathAbsoluteString: String){
        let url = URL(string: pathAbsoluteString)
        let imageData: Data? = try? Data(contentsOf: url!)
        self.picture = UIImage(data: imageData!)
    }
    
    
    
    
}

