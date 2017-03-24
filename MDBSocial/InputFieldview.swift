//
//  InputFieldview.swift
//  MDBSocial
//
//  Created by Daniel Andrews on 3/23/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

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
        label.textColor = UIColor.white
        
        let textField: UITextField = UITextField(frame: CGRect(x: frame.width * 0.1, y: label.frame.maxY * 0.8, width: frame.width * 0.8, height: frame.height * 2 / 3 * 0.6))
        textField.backgroundColor = UIColor.lightGray
        textField.borderStyle = UITextBorderStyle.line
        self.textField = textField
        
        addSubview(label)
        addSubview(textField)
    }
}
