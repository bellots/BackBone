//
//  ThemeButton.swift
//  BackBone
//
//  Created by Andrea Bellotto on 26/01/17.
//  Copyright © 2017 BackBone Srl. All rights reserved.
//

import Foundation
import UIKit

struct ThemeButton{
    static func setStyle(for theme:Theme){
        switch theme {
        case .standard:
            CircleButton.appearance().backgroundColor = UIColor.purple
            return
        case .dark:
            return
        }
    }
}
