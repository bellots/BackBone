//
//  UIViews.swift
//  BackBone
//
//  Created by Andrea Bellotto on 31/01/17.
//  Copyright © 2017 BackBone Srl. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    override open func prepareForInterfaceBuilder() {
        ThemeUIView.setStyle(for: .standard)
    }
}
@IBDesignable class DefaultView:UIView{}
@IBDesignable class SeparatorView:DefaultView {}
@IBDesignable class LightView:DefaultView {}
@IBDesignable class LightWithLessCornerRadiusView:LightView{}
@IBDesignable class DarkView:DefaultView{}
@IBDesignable class LightNoBorderView:LightView{}
@IBDesignable class DarkNoBorderView:DarkView{}
@IBDesignable class BorderedView:DefaultView{}
@IBDesignable class LightBorderedView:LightView{}
@IBDesignable class WhiteBorderedView:LightBorderedView{}



@IBDesignable class CircleBorderedView:BorderedView{
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = self.frame.size.width / 2
    }
}

@IBDesignable class LightCircleBorderedView:CircleBorderedView{}
@IBDesignable class MainColorFillView:UIView{}

@IBDesignable class MainColorFillCircleView:MainColorFillView{
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = self.frame.size.width / 2
    }
}

@IBDesignable class ContainerView:UIView{}
@IBDesignable class DarkerView:ContainerView{}
@IBDesignable class MainGrayAlphaView:DefaultView{}
@IBDesignable class DarkerNoBorderView:DarkerView{}
