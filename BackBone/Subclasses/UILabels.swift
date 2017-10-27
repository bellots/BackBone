//
//  UILabels.swift
//  BackBone
//
//  Created by Andrea Bellotto on 26/01/17.
//  Copyright © 2017 BackBone Srl. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    override open func prepareForInterfaceBuilder() {
        ThemeLabel.setStyle(for: .standard)
    }
}


@IBDesignable class DefaultLabel:UILabel{}
@IBDesignable class CircleLabel:DefaultLabel{
    override func layoutSubviews() {
        super.layoutSubviews()
        self.borderWidth = 1
        self.cornerRadius = self.frame.size.width / 2
    }
}
@IBDesignable class YellowCircleLabel:CircleLabel{
    override func layoutSubviews() {
        super.layoutSubviews()
        self.borderWidth = 0
        self.cornerRadius = self.frame.size.width / 2
    }

}

@IBDesignable class PrimaryLabel:DefaultLabel{}
@IBDesignable class SecondaryLabel:DefaultLabel{}
@IBDesignable class ContrastSecondaryLabel:DefaultLabel{}
@IBDesignable class AlphaContrastSecondaryLabel:DefaultLabel{}

@IBDesignable class SubtitleLabel:DefaultLabel{}
@IBDesignable class PrimarySubtitleLabel:PrimaryLabel{}
@IBDesignable class SecondarySubtitleLabel:SecondaryLabel{}
@IBDesignable class ContrastSecondarySubtitleLabel:ContrastSecondaryLabel{}

@IBDesignable class LargerLabel:DefaultLabel{}
@IBDesignable class LargerPrimaryLabel:PrimaryLabel{}
@IBDesignable class AlphaContrastSecondarySubtitleLabel:AlphaContrastSecondaryLabel{}

@IBDesignable class BoldLabel:DefaultLabel{}
@IBDesignable class BoldPrimaryLabel:PrimaryLabel{}
@IBDesignable class BoldSecondaryLabel:SecondaryLabel{}
@IBDesignable class BoldContrastSecondaryLabel:ContrastSecondaryLabel{}

@IBDesignable class LargerBoldPrimaryLabel:LargerPrimaryLabel{}

@IBDesignable class CustomizableLabel:DefaultLabel{
    func setup(with hexString:String){
        self.textColor = UIColor(hexString: hexString)
    }
}
@IBDesignable class CustomizableBoldLabel:CustomizableLabel{}
@IBDesignable class CustomizableSubtitleLabel:CustomizableLabel{}
