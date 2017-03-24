//
//  Post.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/23/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import Foundation

class Post: NSObject {
    var text: String?
    var imageUrl: String?
    var likes: Int?
    var poster: String?
    var name: String?
    var id: String?
    var time: String?
    var posterID: String?
    var location: String?
    
    init(id: String, postDict: [String:Any]?) {
        self.id = id
        if postDict != nil {
            if let text = postDict![Constants.firebase.post.text] as? String {
                self.text = text
            }
            if let imageUrl = postDict![Constants.firebase.post.imageUrl] as? String {
                self.imageUrl = imageUrl
            }
            if let likes = postDict![Constants.firebase.post.likes] as? Int {
                self.likes = likes
            }
            if let poster = postDict![Constants.firebase.post.poster] as? String {
                self.poster = poster
            }
            if let name = postDict![Constants.firebase.post.name] as? String {
                self.name = name
            }
            if let time = postDict![Constants.firebase.post.time] as? String {
                self.time = time
            }
            if let posterID = postDict![Constants.firebase.post.posterId] as? String {
                self.posterID = posterID
            }
            if let location = postDict![Constants.firebase.post.location] as? String {
                self.location = location
            }
        }
    }
    
    override init() {
        self.text = "Come and joing the kitten kuddle puddle on lower sproul!"
        self.imageUrl = "https://newsroom.uber.com/wp-content/uploads/2015/10/HQ_uberkittens_blog_960x540_r1v1.jpg"
        self.id = "1"
        self.name = "Kitten Kuddling"
        self.likes = 0
        self.poster = "Bob Marley"
        self.time = "Whenever"
        self.posterID = "12345"
        self.location = "Disneyland"
    }
}
