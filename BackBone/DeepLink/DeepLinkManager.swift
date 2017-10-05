//
//  DeepLinkManager.swift
//  BackBone
//
//  Created by Andrea Bellotto on 02/10/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation
import UIKit

class DeepLinkManager{

    class var instance:DeepLinkManager {
        struct Static {
            static let instance:DeepLinkManager = DeepLinkManager()
        }
        return Static.instance
    }
    
    var deepLink:DeeplinkType?
    var tabIndex:Int?
    var quizId:String?
    var sessionId:String?
    var segmentedControlScrollViewTabIndex:Int?
    
    func startDeepLinking(with deepLink:DeeplinkType){
        if let delegate = UIApplication.shared.delegate as? AppDelegate{
            if let window = delegate.window {
                window.rootViewController = UIStoryboard.get(.main).instantiateViewController(withIdentifier: "mainTabViewController") as? UITabBarController
                window.makeKeyAndVisible()
                self.deepLink = deepLink
                self.tabIndex = deepLink.tabNumber
                self.quizId = deepLink.quizId
                self.segmentedControlScrollViewTabIndex = deepLink.segmentedControlScrollTab
            }
        }
    }
    
    static func generateDeepLink(from url:URL)->DeeplinkType?{
        
        var copyComponents =  url.path.components(separatedBy: "/")
        copyComponents.removeFirst()
        while copyComponents.count > 0 {
            if let component = copyComponents.first {
                switch component {
                case "planning":
                    // /planning
                    copyComponents.removeFirst()
                    if let planningNextComponent = copyComponents.first {
                        switch planningNextComponent {
                        case "session":
                            // /session
                            var sessionId:String?
                            copyComponents.removeFirst()
                            guard let sessionNextComponent = copyComponents.first else{
                                return DeeplinkType.planning(planning: .session(.root))
                            }
                            switch sessionNextComponent{
                            case "sessiondetail":
                                // /sessiondetail
                                copyComponents.removeFirst()
                                guard let sessionDetailNextComponent = copyComponents.first else{
                                    return DeeplinkType.planning(planning: .session(.root))
                                }
                                sessionId = sessionDetailNextComponent
                                copyComponents.removeFirst()
                                // /12
                                return DeeplinkType.planning(planning: .session(.detail(id: sessionId!)))
                                
                            default:
                                return DeeplinkType.planning(planning: .session(.root))
                            }
                        default:
                            break
                        }
                    }
                    else{
                        return DeeplinkType.planning(planning: .session(.root))
                    }
                case "myplanning":
                    // /myplanning
                    copyComponents.removeFirst()
                    if let planningNextComponent = copyComponents.first {
                        switch planningNextComponent {
                        case "session":
                            // /session
                            var sessionId:String?
                            copyComponents.removeFirst()
                            guard let sessionNextComponent = copyComponents.first else{
                                return DeeplinkType.myPlanning(planning: .session(.root))
                            }
                            switch sessionNextComponent{
                            case "sessiondetail":
                                // /sessiondetail
                                copyComponents.removeFirst()
                                guard let sessionDetailNextComponent = copyComponents.first else{
                                    return DeeplinkType.myPlanning(planning: .session(.root))
                                }
                                sessionId = sessionDetailNextComponent
                                copyComponents.removeFirst()
                                // /12
                                return DeeplinkType.myPlanning(planning: .session(.detail(id: sessionId!)))
                                
                            default:
                                return DeeplinkType.myPlanning(planning: .session(.root))
                            }
                        default:
                            break
                        }
                    }
                    else{
                        return DeeplinkType.myPlanning(planning: .session(.root))
                    }
                    
                    
                case "gaming":
                    // /gaming
                    copyComponents.removeFirst()
                    if let gamingNextComponent = copyComponents.first {
                        switch gamingNextComponent {
                        case "games":
                            // /games
                            var quizId:String?
                            copyComponents.removeFirst()
                            guard let gamesNextComponent = copyComponents.first else{
                                return DeeplinkType.gaming(gaming: .quiz(.root))
                            }
                            switch gamesNextComponent{
                            case "quizdetail":
                                // /session_detail
                                copyComponents.removeFirst()
                                guard let quizDetailNextComponent = copyComponents.first else{
                                    return DeeplinkType.gaming(gaming: .quiz(.root))
                                }
                                quizId = quizDetailNextComponent
                                copyComponents.removeFirst()
                                // /12
                                return DeeplinkType.gaming(gaming: .quiz(.detail(id: quizId!)))
                                
                            default:
                                return DeeplinkType.gaming(gaming: .quiz(.root))
                            }
                        case "badges":
                            // /badges
                            copyComponents.removeFirst()
                            return DeeplinkType.gaming(gaming: .badges(.root))
                            
                        case "livescore":
                            // /livescores
                            copyComponents.removeFirst()
                            return DeeplinkType.gaming(gaming: .liveScore(liveScore: .root))
                        default:
                            break
                            
                        }
                    }
                    else {
                        return DeeplinkType.gaming(gaming: .quiz(.root))
                    }
                case "materials":
                    // /materials
                    copyComponents.removeFirst()
                    return DeeplinkType.material(material: .root)
                case "info":
                    // /info
                    copyComponents.removeFirst()
                    return DeeplinkType.info(info: .root)
                    
                default:
                    break
                }
            }
            else{
                break
            }
            copyComponents.removeFirst()
        }
        
        return nil
    }


    


}
