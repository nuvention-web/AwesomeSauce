//
//  AppDelegate.swift
//  allcabs
//
//  Created by Farley Center on 2/23/15.
//  Copyright (c) 2015 awesomesauce. All rights reserved.
//

//import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    static var firstViewController : FirstViewController!
    var window: UIWindow?
    static var id : String!
    static var actionToTake : Selector!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyChePAVRnDw0dMcFKkiS-DCN5lMedWoL0s")
        //FBLoginView.self
        //FBProfilePictureView.self
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        /*var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        return wasHandled
        */
        println("Handling URL")
        var action : String?
        var urlstring = url.absoluteString!
        var parameters = split(urlstring){$0 == "?"}[1]
        var parameterList = split(parameters){$0 == "&"}
        for parameter : String in parameterList{
            if parameter.hasPrefix("action"){
                let value = split(parameter) {$0 == "="}[1]
                if value == "track"{
                    action = "trackNewID:"
                }
            } else if parameter.hasPrefix("id"){
                let value = split(parameter) {$0 == "="}[1]
                AppDelegate.id = value
            }
        }
        if let action = action{
            if action == "trackNewID:"{
                AppDelegate.actionToTake = Selector(action)
            }
        }
        if let firstViewController = AppDelegate.firstViewController{
            AppDelegate.actionToTake = nil
            UIApplication.sharedApplication().sendAction(Selector(action!), to: AppDelegate.firstViewController!, from: nil, forEvent: nil)
        } 

        
        return true
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
        if let FVC = AppDelegate.firstViewController{
            UpdateMapHelper.renderAllPaths(FVC)
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

