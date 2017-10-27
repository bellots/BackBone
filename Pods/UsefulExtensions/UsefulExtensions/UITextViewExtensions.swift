//
//  UITextViewExtensions.swift
//  UsefulExtensions
//
//  Created by Andrea Bellotto on 06/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

extension UITextView{
    
    
    public var placeholder:String?{
        get{
            // Get the placeholder text from the label
            var placeholderText: String?
            
            if let placeHolderLabel = self.viewWithTag(222) as? UILabel {
                placeholderText = placeHolderLabel.text
            }
            return placeholderText
        }
        set{
            
            var placeholderLabel = UILabel()
            if let oldPlaceHolderLabel = self.viewWithTag(222) as? UILabel {
                placeholderLabel = oldPlaceHolderLabel
            }
            placeholderLabel.text = newValue
            placeholderLabel.textColor = UILabel.appearance().textColor
            placeholderLabel.font = self.font
            placeholderLabel.sizeToFit()
            placeholderLabel.tag = 222
            placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
            placeholderLabel.isHidden = !self.text.isEmpty
            self.addSubview(placeholderLabel)
        }
    }
    
    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
}
