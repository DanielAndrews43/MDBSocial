//
//  NewSocialViewController.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/23/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit
import Firebase

class NewSocialViewController: UIViewController {

    var titleView: InputTextView!
    var locationView: InputTextView!
    var timeView: InputTextView!
    var textView: InputTextView!
    var imageUpload: UIImageView!
    var selectFromLibraryButton: UIButton!
    
    var auth = FIRAuth.auth()
    var postsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Posts")
    var storage: FIRStorageReference = FIRStorage.storage().reference()
    var currentUser: User?
    let picker = UIImagePickerController()
    
    let viewTitleHeight: CGFloat = 0.1
    let inputHeight: CGFloat = 0.1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 

        setupLayout()
    }
    
    func setupLayout() {
        let viewTitleView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * viewTitleHeight))
        let viewTitleLabel: UILabel = UILabel(frame: CGRect(x: viewTitleView.frame.width / 5, y: viewTitleView.frame.height / 5, width: viewTitleView.frame.width * 3 / 5, height: viewTitleView.frame.height * 3 / 5))
        viewTitleView.addSubview(viewTitleLabel)
        view.addSubview(viewTitleView)
        
        //Set title
        titleView = InputTextView(frame: CGRect(x: 0, y: viewTitleView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight), title: "Title")
        view.addSubview(titleView)
        
        //Upload image
        
        //Add location?
        locationView = InputTextView(frame: CGRect(x: 0, y: titleView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight), title: "Location")
        view.addSubview(locationView)
        
        //Add time?
        timeView = InputTextView(frame: CGRect(x: 0, y: locationView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight), title: "Time")
        view.addSubview(timeView)
        
        //Add text
        textView = InputTextView(frame: CGRect(x: 0, y: timeView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight), title: "Description")
        view.addSubview(textView)
        
        //Add image
        let imageHolder: UIView = UIView(frame: CGRect(x: 0, y: textView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight))
        
        let imageLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: imageHolder.frame.width / 3, height: imageHolder.frame.height))
        imageLabel.text = "Event Image:"
        imageLabel.adjustsFontSizeToFitWidth = true
        imageLabel.textAlignment = .right
        imageHolder.addSubview(imageLabel)
        
        imageUpload = UIImageView(frame: CGRect(x: imageLabel.frame.maxX + imageHolder.frame.width * 0.1, y: imageHolder.frame.height / 4, width: imageHolder.frame.width * 2 / 3 - imageHolder.frame.width * 0.2, height: imageHolder.frame.height / 2))
        selectFromLibraryButton = UIButton(frame: imageUpload.frame)
        selectFromLibraryButton.setTitle("Pick", for: .normal)
        selectFromLibraryButton.setTitleColor(UIColor.blue, for: .normal)
        selectFromLibraryButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        selectFromLibraryButton.backgroundColor = UIColor.black
        imageHolder.addSubview(imageUpload)
        imageHolder.addSubview(selectFromLibraryButton)
        
        view.addSubview(imageHolder)
        
        //Post button / back button
        let postButton: UIButton = UIButton(frame: CGRect(x: 0, y: imageHolder.frame.maxY, width: view.frame.width, height: view.frame.height - imageHolder.frame.maxY))
        postButton.setTitle("Post!", for: .normal)
        postButton.setTitleColor(UIColor.blue, for: .normal)
        postButton.addTarget(self, action: #selector(post), for: .touchUpInside)
        postButton.backgroundColor = UIColor.lightGray
        view.addSubview(postButton)
    }
    
    func pickImage(sender: UIButton!) {
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Shows a basic alert with an "OK" button to dismiss.
     
     - parameters:
     - title: title to display at the top of the alert
     - content: message to display in alert
     - currVC: the ViewController in which this function is being called
     */
    func showBasicAlert(title: String, content: String) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) {
            action in
            
            alert.dismiss(animated: true, completion: nil)
            
        })
        
        self.present(alert, animated: true, completion: nil)
    }

    func post() {
         let stuff = "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwiE_MaU4KzSAhVKVWMKHe_WAqwQjRwIBw&url=https%3A%2F%2Fnewsroom.uber.com%2Fuberkittens-are-back%2F&psig=AFQjCNFlybH9Tl8uX_dMLeAMXSMmPlZLCw&ust=1488163756269893"
        if let img = imageUpload.image {
            let imageData = UIImageJPEGRepresentation(img, 0.9)
            let ref = FIRDatabase.database().reference().child("Posts").child((FIRAuth.auth()?.currentUser?.uid)!)
            let storage = FIRStorage.storage().reference().child("pics/\((FIRAuth.auth()?.currentUser?.uid)!)")
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            storage.put(imageData!, metadata: metadata).observe(.success) { (snapshot) in
                let url = snapshot.metadata?.downloadURL()?.absoluteString
                
                var post1 = ["posterID": self.currentUser?.id ?? 12345,
                             "imageURL": url ?? stuff,
                             "likes": 0] as [String : Any]
                var post2 = ["name": self.titleView.textField.text ?? "Kitten Kuddle",
                             "poster": self.currentUser?.name ?? "Daniel Andrews",
                             "text": self.textView.textField.text ?? "Come kuddle with kittens!"] as [String : Any]
                var post3 = ["location": self.locationView.textField.text ?? "Disneyland",
                             "time": self.timeView.textField.text ?? "summer time!"] as [String : Any]
                
                for key in post2.keys {
                    post1[key] = post2[key]
                }
                
                for key in post3.keys {
                    post1[key] = post3[key]
                }
                
                ref.setValue(post1)
                self.performSegue(withIdentifier: "newSocialToFeed", sender: self)
                
            }
        } else {
            showBasicAlert(title: "Error", content: "Please choose an image")
            return
        }
    }
}

class InputTextView: UIView {
    var textField: UITextField!
    var title: String!
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        
        self.title = title
        
        setLayout(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(frame: CGRect) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width / 3, height: frame.height))
        titleLabel.text = self.title + ":"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .right
        addSubview(titleLabel)
        
        textField = UITextField(frame: CGRect(x: titleLabel.frame.maxX + frame.width * 0.1, y: frame.height / 4, width: frame.width * 2 / 3 - frame.width * 0.2, height: frame.height / 2))
        textField.backgroundColor = UIColor.lightGray
        addSubview(textField)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension NewSocialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectFromLibraryButton.removeFromSuperview()
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageUpload.contentMode = .scaleAspectFit
        imageUpload.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
