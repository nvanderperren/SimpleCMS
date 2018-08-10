//
//  LabelAndTextFieldTableViewCell.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 9/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class LabelAndTextFieldCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var labelName: String?
    var placeHolderText: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.text = labelName
        textField.placeholder = placeHolderText
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
