//
// TabBar_VC.swift
// TicketGateway
//
// Created by Apple on 17/04/23.
//
import UIKit
class TabBar_VC: UITabBarController {
    //MARK: - Variables
    let yourImage = UIImage(named: "image")
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "isComingFromManageEvent")
        // self.tabBarController?.addSubviewToLastTabItem("Irofile")
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
