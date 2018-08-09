//
//  LabelAndTextFieldTableViewCell.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 9/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

@IBDesignable class LabelAndTextFieldTableViewCell: UITableViewCell {

    var label = UILabel()
    var textField = UITextField()
    var labelName: String?
    var stackView = UIStackView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setLabelName(with: labelName)
        stackView.axis = .vertical
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.isBaselineRelativeArrangement = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setLabelName(with labelName: String?){
        self.label.text = labelName
    }

}
