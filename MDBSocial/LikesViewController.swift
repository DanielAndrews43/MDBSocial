//
//  LikesViewController.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 3/27/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit
import Firebase

class LikesViewController: UIViewController {

    var post: Post!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
    }
    
    func setLayout() {
        print(post.likeIDs)
        
        tableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width, height: view.frame.height))
        tableView.register(LikesTableViewCell.self, forCellReuseIdentifier: "likesCell")
        
        //Set properties of TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50/2, right: 0)
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LikesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if post.likeIDs != nil {
            print(post.likeIDs.count)
            return post.likeIDs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell") as! LikesTableViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        cell.label.text = post.likeIDs[indexPath.row]
        return cell
    }
}
