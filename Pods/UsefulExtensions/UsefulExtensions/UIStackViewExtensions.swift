//
//  UIStackViewExtensions.swift
//  UsefulExtensions
//
//  Created by Andrea Bellotto on 29/01/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

extension UIStackView {
    public func add(_ view:UIView, width:CGFloat){
        self.addArrangedSubview(view)
        let tempWidth = view.widthAnchor.constraint(equalToConstant: width)
        tempWidth.isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
