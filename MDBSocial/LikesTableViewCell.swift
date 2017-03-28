//
//  LikesTableViewCell.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 3/27/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class LikesTableViewCell: UITableViewCell {

    var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label = UILabel(frame: frame)
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = true
        
        addSubview(label)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
