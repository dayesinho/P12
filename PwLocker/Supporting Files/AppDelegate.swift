//
//  AppDelegate.swift
//  PwLocker
//
//  Created by Tavares on 25/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import UIKit

extension UIApplication {
    typealias LaunchOptionsKey = UIApplication.LaunchOptionsKey
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let loginPageOption = UserDefaults.standard.object(forKey: "LoginPage") as? String ?? "StoryA"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: loginPageOption)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        let date = NSDate()
        let resignTime = Int64(date.timeIntervalSince1970)
        UserDefaults.standard.set(resignTime, forKey: "logOutTime")
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = window!.frame
        blurEffectView.tag = 221122

        self.window?.addSubview(blurEffectView)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        self.window?.viewWithTag(221122)?.removeFromSuperview()
        
            if let resignTime = UserDefaults.standard.object(forKey: "logOutTime") as? Int64 {
                let date = NSDate()
                let currentTime = Int64(date.timeIntervalSince1970)
                debugPrint("diff: ", currentTime-resignTime)
                let diff = currentTime-resignTime
                if diff >= UserDefaults.standard.object(forKey: "AutoLock") as? Int64 ?? 60 {
                    
                    let loginPageOption = UserDefaults.standard.object(forKey: "LoginPage") as? String ?? "StoryA"
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: loginPageOption)
                    self.window?.rootViewController = initialViewController
                    self.window?.makeKeyAndVisible()
            }
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

