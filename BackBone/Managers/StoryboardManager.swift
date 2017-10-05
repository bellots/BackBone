//
//  StoryboardManager.swift
//  BackBone
//
//  Created by Andrea Bellotto on 05/10/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation
import UIKit

enum Storyboard:String{
    case main =                 "Main"

    var storyboard:UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
enum ViewController:String{
    case test =                          ""
}

extension UIStoryboard{
    class func get(_ storyboard:Storyboard)->UIStoryboard{
        return UIStoryboard(name: storyboard.rawValue, bundle: nil)
    }
    func get(_ viewController:ViewController)->UIViewController{
        return self.instantiateViewController(withIdentifier: viewController.rawValue)
    }
}

