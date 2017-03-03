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
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        //TODO set numInterestedLabel.text set to whether or not person already said they were interested
        let numInterestedLabel: UILabel = UILabel(frame: CGRect(x: interestedView.frame.width * 0.1, y: interestedView.frame.height / 6, width: interestedView.frame.width * 0.3, height: interestedView.frame.height * 2 / 3))
        numInterestedLabel.text = String(self.post.likes) + " interested"
        
        interestedButton = UIButton(frame: CGRect(x: numInterestedLabel.frame.maxX + interestedView.frame.width * 0.1, y: 0, width: interestedView.frame.width * 0.5, height: interestedView.frame.height / 2))
        interestedButton.addTarget(self, action: #selector(interestedHit), for: .touchUpInside)
        interestedButton.backgroundColor = UIColor.green
        
        interestedView.addSubview(numInterestedLabel)
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
    
    func setupTableView(){
        //Initialize TableView Object here
        tableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width, height: view.frame.height))
        //Register the tableViewCell you are using
        tableView.register(InterestedPeopleTableViewCell.self, forCellReuseIdentifier: "nameCell")
        
        //Set properties of TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50/2, right: 0)
        //Add tableView to view
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.post.likes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! InterestedPeopleTableViewCell
        
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        
        let ref = FIRDatabase.database().reference().child("Users")
        let likerIDs = post.likeIDs
        
        ref.child("Users").child((likerIDs?[indexPath.row])!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?[Constants.firebase.user.name] as? String ?? ""
            cell.awakeFromNib()
            cell.nameLabel.text = username
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return cell
    }

    
}

