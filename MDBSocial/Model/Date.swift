//
//  Date.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/24/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class Date {
    var month: String!
    var day: String!
    var hour: Int!
    
    init(dateDict: [String:Any]?) {
        if dateDict != nil {
            if let month = dateDict![Constants.firebase.date.month] as? String {
                self.month = month
            }
            if let day = dateDict![Constants.firebase.date.day] as? String {
                self.day = day
            }
            if let hour = dateDict![Constants.firebase.date.hour] as? Int {
                self.hour = hour
            }
        }

    }
    
    init(month: String, day: String, hour: Int) {
        self.month = month
        self.day = day
        self.hour = hour
    }
}
