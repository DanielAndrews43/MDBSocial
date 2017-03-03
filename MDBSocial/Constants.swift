//
//  Constants.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/25/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class Constants {
    struct firebase {
        struct post {
            static let posterID = "posterID"
            static let imageURL = "imageURL"
            static let likes = "likes"
            static let name = "name"
            static let poster = "poster"
            static let text = "text"
            static let location = "location"
            static let time = "time"
            static let likerIDs = "likerIDs"
        }
        
        struct user {
            static let name = "name"
            static let email = "email"
        }
    }
}
