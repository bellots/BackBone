//
//  UISegmentedControls.swift
//  BackBone
//
//  Created by Andrea Bellotto on 01/02/17.
//  Copyright © 2017 BackBone Srl. All rights reserved.
//

import Foundation
import UIKit


extension UISegmentedControl{
    override open func prepareForInterfaceBuilder() {
        ThemeSegmentedControl.setStyle(for: .standard)
    }
}

@IBDesignable class DefaultSegmentedControl:UISegmentedControl{}
