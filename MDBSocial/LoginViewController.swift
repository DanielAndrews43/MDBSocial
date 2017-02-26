//
//  ViewController.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/20/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let imgHeight: CGFloat = 0.4
    let inputHeight: CGFloat = 0.15
    let buttonHeight: CGFloat = 0.1
    
    var emailField: InputFieldView!
    var passwordField: InputFieldView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setLayout() {
        //Image header
        let imgView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * imgHeight))
        imgView.image = #imageLiteral(resourceName: "MDB_Social_header")
        view.addSubview(imgView)
        
        //Email
        let emailView: InputFieldView = InputFieldView(frame: CGRect(x: 0, y: imgView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight), title: "Email")
        emailView.backgroundColor = UIColor.yellow
        view.addSubview(emailView)
        self.emailField = emailView
        
        //Password
        let passwordView: InputFieldView = InputFieldView(frame: CGRect(x: 0, y: emailView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight), title: "Password")
        passwordView.backgroundColor = UIColor.green
        view.addSubview(passwordView)
        passwordView.textField.isSecureTextEntry = true
        self.passwordField = passwordView
        
        //Buttons View
        let buttonsView: UIView = UIView(frame: CGRect(x: 0, y: passwordView.frame.maxY, width: view.frame.width, height: view.frame.height - passwordView.frame.maxY))
        buttonsView.backgroundColor = UIColor.blue
        
        //sign up Button
        let signUpView: UIView = UIView(frame: CGRect(x: 0, y: buttonsView.frame.minY, width: buttonsView.frame.width / 2, height: buttonsView.frame.height))
        signUpView.backgroundColor = UIColor.brown
        let signUpButton: UIButton = UIButton(frame: CGRect(x: signUpView.frame.width / 10, y: signUpView.frame.height / 3, width: signUpView.frame.width * 4 / 5, height: signUpView.frame.height / 3))
        signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        signUpButton.backgroundColor = UIColor.lightGray
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpView.addSubview(signUpButton)
        view.addSubview(signUpView)
        
        //login Button
        let loginView: UIView = UIView(frame: CGRect(x: signUpView.frame.maxX, y: buttonsView.frame.minY, width: buttonsView.frame.width / 2, height: buttonsView.frame.height))
        loginView.backgroundColor = UIColor.cyan
        let loginButton: UIButton = UIButton(frame: CGRect(x: loginView.frame.width / 10, y: loginView.frame.height / 3, width: loginView.frame.width * 4 / 5, height: loginView.frame.height / 3))
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        loginButton.backgroundColor = UIColor.lightGray
        loginButton.setTitle("Login", for: .normal)
        loginView.addSubview(loginButton)
        view.addSubview(loginView)
    }
    
    func loginPressed() {
        NSLog("Login pressed")
        
        FIRAuth.auth()?.signIn(withEmail: emailField.textField.text!, password: passwordField.textField.text!) { (user, error) in
            
            if error == nil {
                //Sign in succesful
                self.performSegue(withIdentifier: "loginToFeed", sender: self)
            } else {
                //Incorrect login
                print(error.debugDescription)
                
                if self.emailField.textField.text == "" || self.passwordField.textField.text == "" {
                    self.showBasicAlert(title: "Error", content: "Please enter your email and password")
                } else {
                    self.showBasicAlert(title: "Error", content: "Incorrect username or password")
                }
            }
        }
    }
    
    func signUpPressed() {
        //Segue into sign up view controller
        performSegue(withIdentifier: "loginToSignUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToSignUp" {
            NSLog("Segue to Sign Up Page")
        }
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

class InputFieldView: UIView {
    var title: String!
    var textField: UITextField!
    
    init (frame: CGRect, title: String) {
        super.init(frame: frame)
        self.title = title
        setLayout(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(frame: CGRect) {
        
        let label: UILabel = UILabel(frame: CGRect(x: frame.width * 0.1, y: 0, width: frame.width, height: frame.height / 3))
        label.text = self.title + ":"
        label.adjustsFontSizeToFitWidth = true
        
        let textField: UITextField = UITextField(frame: CGRect(x: frame.width * 0.1, y: label.frame.maxY * 0.8, width: frame.width * 0.8, height: frame.height * 2 / 3 * 0.6))
        textField.backgroundColor = UIColor.lightGray
        textField.borderStyle = UITextBorderStyle.line
        self.textField = textField
        
        addSubview(label)
        addSubview(textField)
    }
}

