//
//  SceneDelegate.swift
//  TicketGateway
//
//  Created by Apple  on 10/04/23.
//

import UIKit



let objSceneDelegate = SceneDelegate.sceneDelegateObject()

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
        
        /// swRevealContainer
      

    
    //MARK: - Shared object
    private static var sceneDelegateManager: SceneDelegate = {
        let manager = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        return manager!
    }()
    
    // MARK: - Accessors
    class func sceneDelegateObject() -> SceneDelegate {
        return sceneDelegateManager
    }
   

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        self.window?.overrideUserInterfaceStyle = .light
        self.IsUserAlreadyLogin()
       
        
     }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
   
    func showTabBar(){
        let storyboard:UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "tabBarNav") as? UINavigationController
        let rootViewController:UIViewController = storyboard.instantiateViewController(withIdentifier: "TabBar_VC") as! TabBar_VC
        navigationController!.viewControllers = [rootViewController]
        self.window?.rootViewController = navigationController
              self.window?.makeKeyAndVisible()
       }
    
    func showMangeEventTabBar(){
        let storyboard:UIStoryboard = UIStoryboard(name: "ManageEvents", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "TabBarNavMange") as? UINavigationController
        let rootViewController:UIViewController = storyboard.instantiateViewController(withIdentifier: "TabBarManage_VC") as! TabBarManage_VC
        navigationController!.viewControllers = [rootViewController]
        self.window?.rootViewController = navigationController
              self.window?.makeKeyAndVisible()
       }
    
    
    func showLogin_Signup(){
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        
       let  navController = sb.instantiateViewController(withIdentifier: "WelcomeLoginSignupNav") as? UINavigationController
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    func showIntroScreen(){
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
       let  navController = sb.instantiateViewController(withIdentifier: "WelcomeIntroNav") as? UINavigationController
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    func IsUserAlreadyLogin(){
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        let userModelSignUp = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserAccountModel.self, key: .userAuthData)
        print("Get data",userModel?.email)
        print("Get data",userModelSignUp?.email)
        if userModel?.email != nil || userModelSignUp?.email != nil{
            showTabBar()
        } else {
            showIntroScreen()
        }
    }
    
    
        
    }



