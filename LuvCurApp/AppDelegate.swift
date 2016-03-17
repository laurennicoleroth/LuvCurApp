//
//  AppDelegate.swift
//  LuvCurApp
//
//  Created by Lauren Nicole Roth on 3/3/16.
//  Copyright © 2016 LuvCurApp. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let containerViewController = ContainerViewController()
        
        window!.rootViewController = containerViewController
        window!.makeKeyAndVisible()
        
        return FBSDKApplicationDelegate.sharedInstance()
            .application(application, didFinishLaunchingWithOptions: launchOptions)
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func application(application: UIApplication, openURL url: NSURL,
        sourceApplication: String?, annotation: AnyObject) -> Bool {
            
            return FBSDKApplicationDelegate.sharedInstance()
                .application(application, openURL: url,
                    sourceApplication: sourceApplication, annotation: annotation)
    }


}

