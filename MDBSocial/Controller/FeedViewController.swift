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
    
    var postCollectionView: UICollectionView!
    var posts: [Post] = []
    var auth = FIRAuth.auth()
    var postsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Posts")
    var storage: FIRStorageReference = FIRStorage.storage().reference()
    var currentUser: User?
    
    var clickedPost: Post!

    override func viewDidLoad() {
        super.viewDidLoad()

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
        
        fetchUser {
            self.setupNavBar()
            self.setupCollectionView()
            self.fetchPosts() {
                activityIndicator.stopAnimating()
            }
        }
        setupNavBar()
    }
    
    func fetchPosts(withBlock: @escaping () -> ()) {
        let ref = FIRDatabase.database().reference()
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            if let postDict = snapshot.value {
                let post = Post(id: snapshot.key, postDict: postDict as? [String: Any])
                self.posts.append(post)
                
                var indexPaths = Array<IndexPath>()
                let index = self.posts.index(where: {$0.id == post.id})
                let indexPath = IndexPath(item: index!, section: 0)
                indexPaths.append(indexPath)
                
                DispatchQueue.main.async {
                    self.postCollectionView.performBatchUpdates({void in
                        self.postCollectionView.insertItems(at: indexPaths)
                        }, completion: nil)
                }
            }
            
            withBlock()
        })
    }
    
    func fetchUser(withBlock: @escaping () -> ()) {
        let ref = FIRDatabase.database().reference()
        ref.child("Users").child((self.auth?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = User(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
            self.currentUser = user
            withBlock()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavBar() {
        self.title = "Feed"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Event", style: .plain, target: self, action: #selector(newEvent))
    }
    
    func newEvent() {
        performSegue(withIdentifier: "feedToNewSocial", sender: self)
    }
    
    func setupCollectionView() {
        let frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height - (self.navigationController?.navigationBar.frame.maxY)!)
        let cvLayout = UICollectionViewFlowLayout()
        postCollectionView = UICollectionView(frame: frame, collectionViewLayout: cvLayout)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "post")
        postCollectionView.backgroundColor = Constants.colors.backgroundColor
        view.addSubview(postCollectionView)
    }
    
    func logOut() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            self.performSegue(withIdentifier: "logout", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

protocol LikeButtonProtocol {
    func likeButtonClicked(sender: UIButton!)
}

extension FeedViewController: LikeButtonProtocol {
    func likeButtonClicked(sender: UIButton!) {
        //TODO: Implement like button using Firebase transactions!
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postCollectionView.dequeueReusableCell(withReuseIdentifier: "post", for: indexPath) as! PostCollectionViewCell
        cell.awakeFromNib()
        let post = posts[indexPath.row]
        
        cell.interestedButton.setTitle(String(post.likes) + " interested", for: .normal)
        
        if let poster = post.poster {
            cell.posterLabel.text = "By: " + poster
        }
        
        if let name = post.name {
            cell.nameLabel.text = name
        }
        
        if let url = post.imageUrl {
            do {
                try cell.imageView.image = UIImage(data:Data(contentsOf: URL(string: url)!))
            } catch {
                cell.imageView.image = #imageLiteral(resourceName: "failed")
            }
        } else {
            NSLog("No image url found")
        }
        return cell
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: postCollectionView.bounds.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: view.frame.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickedPost = posts[indexPath.row]
        performSegue(withIdentifier: "feedToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feedToDetail" {
            let vc = segue.destination as! DetailViewController
            vc.post = clickedPost
        }
    }
}
