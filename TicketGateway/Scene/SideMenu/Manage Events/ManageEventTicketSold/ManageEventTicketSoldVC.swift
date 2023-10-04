//
//  ManageEventTicketSoldVC.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
//

import UIKit

class ManageEventTicketSoldVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tblTickets: TicketOverAllEstimateBarTableViewList!
    @IBOutlet weak var lblTotalTicketsSold: UILabel!
    @IBOutlet weak var lblAddmissionSold: UILabel!
    @IBOutlet weak var lblAddmissionSoldTotalAvaiable: UILabel!
    @IBOutlet weak var navigationView: NavigationBarView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setUi()
        self.tblTickets.configure()
    }
}

// MARK: - Functions
extension ManageEventTicketSoldVC {
    func setup() {
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = TICKET_SOLD
        self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
    }
    func setUi() {
        [self.lblAddmissionSold].forEach {
            $0?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
            $0?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        
        [self.lblAddmissionSoldTotalAvaiable,self.lblTotalTicketsSold].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
            $0?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
    }
    
}

// MARK: - NavigationBarViewDelegate,UITextFieldDelegate
extension ManageEventTicketSoldVC: NavigationBarViewDelegate ,UITextFieldDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
  }
}
