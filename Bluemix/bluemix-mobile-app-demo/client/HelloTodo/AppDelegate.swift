//
//  AppDelegate.swift
//  HelloTodo
//
//  Created by Naoki Tsutsui on 4/23/16.
//  Copyright © 2016 Naoki Tsutsui. All rights reserved.
//

import UIKit
import BMSCore
import BMSSecurity

let logger = Logger.logger(forName: "HelloTodoLogger")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    // PATH TO YOUR PROTECTED RESOURCE
    internal static let customResourceURL = "/protected)"
//    private static let customRealm = "PROTECTED_RESOURCE_REALM_NAOKITS" // auth realm
//    private static let customRealm = "bmxdemo-custom-realm"
    private static let customRealm = "mca-backend-strategy"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        
        setupBluemix()
        
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    // MARK: - Setups
    
    func setupBluemix() {
//        let appRoute = "https://bluemix-mobile-app-demo.mybluemix.net"
//        let appGuid = "3ff171d1-c941-43d6-801e-84a549550a88"
        let route = "https://BMXDemo.mybluemix.net"
        let guid = "1de16665-6dc3-43db-aa3a-d9aa37014ed5"
        let region = BMSClient.REGION_US_SOUTH
        BMSClient.sharedInstance.initializeWithBluemixAppRoute(route, bluemixAppGUID: guid, bluemixRegion: region)
        
        self.hoge()
        return

//        BMSClient.sharedInstance.authorizationManager = MCAAuthorizationManager.sharedInstance
        

        let delegate = MyAuthDelegate()
        let mcaAuthManager = MCAAuthorizationManager.sharedInstance
        mcaAuthManager.registerAuthenticationDelegate(delegate, realm: AppDelegate.customRealm)
        BMSClient.sharedInstance.authorizationManager = mcaAuthManager
        

        //        mcaAuthManager.registerAuthenticationDelegate(delegate, realm: AppDelegate.customRealm)

//        do {
//            try mcaAuthManager.registerAuthenticationDelegate(delegate, realm: AppDelegate.customRealm)
//        } catch {
//            print("error with register: \(error)")
//        }

    }
    
    func hoge() {
        let request = Request(url: AppDelegate.customResourceURL, method: HttpMethod.GET)

        logger.debug("リクエスト： \(request.description)")
//        request.headers = ["Accept":"application/json"];
        request.sendWithCompletionHandler { (response, error) in
            var ans:String = ""
            guard (error == nil) else {
                ans = "ERROR , error=\(error)"
                logger.error("Error :: \(error)")
                return
            }
            logger.debug("response:\(response?.responseText), no error")
        }
    }

}

//Auth delegate for handling custom challenge
class MyAuthDelegate : AuthenticationDelegate {
    
    func onAuthenticationChallengeReceived(authContext: AuthenticationContext, challenge: AnyObject) {
        print("onAuthenticationChallengeReceived")
        // Your challenge answer. Should be of type [String:AnyObject]?
        let challengeAnswer: [String:String] = [
            "username":"naokits",
            "password":"12345"
        ]
        authContext.submitAuthenticationChallengeAnswer(challengeAnswer)
    }
    
    func onAuthenticationSuccess(info: AnyObject?) {
        print("onAuthenticationSuccess")
    }
    
    func onAuthenticationFailure(info: AnyObject?){
        print("onAuthenticationFailure")
    }
}

