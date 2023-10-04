//
//  MyRefundVC.swift
//  TicketGateway
//
//  Created by Apple  on 09/05/23.

import UIKit
import SideMenu

class MyRefundVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tblTransaction: RefundListTableView!
    @IBOutlet weak var navigationView: NavigationBarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
     }

}
// MARK: - Functions
extension MyRefundVC {
    private func setup() {
        self.tblTransaction.configure()
        self.navigationView.delegateBarAction = self
        self.tblTransaction.isFrom = "MyRefund"
        self.navigationView.imgBack.image = UIImage(named: MENU_ICON)
          self.navigationView.lblTitle.text = MY_REFUNDS
          self.navigationView.btnBack.isHidden = false
          self.navigationView.delegateBarAction = self
        self.navigationView.vwBorder.isHidden = false
    }

}
// MARK: - NavigationBarViewDelegate
extension MyRefundVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
  }
}
