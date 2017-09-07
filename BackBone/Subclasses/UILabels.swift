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
        ThemeUIView.setStyle(for: .standard)
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
