//
//  DetailViewController.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/23/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    let nameHeight: CGFloat = 0.1
    let hostedHeight: CGFloat = 0.1
    let interestedHeight: CGFloat = 0.1
    let descriptionHeight: CGFloat = 0.65
    let dateHeight: CGFloat = 0.05
    
    var interestedButton: UIButton!
    
    var post: Post!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPost {
            self.setupLayout()
        }
    }
    
    func fetchPost(withBlock: @escaping () -> ()) {
        let ref = FIRDatabase.database().reference()
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            self.post = Post(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
            withBlock()
        })
    }
    
    func setupLayout() {
        //Show image
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width))
        imageView.contentMode = .scaleAspectFit
        if let url = post.imageUrl {
            do {
                try imageView.image = UIImage(data:Data(contentsOf: URL(string: url)!))
            } catch {
                imageView.image = #imageLiteral(resourceName: "failed")
            }
        } else {
            NSLog("No image url found")
        }
        
        //Create content frame
        let contentFrame: UIView = UIView(frame: CGRect(x: 0, y: imageView.frame.maxY, width: view.frame.width, height: view.frame.height - imageView.frame.maxY))
        view.addSubview(contentFrame)
        
        //Show title
        let titleView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * nameHeight))
        let titleLabel: UILabel = UILabel(frame: CGRect(x: titleView.frame.width * 0.1, y: titleView.frame.height / 3, width: titleView.frame.width * 0.8, height: titleView.frame.height / 3))
        titleLabel.textAlignment = .center
        if let title = self.post.name {
            titleLabel.text = title
        } else {
            titleLabel.text = "Event Name"
        }
        titleView.addSubview(titleLabel)
        contentFrame.addSubview(titleView)
        
        //Show date and location
        let dateView: UIView = UIView(frame: CGRect(x: 0, y: titleView.frame.maxY, width: view.frame.width, height: view.frame.height * dateHeight))
        let dateLabel: UILabel = UILabel(frame: CGRect(x: dateView.frame.width * 0.1, y: dateView.frame.height / 3, width: dateView.frame.width * 0.3, height: dateView.frame.height / 3))
        if let date = self.post.time {
            dateLabel.text = date
        } else {
            dateLabel.text = "Date"
        }
        
        let locationLabel: UILabel = UILabel(frame: CGRect(x: dateLabel.frame.maxX + dateView.frame.width * 0.1, y: dateView.frame.height / 3, width: dateView.frame.width * 0.3, height: dateView.frame.height / 3))
        if let location = self.post.location {
            locationLabel.text = location
        } else {
            locationLabel.text = "Location"
        }
        
        dateView.addSubview(dateLabel)
        dateView.addSubview(locationLabel)
        contentFrame.addSubview(dateView)
        
        //Hosted by
        let hostView: UIView = UIView(frame: CGRect(x: 0, y: dateView.frame.maxY, width: view.frame.width, height: view.frame.height * hostedHeight))
        let hostLabel: UILabel = UILabel(frame: CGRect(x: hostView.frame.width * 0.1, y: hostView.frame.height / 3, width: hostView.frame.width * 0.8, height: hostView.frame.height / 3))
        if let host = self.post.poster {
            hostLabel.text = "Hosted by: " + host
        } else {
            hostLabel.text = "Hosted by: Host"
        }
        hostView.addSubview(hostLabel)
        view.addSubview(hostView)
        
        //Number people interested buttons
        let interestedView: UIView = UIView(frame: CGRect(x: 0, y: hostView.frame.maxY, width: view.frame.width, height: view.frame.height * interestedHeight))
        
        //TODO set numInterestedLabel.text set to whether or not person already said they were interested
        let numInterestedLabel: UILabel = UILabel(frame: CGRect(x: interestedView.frame.width * 0.1, y: interestedView.frame.height / 3, width: interestedView.frame.width * 0.3, height: interestedView.frame.height / 3))
        if let likes = self.post.likes {
            numInterestedLabel.text = String(likes) + " interested"
        } else {
            numInterestedLabel.text = "0 interested"
        }
        
        interestedButton = UIButton(frame: CGRect(x: numInterestedLabel.frame.maxX + interestedView.frame.width * 0.1, y: interestedView.frame.height / 3, width: interestedView.frame.width * 0.3, height: interestedView.frame.height / 3))
        interestedButton.addTarget(self, action: #selector(interestedHit), for: .touchUpInside)
        interestedButton.setTitle("Interested!", for: .normal)
        
        interestedView.addSubview(numInterestedLabel)
        interestedView.addSubview(interestedButton)
        
        view.addSubview(interestedView)
        
        //Show text
        let textView: UIView = UIView(frame: CGRect(x: 0, y: interestedView.frame.maxY, width: view.frame.width, height: view.frame.height * descriptionHeight))
        let textLabel: UILabel = UILabel(frame: CGRect(x: textView.frame.width * 0.1, y: textView.frame.height * 0.1, width: textView.frame.width * 0.8, height: textView.frame.height * 0.8))
        if let description = self.post.text {
            textLabel.text = description
        } else {
            textLabel.text = description
        }
        textView.addSubview(textLabel)
        view.addSubview(textView)
    }
    
    func interestedHit() {
        interestedButton.setTitle("You are interested!", for: .normal)
        
        //TODO make firebase call to add this to interested in user profile thing as well as increment the post
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
