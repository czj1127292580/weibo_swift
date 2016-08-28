//
//  AppDelegate.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/15.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = WelcomeViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func isNeesUpdate() -> Bool{
    
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        
        let sandboxVersion = NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String ?? ""
        
        if currentVersion.compare(sandboxVersion) == NSComparisonResult.OrderedDescending {
            
            // iOS7以后不用调用同步方法
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: "CFBundleShortVersionString")
            NSUserDefaults.standardUserDefaults().synchronize()
            return true
        }
        
        return false
    }

}

