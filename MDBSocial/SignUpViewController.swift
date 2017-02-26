//
//  SignUpViewController.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/21/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    let fieldHeight: CGFloat = 0.15
    let topSpace: CGFloat = 0.2 // x3
    let buttonSpace: CGFloat = 0.35
    
    var nameView: InputFieldView!
    var emailView: InputFieldView!
    var passView: InputFieldView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLayout() {
        
        view.backgroundColor = UIColor.blue
        
        //Name
        let nameView: InputFieldView = InputFieldView(frame: CGRect(x: 0, y: view.frame.height * topSpace, width: view.frame.width, height: view.frame.height * fieldHeight), title: "Name")
        nameView.backgroundColor = UIColor.yellow
        view.addSubview(nameView)
        self.nameView = nameView
        
        //Email
        let emailView: InputFieldView = InputFieldView(frame: CGRect(x: 0, y: nameView.frame.maxY, width: view.frame.width, height: view.frame.height * fieldHeight), title: "Email")
        emailView.backgroundColor = UIColor.yellow
        view.addSubview(emailView)
        self.emailView = emailView
        
        //password
        let passView: InputFieldView = InputFieldView(frame: CGRect(x: 0, y: emailView.frame.maxY, width: view.frame.width, height: view.frame.height * fieldHeight), title: "Password")
        passView.backgroundColor = UIColor.yellow
        passView.textField.isSecureTextEntry = true
        view.addSubview(passView)
        self.passView = passView
        
        //ButtonsView
        let buttonsView: UIView = UIView(frame: CGRect(x: 0, y: passView.frame.maxY, width: view.frame.width, height: view.frame.height * buttonSpace))
        view.addSubview(buttonsView)
        
        //Back Button
        let backView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: buttonsView.frame.width / 2, height: buttonsView.frame.height))
        backView.backgroundColor = UIColor.cyan
        let backButton: UIButton = UIButton(frame: CGRect(x: backView.frame.width / 10, y: backView.frame.height / 3, width: backView.frame.width * 4 / 5, height: backView.frame.height / 3))
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        backButton.backgroundColor = UIColor.lightGray
        backButton.setTitle("Back", for: .normal)
        backView.addSubview(backButton)
        buttonsView.addSubview(backView)
        
        //Sign Up Button
        let signUpView: UIView = UIView(frame: CGRect(x: buttonsView.frame.width / 2, y: 0, width: buttonsView.frame.width / 2, height: buttonsView.frame.height))
        signUpView.backgroundColor = UIColor.brown
        let signUpButton: UIButton = UIButton(frame: CGRect(x: signUpView.frame.width / 10, y: signUpView.frame.height / 3, width: signUpView.frame.width * 4 / 5, height: signUpView.frame.height / 3))
        signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        signUpButton.backgroundColor = UIColor.lightGray
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpView.addSubview(signUpButton)
        buttonsView.addSubview(signUpView)
    }
    
    func backPressed() {
        performSegue(withIdentifier: "signUpToLogin", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpToLogin" {
        
        } else if segue.identifier == "signUpToFeed" {
            
        }
    }
    
    func signUpPressed() {
        NSLog("Sign up pressed")
        FIRAuth.auth()?.createUser(withEmail: emailView.textField.text!, password: passView.textField.text!, completion: { (user: FIRUser?, error) in
            if error == nil {
                let ref = FIRDatabase.database().reference().child("Users").child((FIRAuth.auth()?.currentUser?.uid)!)
                ref.setValue(["name": self.nameView.textField.text, "email": self.emailView.textField.text])
                self.emailView.textField.text = ""
                self.passView.textField.text = ""
                self.nameView.textField.text = ""
                self.performSegue(withIdentifier: "signUpToFeed", sender: self)
            } else {
                print(error.debugDescription)
                
                if self.passView.textField.text == "" || self.emailView.textField.text == "" || self.nameView.textField.text == "" {
                    self.showBasicAlert(title: "Error", content: "Please fill in all three fields")
                } else if (self.passView.textField.text?.characters.count)! < 6 {
                    self.showBasicAlert(title: "Error", content: "Password needs to be at least 6 characters")
                }
            }
        })
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
}


class InputField: UIView {
    var title: String!
    var textField: UITextField!
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        
        self.title = title
        
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        let label: UILabel = UILabel(frame: CGRect(x: frame.width * 0.1, y: 0, width: frame.width * 0.9, height: frame.height / 3))
        label.text = self.title + ":"
        
        let textField: UITextField = UITextField(frame: CGRect(x: frame.width * 0.1, y: frame.height / 3, width: frame.width * 0.8, height: frame.height * 2 / 3))
        textField.backgroundColor = UIColor.lightGray
        textField.borderStyle = UITextBorderStyle.line
        self.textField = textField
        
        addSubview(label)
        addSubview(textField)
    }
}
