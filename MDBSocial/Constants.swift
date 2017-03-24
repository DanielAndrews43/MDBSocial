//
//  Constants.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/25/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

struct Constants {
    struct firebase {
        struct post {
            static let text = "text"
            static let imageUrl = "imageURL"
            static let likes = "likes"
            static let poster = "poster"
            static let name = "name"
            static let time = "time"
            static let posterId = "posterID"
            static let location = "location"
            static let likeIds = "likerIDs"
        }
        
        struct users {
            static let email = "email"
            static let name = "name"
        }
    }
    
    struct colors {
        static let backgroundColor = UIColor(red: 57, green: 190, blue: 255)
        static let buttonColor = UIColor(red: 160, green: 160, blue: 160)
    }
}
