//
//  Constants.swift
//  BackBone
//
//  Created by Andrea Bellotto on 04/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation
import UIKit

enum Constants{
    
    static let fontRegularName =        "Verdana"
    static let fontBoldName =           "Verdana-Bold"
    
    
    
    static func regularFont(ofSize size:CGFloat)->UIFont{
        return UIFont(name: fontRegularName, size: size)!
    }
    
    static func boldFont(ofSize size:CGFloat)->UIFont{
        return UIFont(name: fontBoldName, size: size)!
    }
    
    
    
    //MARK: - Endpoints
    
    static let endPoint:String =                        "https://endpoint"
    
    
    //MARK: - EventIDs
    
    
    enum Size{
        enum Font {
            static let small:CGFloat =      12.0
            static let medium:CGFloat =     15.0
            static let large:CGFloat =      17.0
            static let larger:CGFloat =     24.0
        }
    }
    
    enum Font{
        
        enum Regular{
            static let small =          Constants.regularFont(ofSize: Size.Font.small)
            static let medium =         Constants.regularFont(ofSize: Size.Font.medium)
            static let large =          Constants.regularFont(ofSize: Size.Font.large)
            static let larger =         Constants.regularFont(ofSize: Size.Font.larger)
            
            static func sized(_ size:CGFloat)->UIFont{
                return Constants.regularFont(ofSize:size)
            }
        }
        
        enum Bold{
            static let small =          Constants.boldFont(ofSize: Size.Font.small)
            static let medium =         Constants.boldFont(ofSize: Size.Font.medium)
            static let large =          Constants.boldFont(ofSize: Size.Font.large)
            static let larger =         Constants.boldFont(ofSize: Size.Font.larger)
            
            static func sized(_ size:CGFloat)->UIFont{
                return Constants.boldFont(ofSize:size)
            }
        }
        
        static let boldDefaultText:UIFont =     Bold.medium
        static let regularDefaultText:UIFont =  Regular.medium
        
        static let boldSmallText:UIFont =       Bold.small
        static let regularSmallText:UIFont =    Regular.small
        
    }
    
    private enum Color{
        static let primary:UIColor =                UIColor(hexString: "#093566")
        static let contrastPrimary:UIColor =        UIColor.white
        static let secondary:UIColor =              UIColor(hexString: "#E67830")
        static let contrastSecondary:UIColor =      UIColor.white
        static let alphaPrimary:UIColor =           UIColor(hexString: "#003B79")
        static let alphaContrastSecondary:UIColor = UIColor(hexString: "#F3A458")
        static let deselectedPrimary:UIColor =      UIColor.gray
        static let deselectedSecondary:UIColor =    UIColor.gray
        static let selected:UIColor =               UIColor.white
        static let mainBackground:UIColor =         UIColor.clear
        
    }
    
    enum Label {
        enum TextColor{
            static let primary:UIColor =                Color.primary
            static let contrastPrimary:UIColor =        Color.contrastPrimary
            static let secondary:UIColor =              Color.secondary
            static let contrastSecondary:UIColor =      Color.contrastSecondary
            static let alphaContrastSecondary:UIColor = Color.alphaContrastSecondary
        }
        enum Background{
            static let primary:UIColor =                Color.mainBackground
            static let contrastPrimary:UIColor =        Color.mainBackground
            static let secondary:UIColor =              Color.mainBackground
            static let contrastSecondary:UIColor =      Color.mainBackground
        }
    }
    
    enum SegmentedControl{
        enum BarBackgroundColor{
            static let primary:UIColor =                Color.primary
            static let secondary:UIColor =              Color.secondary
        }
        enum ButtonBackgroundColor{
            static let primary:UIColor =                Color.primary
            static let secondary:UIColor =              Color.secondary
        }
        enum TextColor{
            static let selectedPrimary:UIColor =        Color.contrastPrimary
            static let selectedSecondary:UIColor =      Color.contrastSecondary
            static let deselectedPrimary:UIColor =      Color.contrastPrimary
            static let deselectedSecondary:UIColor =    Color.contrastSecondary
        }
    }
    
    enum NavigationBar{
        enum TintColor{
            static let contrastPrimary:UIColor =        Color.contrastPrimary
            static let contrastSecondary:UIColor =      Color.contrastSecondary
        }
        enum BackgroundColor{
            static let primary:UIColor =                Color.primary
            static let secondary:UIColor =              Color.secondary
        }
    }
    
    enum TabBar{
        enum TintColor{
            static let selectedPrimary:UIColor =        Color.primary
            static let deselectedPrimary:UIColor =      Color.deselectedPrimary
        }
        enum Icon{

        }
    }
    
    enum View{
        enum BackgroundColor{
            static let primary:UIColor =                Color.primary
            static let secondary:UIColor =              Color.secondary
            static let contrastPrimary:UIColor =        Color.contrastPrimary
            static let contrastSecondary:UIColor =      Color.contrastSecondary
            static let alphaContrastSecondary:UIColor = Color.alphaContrastSecondary
        }
        enum BorderColor{
            static let primary:UIColor =                Color.primary
            static let secondary:UIColor =              Color.secondary
            static let contrastSecondary:UIColor =      Color.contrastSecondary
        }
    }
    
    enum Button{
        enum BackgroundColor{
            static let primary:UIColor =                Color.primary
            static let secondary:UIColor =              Color.secondary
            static let contrastSecondary:UIColor =      Color.contrastSecondary
            static let contrastPrimary:UIColor =        Color.contrastPrimary
        }
        enum StrokeColor{
            static let contrastPrimary:UIColor =        Color.contrastPrimary
            static let secondary:UIColor =              Color.secondary
        }
        enum TextColor{
            static let secondary:UIColor =              Color.secondary
            static let primary:UIColor =                Color.primary
        }
        enum TintColor{
            static let secondary:UIColor =              Color.secondary
        }
        enum BorderColor{
            static let primary:UIColor =                Color.primary
        }
    }
    
    enum TextField{
        enum TintColor{
            static let primary:UIColor =                Color.alphaPrimary
        }
        enum Placeholder{
            static let primary:UIColor =                Color.alphaPrimary
        }
        enum TextColor{
            static let primary:UIColor =                Color.primary
        }
    }
    
    enum TextValidation{
        enum Password{
            static let minChars:Int =                   6
        }
    }
}

