//
//  AppDelegate.swift
//  BackBone
//
//  Created by Andrea Bellotto on 06/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import UIKit
import UsefulExtensions
import Apollo

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var topMainViewController:MainViewController?
    var window: UIWindow?

    let client = ApolloClient(networkTransport: AuthHTTPNetworkTransport(url: URL(string: "myUrl")!))

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UserDefaults.standard.setValue(false, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")

        func resetWindow(){
            guard let window = window else {
                return
            }
            window.rootViewController = UIStoryboard.get(.main).instantiateViewController(withIdentifier: "mainTabViewController") as? UITabBarController
            window.makeKeyAndVisible()
            
        }
        setStyle()


        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        NotificationManager.instance.deviceToken = deviceTokenString
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setStyle(){
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().barTintColor = Constants.NavigationBar.BackgroundColor.primary
        UINavigationBar.appearance().tintColor = Constants.NavigationBar.TintColor.contrastPrimary
        UINavigationBar.appearance().isTranslucent = false
        
        
        UITabBar.appearance().tintColor = Constants.TabBar.TintColor.selectedPrimary
        UITabBar.appearance().unselectedItemTintColor = Constants.TabBar.TintColor.deselectedPrimary
        
        UITabBar.appearance()
        
        Theme.standard.setStyle()
    }



}

