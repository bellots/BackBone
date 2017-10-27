//
//  UITextFieldExtensions.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 19/12/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import Foundation

extension UITextField{
    
    // changes placeholder text color
    
    @IBInspectable public var placeholderColor: UIColor? {
        get {
            return self.placeholderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}
