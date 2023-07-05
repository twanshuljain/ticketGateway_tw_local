//
//  ManageEventTicketSoldVC.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
//

import UIKit

class ManageEventTicketSoldVC: UIViewController {

    @IBOutlet weak var tblTickets: TicketOverAllEstimateBarTableViewList!
   
    @IBOutlet weak var lblTotalTicketsSold: UILabel!
    @IBOutlet weak var lblAddmissionSold: UILabel!
    @IBOutlet weak var lblAddmissionSoldTotalAvaiable: UILabel!
    @IBOutlet weak var navigationView: NavigationBarView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setup(){
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = "Sunburn reload NYE - toronto"
     
        self.navigationView.btnBack.isHidden = false
        
        
      
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.lblDiscripation.isHidden = false
    }
    func setUi(){
    
         [self.lblAddmissionSold].forEach {
            $0?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
            $0?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        }
        
        [self.lblAddmissionSoldTotalAvaiable,self.lblTotalTicketsSold].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
            $0?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        }
       
    }

}
extension ManageEventTicketSoldVC : NavigationBarViewDelegate ,UITextFieldDelegate{
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
  }
}
