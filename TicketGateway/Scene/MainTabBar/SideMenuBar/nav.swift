//
//  nav.swift
//  TicketGateway
//
//  Created by Apple  on 03/05/23.
//

//import UIKit
//import ENSwiftSideMenu
//
//class MyNavigationController: ENSideMenuNavigationController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Create a table view controller
//        let tableViewController = SideMenuViewControllers()
//        
//        // Create side menu
//        sideMenu = ENSideMenu(sourceView: view, menuViewController: tableViewController, menuPosition:.left)
//        
//        // Set a delegate
//        sideMenu?.delegate = self
//        
//        // Configure side menu
//        sideMenu?.menuWidth = 280
//        
//        // Show navigation bar above side menu
//        view.bringSubviewToFront(navigationBar)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}
//
//extension MyNavigationController: ENSideMenuDelegate {
//    func sideMenuWillOpen() {
//        print("sideMenuWillOpen")
//    }
//    
//    func sideMenuWillClose() {
//        print("sideMenuWillClose")
//    }
//    
//    func sideMenuDidClose() {
//        print("sideMenuDidClose")
//    }
//    
//    func sideMenuDidOpen() {
//        print("sideMenuDidOpen")
//    }
//    
//    func sideMenuShouldOpenSideMenu() -> Bool {
//        return true
//    }
//}
