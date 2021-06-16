//
//  AppDelegate.swift
//  XQUAREDemo
//
//  Created by 김수완 on 2021/06/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print("TK421: Continue type = \(userActivity.activityType)")
        
        guard userActivity.activityType == NSUserActivity.viewTodaysMealActivityType else {
            print("TK321: Can't continue unkown NSUserActivity type = \(userActivity.activityType)")
            return false
        }
        
        guard let window = window,
              let rootViewController = window.rootViewController as? UINavigationController else {
            print("TK421: Faild to access root view controller.")
            return false
        }
        
        restorationHandler(rootViewController.viewControllers)

        return true
    }

}

