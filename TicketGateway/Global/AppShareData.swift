//
//  AppShareData.swift
//  TicketGateway
//
//  Created by Apple  on 20/04/23.
//

import UIKit
import Foundation

let objAppShareData = AppShareData.sharedObject()
class AppShareData {
    // MARK: All Properties
    private var numOfPageKey: String = "NumberOfPage"
    //MARK: - Shared object
    private static var sharedManager: AppShareData = {
        let manager = AppShareData()
        //        var strUSERID : String = ""
        return manager
    }()
    // MARK: - Accessors
    class func sharedObject() -> AppShareData {
        return sharedManager
    }
    // NewVariable
    var dicToHoldDataOnSignUpModule : DataHoldOnSignUpProcessModel?
    var userAuth = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
    
    func saveNumOfPage(numOfPage: Int) {
        UserDefaults.standard.set(numOfPage, forKey: numOfPageKey)
    }
    
    func setRootToHomeVCAndMoveToFAQ(){
        guard let objHomeViewController = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {
            return
        }
       let navigationController = UINavigationController(rootViewController: objHomeViewController)
       navigationController.isNavigationBarHidden = true
       //selectedTabBarIndex = selectedIndex
       UIApplication.shared.windows.first?.rootViewController = navigationController
       UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        guard let objFAQController = UIStoryboard.init(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "FAQVC") as? FAQVC else {
            return
        }
        navigationController.pushViewController(objFAQController, animated: false)
    }
}
