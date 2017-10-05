//
//  UIViewExtensions.swift
//  BackBone
//
//  Created by Andrea Bellotto on 05/10/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func firstMatchesConstraint(constraint:NSLayoutConstraint)->Bool{
        return constraint.firstItem as? NSObject == self && constraint.firstAttribute == .top
    }
    func secondMatchesConstraint(constraint:NSLayoutConstraint)->Bool{
        return constraint.secondItem as? NSObject == self && constraint.firstAttribute == .top
    }
    func isTopConstraint(constraint:NSLayoutConstraint)->Bool{
        return firstMatchesConstraint(constraint: constraint) || secondMatchesConstraint(constraint: constraint)
    }
}
