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
    
    let nameHeight: CGFloat = 0.15
    let hostedHeight: CGFloat = 0.15
    let interestedHeight: CGFloat = 0.15
    let descriptionHeight: CGFloat = 0.4
    let dateHeight: CGFloat = 0.15
    
    var interestedButton: UIButton!
    var post: Post!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.colors.backgroundColor
        self.setupLayout()
    }
    
    func setupLayout() {
        //Show image
        let imageView = UIImageView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.width))
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
        view.addSubview(imageView)
        
        //Create content frame
        let contentFrame: UIView = UIView(frame: CGRect(x: 0, y: imageView.frame.maxY, width: view.frame.width, height: view.frame.height - imageView.frame.maxY))
        view.addSubview(contentFrame)
        
        //Show title
        let titleView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: contentFrame.frame.height * nameHeight))
        let titleLabel: UILabel = UILabel(frame: CGRect(x: titleView.frame.width * 0.1, y: titleView.frame.height / 6, width: titleView.frame.width * 0.8, height: titleView.frame.height * 2 / 3))
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        if let title = self.post.name {
            titleLabel.text = title
        } else {
            titleLabel.text = "Event Name"
        }
        titleView.addSubview(titleLabel)
        contentFrame.addSubview(titleView)
        
        //Hosted by
        let hostView: UIView = UIView(frame: CGRect(x: 0, y: titleView.frame.maxY, width: view.frame.width, height: contentFrame.frame.height * hostedHeight))
        let hostLabel: UILabel = UILabel(frame: CGRect(x: hostView.frame.width * 0.1, y: hostView.frame.height / 6, width: hostView.frame.width * 0.8, height: hostView.frame.height * 2 / 3))
        hostLabel.adjustsFontSizeToFitWidth = true
        if let host = self.post.poster {
            hostLabel.text = "Hosted by: " + host
        } else {
            hostLabel.text = "Hosted by: Host"
        }
        hostView.addSubview(hostLabel)
        contentFrame.addSubview(hostView)
        
        //Show date and location
        let dateView: UIView = UIView(frame: CGRect(x: 0, y: hostView.frame.maxY, width: view.frame.width, height: contentFrame.frame.height * dateHeight))
        let dateLabel: UILabel = UILabel(frame: CGRect(x: dateView.frame.width * 0.1, y: dateView.frame.height / 6, width: dateView.frame.width * 0.3, height: dateView.frame.height * 2 / 3))
        dateLabel.adjustsFontSizeToFitWidth = true
        if let date = self.post.time {
            dateLabel.text = date
        } else {
            dateLabel.text = "Date"
        }
        
        let locationLabel: UILabel = UILabel(frame: CGRect(x: dateLabel.frame.maxX + dateView.frame.width * 0.1, y: dateView.frame.height / 6, width: dateView.frame.width * 0.3, height: dateView.frame.height * 2 / 3))
        locationLabel.adjustsFontSizeToFitWidth = true
        if let location = self.post.location {
            locationLabel.text = location
        } else {
            locationLabel.text = "Location"
        }
        
        dateView.addSubview(dateLabel)
        dateView.addSubview(locationLabel)
        contentFrame.addSubview(dateView)
        
        //Number people interested buttons
        let interestedView: UIView = UIView(frame: CGRect(x: 0, y: dateView.frame.maxY, width: view.frame.width, height: contentFrame.frame.height * interestedHeight))
        
        let numInterestedButton: UIButton = UIButton(frame: CGRect(x: interestedView.frame.width * 0.1, y: interestedView.frame.height / 6, width: interestedView.frame.width * 0.3, height: interestedView.frame.height * 2 / 3))
        numInterestedButton.setTitle(String(self.post.likes) + " interested", for: .normal)
        numInterestedButton.addTarget(self, action: #selector(showInterested), for: .touchUpInside)
        numInterestedButton.backgroundColor = Constants.colors.buttonColor
        
        interestedButton = UIButton(frame: CGRect(x: numInterestedButton.frame.maxX + interestedView.frame.width * 0.1, y: 0, width: interestedView.frame.width * 0.5, height: interestedView.frame.height))
        interestedButton.addTarget(self, action: #selector(interestedHit), for: .touchUpInside)
        interestedButton.backgroundColor = Constants.colors.buttonColor
        
        if (post.likeIDs.contains((FIRAuth.auth()?.currentUser?.uid)!)) {
            interestedButton.setTitle("You are interested!", for: .normal)
        } else {
            interestedButton.setTitle("Interested?", for: .normal)
        }
        
        interestedView.addSubview(numInterestedButton)
        interestedView.addSubview(interestedButton)
        contentFrame.addSubview(interestedView)
        
        //Show text
        let textView: UIView = UIView(frame: CGRect(x: 0, y: interestedView.frame.maxY, width: view.frame.width, height: contentFrame.frame.height * descriptionHeight))
        let textLabel: UILabel = UILabel(frame: CGRect(x: textView.frame.width * 0.1, y: textView.frame.height * 0.1, width: textView.frame.width * 0.8, height: textView.frame.height * 0.8))
        textLabel.numberOfLines = 0
        if let description = self.post.text {
            textLabel.text = description
        } else {
            textLabel.text = description
        }
        textView.addSubview(textLabel)
        contentFrame.addSubview(textView)
    }
    
    func interestedHit() {
        interestedButton.setTitle("You are interested!", for: .normal)
        
        self.post.addInterestedUser()
    }
    
    func showInterested() {
        performSegue(withIdentifier: "detailToLikes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToLikes" {
            let tableVC = segue.destination as! LikesViewController
            tableVC.post = self.post
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

