//
//  UIApplicationExtensions.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 14/11/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    // returns the active viewcontroller
    
    public class func toppestViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return toppestViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return toppestViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return toppestViewController(base: presented)
        }
        return base
    }
}
