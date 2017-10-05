//
//  ThemeLabel.swift
//  BackBone
//
//  Created by Andrea Bellotto on 26/01/17.
//  Copyright © 2017 BackBone Srl. All rights reserved.
//

import Foundation
import UIKit

struct ThemeLabel{
    static func setStyle(for theme:Theme){
        switch theme {
        case .standard:
            DefaultLabel.appearance().font = Constants.Font.Regular.medium
            SecondaryLabel.appearance().textColor = Constants.Label.TextColor.secondary
            PrimaryLabel.appearance().textColor = Constants.Label.TextColor.primary
            ContrastSecondaryLabel.appearance().textColor = Constants.Label.TextColor.contrastSecondary
            AlphaContrastSecondaryLabel.appearance().textColor = Constants.Label.TextColor.alphaContrastSecondary
            
            BoldLabel.appearance().font = Constants.Font.Bold.medium
            BoldPrimaryLabel.appearance().font = Constants.Font.Bold.medium
            BoldSecondaryLabel.appearance().font = Constants.Font.Bold.medium
            BoldContrastSecondaryLabel.appearance().font = Constants.Font.Bold.medium
            
            SubtitleLabel.appearance().font = Constants.Font.Regular.small
            PrimarySubtitleLabel.appearance().font = Constants.Font.Regular.small
            SecondarySubtitleLabel.appearance().font = Constants.Font.Regular.small
            ContrastSecondarySubtitleLabel.appearance().font = Constants.Font.Regular.small
            AlphaContrastSecondarySubtitleLabel.appearance().font = Constants.Font.Regular.small
            
            LargerLabel.appearance().font = Constants.Font.Regular.larger
            
            LargerBoldPrimaryLabel.appearance().font = Constants.Font.Bold.larger
            
            CircleLabel.appearance().borderWidth = 2
            CircleLabel.appearance().borderColor = UIColor.red
            
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:Constants.Font.Bold.large]
            
            
            CustomizableBoldLabel.appearance().font = Constants.Font.Bold.medium
            CustomizableSubtitleLabel.appearance().font = Constants.Font.Regular.small
            return
        case .dark:
            return
        }
    }
}
