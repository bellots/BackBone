//
//  UIImageView.swift
//  BackBone
//
//  Created by Andrea Bellotto on 14/11/16.
//  Copyright © 2016 BackBone Srl. All rights reserved.
//

import UIKit
import SDWebImage
import AlamofireImage

extension UIImageView{
    override open func prepareForInterfaceBuilder() {
        ThemeImageView.setStyle(for: .standard)
    }
}

@IBDesignable class TintedImageView: UIImageView {
    
    @IBInspectable var tintUIImageView: UIColor = UIColor.black{
        didSet {
            setupView()
        }
    }
    
    var enabled:Bool = true{
        didSet{
            tintUIImageView = enabled ? .black : .lightGray
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    override init(image: UIImage?) {
        super.init(image:image)
        setupView()
    }
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView(){
        self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = self.tintUIImageView
    }

}

protocol PlaceholderedImageViewDelegate:class{
    func imageDidTap(imageView:PlaceholderedImageView)
}

@IBDesignable class PlaceholderedImageView:UIImageView{
    
    var isResized = false
    var isTapEnabled = false
    weak var delegate:PlaceholderedImageViewDelegate?
    
    func setup(with url:String?, placeholder:UIImage? = nil){
        if let urlString = url {
            self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder)
        }
        else{
            self.image = placeholder
        }
    }

    override var image: UIImage?{
        didSet {
            guard let image = self.image else{
                if isTapEnabled {
                    if let gestures = self.gestureRecognizers{
                        for gesture in gestures{
                            self.removeGestureRecognizer(gesture)
                        }
                    }
                }
                return
            }
            if !isResized{
                isResized = true
                self.image = image.af_imageAspectScaled(toFill: self.frame.size)
                isResized = false
                if isTapEnabled {
                    self.isUserInteractionEnabled = true
                    if let gestures = self.gestureRecognizers{
                        for gesture in gestures{
                            self.removeGestureRecognizer(gesture)
                        }
                    }
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDidTap(sender:)))
                    self.addGestureRecognizer(tapGesture)
                }
            }
        }
    }
    
    func imageDidTap(sender:UITapGestureRecognizer){
        delegate?.imageDidTap(imageView: self)
    }
}


@IBDesignable class AvatarImageView:PlaceholderedImageView{

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = self.frame.size.width / 2
    }
    
}
