//
//  DeepLynkType.swift
//  BackBone
//
//  Created by Andrea Bellotto on 30/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

enum DeeplinkType {
    case planning(planning:Planning)
    case myPlanning(planning:Planning)
    case gaming(gaming:Gaming)
    case material(material:Material)
    case info(info:Info)
    case link(linkModel:LinkModel)
    
    enum Planning{
        case session(Session)
        enum Session{
            case root
            case detail(id:String)
        }
    }
    
    enum Material{
        case root
    }

    enum Info{
        case root
    }
    enum Gaming{
        case quiz(Quiz)
        case badges(Badges)
        case liveScore(liveScore:LiveScore)
        
        enum Quiz{
            case root
            case detail(id:String)
        }
        enum Badges{
            case root
        }
        enum LiveScore{
            case root
        }
        
    }
    
    
    var tabNumber:Int?{
        switch self{
        case .planning:
            return 0
        case .myPlanning:
            return 1
        case .gaming:
            return 2
        case .material:
            return 3
        case .info:
            return 4
        case .link:
            return nil
        }
    }
    
    var segmentedControlScrollTab:Int?{
        switch self{
        case .planning:
            return nil
        case .myPlanning:
            return nil
        case .gaming(let gaming):
            switch gaming{
            case .quiz:
                return 0
            case .badges:
                return 1
            case .liveScore:
                return 2
            }
        case .material:
            return nil
        case .info:
            return nil
        case .link:
            return nil
        }
    }
    
    var quizId:String?{
        switch self{
        case .gaming(let gaming):
            switch gaming{
            case .quiz(let quiz):
                switch quiz{
                case .detail(let id):
                    return id
                default:
                    return nil
                }
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
    var sessionId:String?{
        switch self{
        case .planning(let planning):
            switch planning{
            case .session(let session):
                switch session{
                case .detail(let id):
                    return id
                default:
                    return nil
                }
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
    
    
}







