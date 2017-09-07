//
//  UIViewControllerExtensions.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 14/11/16.
//  Copyright © 2016 JoeBee Srl. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
    
    // returns the name of the viewcontroller in string
    
   public class var nameIdentifier:String {
        return String(describing: self)
    }
    
    
    /*  presents the view controller in param.
        If EmbedInNavigationController is true, it embeds the ViewController 
        inside a UINavigationController
    */
    
    public func present(viewControllerToPresent viewController:UIViewController, animated:Bool, embedInNavigationController:Bool, completion:(() -> Void)?){
        if embedInNavigationController {
            let navContr = UINavigationController(rootViewController: viewController)
            self.present(navContr, animated: animated, completion: completion)
        }
        else {
            self.present(viewController, animated: animated, completion: completion)
        }
    }
    
}

