//
//  UIAlertControllerExtensions.swift
//  UsefulExtensions
//
//  Created by Andrea Bellotto on 06/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

extension UIAlertController{
    public class func show(withTitle title:String, message:String, cancelTitle:String, actionCancel:(()->Void)?, inViewController viewController:UIViewController){
        let noAction = UIAlertController(title: title, message: message, preferredStyle: .alert)
        noAction.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            if let action = actionCancel{
                action()
            }
        }))
        viewController.present(noAction, animated: true, completion: nil)
        
    }
}
