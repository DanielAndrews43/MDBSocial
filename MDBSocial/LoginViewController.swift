//
//  ViewController.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/20/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imgHeight: CGFloat = 0.4
    let inputHeight: CGFloat = 0.15
    let buttonHeight: CGFloat = 0.1
    
    var emailField: UIView!
    var passwordField: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
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
        let emailView: UIView = InputFieldView(frame: CGRect(x: 0, y: imgView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight), title: "Email")
        emailView.backgroundColor = UIColor.yellow
        view.addSubview(emailView)
        self.emailField = emailView
        
        //Password
        let passwordView: UIView = InputFieldView(frame: CGRect(x: 0, y: emailView.frame.maxY, width: view.frame.width, height: view.frame.height * inputHeight), title: "Password")
        passwordView.backgroundColor = UIColor.green
        view.addSubview(passwordView)
        self.passwordField = passwordView
        
        //Buttons View
        let buttonsView: UIView = UIView(frame: CGRect(x: 0, y: passwordView.frame.maxY, width: view.frame.width, height: view.frame.height - passwordView.frame.maxY))
        buttonsView.backgroundColor = UIColor.blue
        
        //login Button
        let loginView: UIView = UIView(frame: CGRect(x: 0, y: buttonsView.frame.minY, width: buttonsView.frame.width / 2, height: buttonsView.frame.height))
        loginView.backgroundColor = UIColor.cyan
        let loginButton: UIButton = UIButton(frame: CGRect(x: loginView.frame.width / 10, y: loginView.frame.height / 3, width: loginView.frame.width * 4 / 5, height: loginView.frame.height / 3))
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        loginButton.backgroundColor = UIColor.lightGray
        loginView.addSubview(loginButton)
        view.addSubview(loginView)
        
        
        //sign up Button
        let signUpView: UIView = UIView(frame: CGRect(x: loginView.frame.maxX, y: buttonsView.frame.minY, width: buttonsView.frame.width / 2, height: buttonsView.frame.height))
        signUpView.backgroundColor = UIColor.brown
        let signUpButton: UIButton = UIButton(frame: CGRect(x: signUpView.frame.width / 10, y: signUpView.frame.height / 3, width: signUpView.frame.width * 4 / 5, height: signUpView.frame.height / 3))
        signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        signUpButton.backgroundColor = UIColor.lightGray
        signUpView.addSubview(signUpButton)
        view.addSubview(signUpView)
    }
    
    func loginPressed() {
        
        
        //Firebase auth
    }
    
    func signUpPressed() {
        
        //Segue into sign up view controller
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

