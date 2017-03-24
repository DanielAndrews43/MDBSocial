//
//  InterestedPeopleTableViewCell.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 3/3/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class InterestedPeopleTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel = UILabel(frame: CGRect(x: 20, y: contentView.frame.height * (1/3), width: 150, height: contentView.frame.height * (1/3)))
        nameLabel.textColor = UIColor.black
        contentView.addSubview(nameLabel)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
