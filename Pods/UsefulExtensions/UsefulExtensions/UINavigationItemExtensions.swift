//
//  UINavigationItemExtensions.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 14/11/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem{
    public func addDismissLeftButton(target:AnyObject, selector:Selector, image:UIImage, scale:CGFloat){
        self.hidesBackButton = true
        let originalImage = image
        let scaledIcon = UIImage(cgImage: originalImage.cgImage!, scale: scale, orientation: originalImage.imageOrientation)
        let leftItem = UIBarButtonItem(image: scaledIcon, style: .plain, target: target, action: selector)
        self.leftBarButtonItem = leftItem
    }
}
