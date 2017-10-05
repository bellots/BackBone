//
//  ErrorManager.swift
//  BackBone
//
//  Created by Andrea Bellotto on 05/10/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation


enum ErrorModel:Error{
    case genericError(message:String)
    case errorFromNSError(_ :NSError)

    var message:String?{
        switch self {
        case .genericError(let message):
            return message            
        case .errorFromNSError(let nsError):
            return nsError.userInfo["message"] as? String
        }
    }
}

