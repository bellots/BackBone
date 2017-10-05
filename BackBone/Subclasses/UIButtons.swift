//
//  UIButtons.swift
//  BackBone
//
//  Created by Andrea Bellotto on 26/01/17.
//  Copyright © 2017 BackBone Srl. All rights reserved.
//

import Foundation
import UIKit


extension UIButton{
    override open func prepareForInterfaceBuilder() {
        ThemeButton.setStyle(for: .standard)
    }
}


@IBDesignable class DefaultButton:UIButton{
    
    var heightConstraint:NSLayoutConstraint?
    
    dynamic public var frameHeight:CGFloat{
        get{
            if let heightConstraint = heightConstraint{
                return heightConstraint.constant
            }
            else{
                return 50
            }
        }
        set{
            if let heightConstraint = heightConstraint{
                heightConstraint.constant = newValue
                layoutIfNeeded()

            }
            else{
                heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: newValue)
                heightConstraint?.priority = 999
                heightConstraint?.isActive = true
                layoutIfNeeded()

            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }

}

@IBDesignable class ScrollingTabButton:DefaultButton{
    enum `Type`{
        case selected
        case deselected
    }
    
    var type:Type = .deselected{
        didSet{
            switch type{
            case .deselected:
                self.backgroundColor = .clear
            case .selected:
                self.backgroundColor = .black
            }
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type{
        case .deselected:
            self.backgroundColor = .clear
        case .selected:
            self.backgroundColor = .black
        }
    }
}

@IBDesignable class DashedButton:DefaultButton{
    
    var privateLineWidth:CGFloat = 2.0
    var privateStrokeColor:UIColor = .black
    var borderLayer:CALayer?
    
    @IBInspectable public var lineWidth: CGFloat {
        get {
            return privateLineWidth
        }
        set {
            privateLineWidth = newValue
        }
    }
    
    @IBInspectable public var strokeColor: UIColor {
        get {
            return privateStrokeColor
        }
        set {
            privateStrokeColor = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let borderLayer = borderLayer {
            borderLayer.removeFromSuperlayer()
        }
        self.borderLayer = addDashedBorder(strokeColor: privateStrokeColor, lineWidth: privateLineWidth)
    }
}

@IBDesignable class CircleButton:DefaultButton{
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = self.frame.size.width / 2
    }
}


//MARK: - Buttons with Image subclasses

@IBDesignable class DefaultButtonWithImage:ButtonWithImageView {
    
    override func setup() {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: ButtonWithImageView.nameIdentifier, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
}
@IBDesignable class PlaceholderButtonWithImage:DefaultButtonWithImage{
    
    var privateLineWidth:CGFloat = 2.0
    var privateStrokeColor:UIColor = .black
    
    @IBInspectable public var lineWidth: CGFloat {
        get {
            return privateLineWidth
        }
        set {
            privateLineWidth = newValue
        }
    }
    
    @IBInspectable public var strokeColor: UIColor {
        get {
            return privateStrokeColor
        }
        set {
            privateStrokeColor = newValue
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addDashedBorder(strokeColor: privateStrokeColor, lineWidth: privateLineWidth)
    }
}


@IBDesignable class SelectableButton:DefaultButton{
    
    let borderLayer = CAShapeLayer()
    
    dynamic public var strokeColor: UIColor? {
        get {
            guard let strokeColor = borderLayer.strokeColor else{
                return UIColor.black
            }
            return UIColor(cgColor: strokeColor)
        }
        set {
            borderLayer.strokeColor = newValue?.cgColor
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderLayer.lineWidth = 1
        borderLayer.fillColor = UIColor.clear.cgColor
        titleLabel?.layer.addSublayer(borderLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let optionalLabel = self.titleLabel
        
        guard let label = optionalLabel else{
            return
        }
        
        let frame = CGRect(x: -10, y: -5, width: label.frame.size.width + 20, height: label.frame.size.height + 10)
        
        let path = UIBezierPath(roundedRect: frame, cornerRadius: frame.size.height / 2)
        
        borderLayer.path = path.cgPath
        
    }
    
}

