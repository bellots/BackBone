//
//  LocalNotificationManager.swift
//  BackBone
//
//  Created by Andrea Bellotto on 05/10/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation

enum LocalNotificationManager:String {
    
    case test = "test"
    
    func getNotification()->Notification.Name{
        return Notification.Name(rawValue: self.rawValue)
    }
    func post(object:Any?){
        NotificationCenter.default.post(name: getNotification(), object: object)
    }
    
    func addObserver(observer:Any, selector:Selector, object:Any?){
        NotificationCenter.default.addObserver(observer, selector: selector, name:getNotification(), object: object)
    }
    
    func removeObserver(observer:Any, object:Any?){
        NotificationCenter.default.removeObserver(observer, name: getNotification(), object: object)
    }
}
