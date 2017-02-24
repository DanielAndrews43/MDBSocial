//
//  FeedViewController.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/23/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
    }
    
    func fetchPosts(withBlock: @escaping () -> ()) {
        //TODO: Implement a method to fetch posts with Firebase!
        let ref = FIRDatabase.database().reference()
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = Post(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
            self.posts.append(post)
            
            withBlock()
        })
    }
    
    func setLayout() {
        let posts
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class Social: UIView {
    let nameHeight: CGFloat = 0.2
    let pictureHeight: CGFloat = 0.6
    let metaHeight: CGFloat = 0.2
    
    var poster: String!
    var eventName: String!
    var eventPicURL: String!
    var interested: Int!
    
    init(frame: CGRect, event: firebase.database.reference) {
        //Set up event name at the top
        let nameView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * nameHeight))
        let nameLabel: UILabel = UILabel(frame: CGRect(x: nameView.frame.width * 0.1, y: nameView.frame.height / 3, width: nameView.frame.width * 0.8, height: nameView.frame.height * 2 / 3))
        nameLabel.text = //Get the event name
        nameView.addSubview(nameLabel)
        addSubview(nameView)
        
        //Load in the image
        let imageView: UIImageView = UIimageView(frame: CGRect(x: 0, y: nameView.frame.maxY, width: frame.widht, height: frame.height * pictureHeight))
        imageView.image = //get image from the database
        imageView.backgroundColor = UIColor.lightGray
        addSubview(imageView)
        
        let metaView: UIView = UIView(frame: CGRect(x: 0, y: imageView.frame.maxY, width: frame.width, height: frame.height * metaHeight))
        let posterLabel: UILabel = UILabel(frame: CGRect(x: metaView.frame.width * 0.1, y: metaView.frame.height / 3, width: metaView.frame.width * 0.3, height: metaView.frame.height * 2 / 3))
        posterLabel.text = //Get poster's name from the database
        let interestedLabel: UILabel = UILabel(frame: CGRect(x: posterLabel.frame.maxY + metaView.frame.width * 0.1, y: posterLabel.frame.minY, width: metaView.frame.width * 0.3))
        interestedLabel.text = //Get interested from database + " other(s) are also interested" || "be the first to go!"
        
        metaView.addSubview(posterLabel)
        metaView.addSubview(interestedLabel)
        
        addSubview(metaView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
