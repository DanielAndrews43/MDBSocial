//
//  User.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/24/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String!
    var id: String!
    var email: String!
    
    
    init(id: String, userDict: [String:Any]?) {
        self.id = id
        if userDict != nil {
            if let name = userDict!["name"] as? String {
                self.name = name
            }
            if let email = userDict!["email"] as? String {
                self.email = email
            }
        }
    }
    
    init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    override init() {
        self.id = "1"
        self.name = "Bob Marley"
        self.email = "Bob@Marley.com"
    }

}
