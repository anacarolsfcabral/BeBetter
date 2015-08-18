//
//  AppDelegate.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //////Notificação////////
        var firstAction: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "FIRST_ACTION"
        firstAction.title = "Adiar"
        firstAction.activationMode = UIUserNotificationActivationMode.Background
        firstAction.destructive = true
        firstAction.authenticationRequired = false
        
        var secondAction: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        secondAction.identifier = "SECOND_ACTION"
        secondAction.title = "Praticar"
        secondAction.activationMode = UIUserNotificationActivationMode.Foreground
        secondAction.destructive = false
        secondAction.authenticationRequired = false
        
        var thirdAction: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        thirdAction.identifier = "THIRD_ACTION"
        thirdAction.title = "Adiar por 1 hora"
        thirdAction.activationMode = UIUserNotificationActivationMode.Background
        thirdAction.destructive = false
        thirdAction.authenticationRequired = false
        
        // Category
        
        var firstCategory: UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "FIRST_CATEGORY"
        
        let defaultAction: NSArray = [firstAction, secondAction, thirdAction]
        let minimalAction: NSArray = [firstAction, secondAction]
        
        firstCategory.setActions(defaultAction as [AnyObject], forContext: UIUserNotificationActionContext.Default)
        firstCategory.setActions(minimalAction as [AnyObject], forContext: UIUserNotificationActionContext.Minimal)
        
        // NSSet of all our category
        
        let categories: NSSet = NSSet(objects: firstCategory)
        
        
        
        let types: UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge
        
        let mySettings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: categories as Set<NSObject>)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
        
        ///////////////////////////////////////////////////////////
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let isAppAlreadyLaunchedOnce = defaults.stringForKey("isAppAlreadyLaunchedOnce")
        {
            let category = CategoryViewController(nibName:"CategoryView", bundle:NSBundle.mainBundle())
            let first = StartViewController(nibName:"StartView", bundle:NSBundle.mainBundle())

            let nav = UINavigationController(nibName: "nav", bundle: nil)
            nav.viewControllers = [first,category]
            nav.navigationBar.hidden = true
            self.window?.rootViewController = nav
            
        }
        else
        {
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnce")
            let start = StartViewController(nibName:"StartView", bundle:NSBundle.mainBundle())
            let nav = UINavigationController(nibName: "nav", bundle: nil)
            nav.navigationBar.hidden = true
            nav.viewControllers = [start]
            self.window?.rootViewController = nav
        }
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        if(identifier == "FIRST_ACTION"){
            NSNotificationCenter.defaultCenter().postNotificationName("actionOnePressed", object: nil)
        }else if(identifier == "SECOND_ACTION"){
            NSNotificationCenter.defaultCenter().postNotificationName("actionTwoPressed", object: nil)
        }else if(identifier == "THIRD_ACTION"){
            NSNotificationCenter.defaultCenter().postNotificationName("actionThirdPressed", object: nil)
        }
        
        completionHandler()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

