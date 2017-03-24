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
        view.backgroundColor = Constants.colors.backgroundColor
        
        //Image header
        let imgView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * imgHeight))
        imgView.image = #imageLiteral(resourceName: "MDB_Social_header")
        view.addSubview(imgView)
        
        //Email
        let emailView: InputFieldView = InputFieldView(frame: CGRect(x: 0, y: imgView.frame.maxY + view.frame.height * 0.07, width: view.frame.width, height: view.frame.height * inputHeight), title: "Email")
        view.addSubview(emailView)
        self.emailField = emailView
        
        //Password
        let passwordView: InputFieldView = InputFieldView(frame: CGRect(x: 0, y: emailView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight), title: "Password")
        view.addSubview(passwordView)
        passwordView.textField.isSecureTextEntry = true
        self.passwordField = passwordView
        
        //Buttons View
        let buttonsView: UIView = UIView(frame: CGRect(x: 0, y: passwordView.frame.maxY, width: view.frame.width, height: view.frame.height - passwordView.frame.maxY))
        
        //sign up Button
        let signUpView: UIView = UIView(frame: CGRect(x: 0, y: buttonsView.frame.minY, width: buttonsView.frame.width / 2, height: buttonsView.frame.height))
        let signUpButton: UIButton = UIButton(frame: CGRect(x: signUpView.frame.width / 10, y: signUpView.frame.height / 4, width: signUpView.frame.width * 4 / 5, height: signUpView.frame.height / 3))
        signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        signUpButton.backgroundColor = Constants.colors.buttonColor
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.cornerRadius = 15
        signUpView.addSubview(signUpButton)
        view.addSubview(signUpView)
        
        //login Button
        let loginView: UIView = UIView(frame: CGRect(x: signUpView.frame.maxX, y: buttonsView.frame.minY, width: buttonsView.frame.width / 2, height: buttonsView.frame.height))
        let loginButton: UIButton = UIButton(frame: CGRect(x: loginView.frame.width / 10, y: loginView.frame.height / 4, width: loginView.frame.width * 4 / 5, height: loginView.frame.height / 3))
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        loginButton.backgroundColor = Constants.colors.buttonColor
        loginButton.layer.cornerRadius = 15
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


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

