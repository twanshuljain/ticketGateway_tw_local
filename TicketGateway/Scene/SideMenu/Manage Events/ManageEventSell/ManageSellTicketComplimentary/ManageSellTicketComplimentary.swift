//
//  ManageSellTicketComplimentary.swift
//  TicketGateway
//
//  Created by Apple  on 25/05/23.
//

import UIKit
import SideMenu

class ManageSellTicketComplimentary: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var vwMore: UIView!
    @IBOutlet weak var vwBuy: UIView!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblEventTicketTypes: ManageEventSellTicketTableViewList!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
}
// MARK: - Functions
extension ManageSellTicketComplimentary {
    func setUp() {
        self.vwMore.isHidden = true
        self.tblEventTicketTypes.isFromSellTab = false
        self.tblEventTicketTypes.configure()
        self.navigationView.imgBack.image = UIImage(named: X_ICON)
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = HEADER_TITLE_SUNBURN
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
        self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.delegateBarAction = self
        [btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
      }
}
// MARK: - Actions
extension ManageSellTicketComplimentary {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case  btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
    func btnContinueAction() {
        DispatchQueue.main.async {
            self.showToast(message: COMPLIMENTRY_APPLIED_SUCCESSFULLY)
        }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}

// MARK: - NavigationBarViewDelegate
extension ManageSellTicketComplimentary: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
}
