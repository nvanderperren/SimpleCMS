//
//  HeritageObjectTableViewCell.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 3/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageObjectTableViewCell: UITableViewCell {

    @IBOutlet weak var objectImageView: UIImageView!
    @IBOutlet weak var objectIdLabel: UILabel!
    @IBOutlet weak var objectTitleLabel: UILabel!
    @IBOutlet weak var objectCategoryLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
