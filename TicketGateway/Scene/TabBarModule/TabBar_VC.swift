//
// TabBar_VC.swift
// TicketGateway
//
// Created by Apple on 17/04/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name
import UIKit
class TabBar_VC: UITabBarController {
    //MARK: - Variables
    let yourImage = UIImage(named: "image")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UserDefaults.standard.set(false, forKey: "isComingFromManageEvent")
//        let selectedindex = tabBarController?.selectedIndex
//        print("----------", selectedindex)
        
    }
    override func viewDidLayoutSubviews() { // add to any vc
        super.viewDidLayoutSubviews()
        // self.TabBar_VC?.addSubviewToLastTabItem(yourImage!)
        //  self.tabBarController?.addSubviewToLastTabItem("Image")
        //  self.addSubviewToLastTabItem("Image")
    }
    
    
    
}
class TabBarManage_VC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "isComingFromManageEvent")
        // self.tabBarController?.viewControllers?[4].tabBarItem.title = NSLocalizedString("Tab 3", comment: "")
        // Do any additional setup after loading the view.
    }
}


// MARK: -
extension TabBar_VC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin) {
            let tabBarIndex = tabBarController.selectedIndex
            if tabBarIndex == 3 {
                objSceneDelegate.showLogin_Signup()
                print( "tab bar is selected")
            }
        }
    }
}
