//
//  ClearNavigationViewController.swift
//  BackBone
//
//  Created by Andrea Bellotto on 12/06/17.
//  Copyright © 2017 BackBone Srl. All rights reserved.
//

import UIKit

class ClearNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
