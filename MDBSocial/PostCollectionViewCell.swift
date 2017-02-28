//
//  PostCollectionViewCell.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/25/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    let nameHeight: CGFloat = 0.05
    let pictureHeight: CGFloat = 0.8
    let metaHeight: CGFloat = 0.15
    
    var imageView: UIImageView!
    var nameLabel: UILabel!
    var posterLabel: UILabel!
    var interestedButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        let nameView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * nameHeight))
        nameLabel = UILabel(frame: CGRect(x: nameView.frame.width * 0.1, y: nameView.frame.height / 10, width: nameView.frame.width * 0.8, height: nameView.frame.height * 4 / 5))
        nameLabel.adjustsFontSizeToFitWidth = true
        nameView.addSubview(nameLabel)
        addSubview(nameView)
        
        //Load in the image
        imageView = UIImageView(frame: CGRect(x: 0, y: nameView.frame.maxY, width: frame.width, height: frame.height * pictureHeight))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white
        self.addSubview(imageView)
        
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
