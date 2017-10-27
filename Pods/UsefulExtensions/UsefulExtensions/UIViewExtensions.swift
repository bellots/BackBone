//
//  UIViewExtensions.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 14/11/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // returns the name of the view in string

    public class var nameIdentifier:String {
        return String(describing: self)
    }
    
    // MARK: - used in custom xib.
    /*
     If you create an IBDesignable UIView Subclass, if you call setup() in
     init with decoder and init with frame, it shows your custom UIView directly
     in your storyboard
     */
    
    public func loadViewFromNib() -> UIView
    {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: type(of: self).nameIdentifier, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

    open func setup()
    {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
    
    // MARK: -
    
    // updates constraint constant animating
    
    public func change(constraint:NSLayoutConstraint, constantWith value:CGFloat, andAnimating animate:Bool){
        constraint.constant = value
        if animate{
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
            })
        }
        else{
            self.layoutIfNeeded()
        }
    }
    
    // fades UIView Out, In, and Toggle with animation
    
    public func fadeOut(withAnimation animate:Bool){
        if animate{
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }, completion: { (success) in
                if success{
                    self.isHidden = true
                }
            })
        }
        else{
            self.alpha = 0
            self.isHidden = true
            
        }
    }
    public func fadeIn(withAnimation animate:Bool){
        self.isHidden = false
        
        if animate{
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1
            }, completion: { (success) in
                if success{
                }
            })
        }
        else{
            self.alpha = 1
            
        }
    }
    public func fade(withAnimation animate:Bool){
        if animate{
            self.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                if self.alpha == 0{
                    self.alpha = 1
                }
                else{
                    self.alpha = 0
                }
                
            }, completion: { (success) in
                if success{
                    if self.alpha == 0{
                        self.isHidden = true
                    }
                }
            })
        }
        else{
            if self.alpha == 0{
                self.isHidden = false
                self.alpha = 1
                
            }
            else{
                self.alpha = 0
                self.isHidden = true
                
            }
        }
    }
    
    //MARK: - Top Constraint utility (topConstraints var returns top constraints)
    
    func firstMatchesConstraint(constraint:NSLayoutConstraint)->Bool{
        return constraint.firstItem as? NSObject == self && constraint.firstAttribute == .top
    }
    func secondMatchesConstraint(constraint:NSLayoutConstraint)->Bool{
        return constraint.secondItem as? NSObject == self && constraint.firstAttribute == .top
    }
    func isTopConstraint(constraint:NSLayoutConstraint)->Bool{
        return firstMatchesConstraint(constraint: constraint) || secondMatchesConstraint(constraint: constraint)
    }
    public var topConstraints:[NSLayoutConstraint]{
        return (self.constraints.filter({isTopConstraint(constraint: $0)}) + self.constraintsAffectingLayout(for: .vertical).filter({isTopConstraint(constraint: $0)}))
    }
    
    //MARK: - Add a dashed border to the current UIView
    
    public func addDashedBorder(strokeColor: UIColor, lineWidth: CGFloat)->CALayer {
        self.layoutIfNeeded()
        let strokeColor = strokeColor.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        
        shapeLayer.lineDashPattern = [5,5] // adjust to your liking
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: shapeRect.width, height: shapeRect.height), cornerRadius: self.layer.cornerRadius).cgPath
        
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }

    
    
    // Variables for corner radius and border accessibles from storyboard
    
    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            if let layerColor = layer.borderColor {
                return UIColor(cgColor: layerColor)
            } else {
                return UIColor(white: 0, alpha: 0);
            }
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
