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
    
    init(id: String, postDict: [String:Any]?) {
        self.id = id
        if postDict != nil {
            if let text = postDict!["text"] as? String {
                self.text = text
            }
            if let imageUrl = postDict!["imageUrl"] as? String {
                self.imageUrl = imageUrl
            }
            if let likes = postDict!["numLikes"] as? Int {
                self.likes = likes
            }
            if let poster = postDict!["poster"] as? String {
                self.poster = poster
            }
            if let name = postDict!["imageUrl"] as? String {
                self.name = name
            }
        }
    }
    
    override init() {
        self.text = "This is a god dream"
        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
        self.id = "1"
        self.likes = 0
        self.poster = "Kanye West"
    }
}
