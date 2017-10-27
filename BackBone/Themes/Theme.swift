//
//  Theme.swift
//  BackBone
//
//  Created by Andrea Bellotto on 06/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

enum Theme{
    case standard
    case dark
    
    func setStyle(){
        ThemeLabel.setStyle(for:self)
        ThemeButton.setStyle(for: self)
        ThemeImageView.setStyle(for: self)
        ThemeUIView.setStyle(for: self)
        ThemeSegmentedControl.setStyle(for: self)
        ThemeSegmentedControlScrollView.setStyle(for: self)
        ThemeTextField.setStyle(for: self)
        ThemeUIPageView.setStyle(for: self)
        ThemeUITextView.setStyle(for: self)
        ThemeFramedTextField.setStyle(for: self)
    }
}


