//
//  ButtonWithImageView.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 07/02/17.
//  Copyright © 2017 JoeBee Srl. All rights reserved.
//

import UIKit

protocol ButtonWithImageViewDelegate:class{
    func didClickButton(button:ButtonWithImageView)
}

@IBDesignable
class ButtonWithImageView: UIView {

    @IBOutlet var placeholderImageView: TintedImageView!
    
    @IBOutlet var mainButton: DefaultButton!
    
    @IBOutlet var mainLabel: DefaultLabel!
    
    
    weak var delegate:ButtonWithImageViewDelegate?
    
    public dynamic var placeholderImage:UIImage?{
        get{ return placeholderImageView.image }
        set{ self.placeholderImageView.image = newValue }
    }
    
    public dynamic var mainButtonBackgroundColor:UIColor?{
        get{ return mainButton.backgroundColor }
        set{ self.mainButton.backgroundColor = newValue }
    }
    
    public dynamic var mainButtonTextColor:UIColor?{
        //        get{ return mainButton.textColor }
        //        set{ self.mainButton.setTitleColor(newValue, for: .normal) }
        get{ return mainLabel.textColor }
        set{ self.mainLabel.textColor = newValue }
        
    }

    public dynamic var labelFontSize:UIFont?{
        get{return mainLabel.font}
        set{mainLabel.font = newValue}
    }

    
    @IBInspectable var titleButton:String = "Undefined"{
        didSet{
            mainLabel.text = titleButton
//            mainButton.setTitle(titleButton, for: .normal)
        }
    }
    
    public dynamic var tintImage:UIColor?{
        get{ return placeholderImageView.tintUIImageView }
        set{ self.placeholderImageView.tintUIImageView = newValue ?? .black }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        setup()
    }
    
    @IBAction func buttonAction(_ sender: DefaultButton) {
        delegate?.didClickButton(button: self)
    }

}
