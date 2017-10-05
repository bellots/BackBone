//
//  NotificationManager.swift
//  BackBone
//
//  Created by Andrea Bellotto on 05/10/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager{
    
    var alreadyLoadedToken:String?
    
    var deviceToken:String?{
        didSet{
            if deviceToken != alreadyLoadedToken {
                // make a call to send device token
                
                // On completion do:
                self.alreadyLoadedToken = self.deviceToken

            }
        }
    }
    
    class var instance:NotificationManager {
        struct Static {
            static let instance:NotificationManager = NotificationManager()
            
        }
        return Static.instance
    }
    
    func askForNotificationsPermissions(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
            // Enable or disable features based on authorization.
            if granted == true
            {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            else
            {
                print("not allowed")
            }
        }
    }
    
}
