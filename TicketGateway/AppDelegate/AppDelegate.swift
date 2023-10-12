//
//  AppDelegate.swift
//  TicketGateway
//
//  Created by Apple  on 10/04/23.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD
import GoogleSignIn
import FacebookCore
import Firebase
import Stripe



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    /// swRevealContainer
    
    
    /// main navigaion controller
    var navigationController : UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 8.0)
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        STPAPIClient.shared.publishableKey = STRIPE_PUBLISH_KEY
        window = UIWindow(frame: UIScreen.main.bounds)
       
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        SVProgressHUD.setForegroundColor(UIColor.init(named: "StartGradient")!)
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setRingThickness(6.0)
        SVProgressHUD.setDefaultMaskType(.clear)
        FacebookCore.ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //    func application(_ app: UIApplication,open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    //    ) -> Bool {
    //      var handled: Bool
    //
    //      handled = GIDSignIn.sharedInstance.handle(url)
    //      if handled {
    //        return true
    //      }
    //
    //      // Handle other custom URL types.
    //
    //      // If not handled by this app, return false.
    //      return false
    //    }
    //
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    
    
}
