//
//  SignUpViewController.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 2/21/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLayout() {
    
        //Choose picture
        
        //Name
        
        //Email
        
        //password
        
        //Sign up button
        
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
