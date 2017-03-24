//
//  PostCollectionViewCell.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/25/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    let pictureHeight: CGFloat = 0.8
    let metaHeight: CGFloat = 0.2
    
    var imageView: UIImageView!
    var nameLabel: UILabel!
    var posterLabel: UILabel!
    var interestedButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 200, green: 200, blue: 200)
        
        //Load in the image
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * pictureHeight))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.white
        self.addSubview(imageView)

        nameLabel = UILabel(frame: CGRect(x: imageView.frame.width * 0.05, y: imageView.frame.height * 0.05, width: imageView.frame.width * 0.8, height: imageView.frame.height * 0.1))
        nameLabel.textColor = UIColor.white
        nameLabel.layer.shadowRadius = 1
        nameLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        nameLabel.layer.shadowOpacity = 1
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.adjustsFontSizeToFitWidth = true
        addSubview(nameLabel)
        
        let metaView = UIView(frame: CGRect(x: 0, y: imageView.frame.maxY, width: frame.width, height: frame.height * metaHeight))
        posterLabel = UILabel(frame: CGRect(x: metaView.frame.width * 0.1, y: 0, width: metaView.frame.width * 0.4, height: metaView.frame.height * 1 / 3))
        posterLabel.adjustsFontSizeToFitWidth = true
        posterLabel.font = UIFont.systemFont(ofSize: 12)
        interestedButton = UIButton(frame: CGRect(x: posterLabel.frame.maxX, y: 0, width: metaView.frame.width * 0.3, height: metaView.frame.height))
        interestedButton.backgroundColor = UIColor.red

        metaView.addSubview(posterLabel)
        metaView.addSubview(interestedButton)
        
        addSubview(metaView)
    }
}
