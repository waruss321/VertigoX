//
//  UITextField.swift
//  FittedSheets
//
//  Created by Russell Warwick on 27/12/2019.
//

import UIKit

public extension UITextField {
    
    convenience init(placeholder: String? = nil, text: String? = nil, isSecure: Bool = false, background: UIColor = .lightGray, corner: CGFloat = 5, keyboard: UIKeyboardType = .default){
        self.init()
        self.placeholder = placeholder
        self.text = text
        self.isSecureTextEntry = isSecure
        self.keyboardType = keyboard
        self.borderStyle = .none
        self.backgroundColor = background
        self.layer.masksToBounds = true
        self.layer.cornerRadius = corner
    }
}
