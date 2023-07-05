//
//  ManageSellTicketComplimentary.swift
//  TicketGateway
//
//  Created by Apple  on 25/05/23.
//

import UIKit
import SideMenu

class ManageSellTicketComplimentary: UIViewController {
    
    @IBOutlet weak var vwMore: UIView!
    @IBOutlet weak var vwBuy: UIView!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblEventTicketTypes: ManageEventSellTicketTableViewList!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp(){
        self.vwMore.isHidden = true
        self.tblEventTicketTypes.isFromSellTab = false
        self.tblEventTicketTypes.configure()
        self.navigationView.imgBack.image = UIImage(named: "x")
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = "Sunburn reload NYE - toronto"
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.lblDiscripation.text = "Saturday, March 18 • 6:00 AM"
        self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.delegateBarAction = self
        [btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.btnContinue.setTitles(text: "Continue", font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
       
      }
}

extension ManageSellTicketComplimentary {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case  btnContinue:
            self.btnContinueAction()
        
        default:
            break
        }
    }
 
    func btnContinueAction(){
        DispatchQueue.main.async {
            self.showToast(message: "Complimentary applied successfully")
        }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigationController?.popViewController(animated: false)
        }
    }
    

}


extension ManageSellTicketComplimentary : NavigationBarViewDelegate ,UITextFieldDelegate{
    func navigationBackAction() {
        
        self.navigationController?.popViewController(animated: false)
    }
}
