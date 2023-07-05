//
//  NotificationVC.swift
//  TicketGateway
//
//  Created by Apple  on 02/06/23.
//

import UIKit
import SideMenu

class NotificationVC: UIViewController {
 
// MARK: - Outlet
    @IBOutlet weak var tblNotification: NotificationTableViewList!
    @IBOutlet weak var navigationView: NavigationBarView!
  
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
     }
    
}
// MARK: - Functions
extension NotificationVC {
    private func setup() {
         self.tblNotification.configure()
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = "Notifications"
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.imgBack.image = UIImage(named: "Menu")
        self.navigationView.vwBorder.isHidden = false
       
    }
   
}
// MARK: - Back
extension NotificationVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
  }
}
