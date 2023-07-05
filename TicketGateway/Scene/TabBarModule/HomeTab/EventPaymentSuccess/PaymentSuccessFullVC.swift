//
//  PaymentSuccessFullVC.swift
//  TicketGateway
//
//  Created by Apple  on 16/05/23.
//

import UIKit

class PaymentSuccessFullVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblThankYou: UILabel!
    @IBOutlet weak var lbl1Ticket: UILabel!
    @IBOutlet weak var lblCADPrice: UILabel!
    @IBOutlet weak var lblTicketForOrder: UILabel!
    @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblNoRefundAnytime: UILabel!
    @IBOutlet weak var btnViewMyTicket: CustomButtonNormalWithBorder!
    @IBOutlet weak var btnBrowseMorwEvents: CustomButtonGradiant!
    @IBOutlet weak var btnGoTopMyAccount: CustomButtonNormalWithBorder!
    @IBOutlet weak var lblRefundDescription: UILabel!
    @IBOutlet weak var btnNeedHelp: CustomButtonNormal!
    @IBOutlet weak var navigationView: NavigationBarView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.setUi()
    }
}

//MARK: - Functions
extension PaymentSuccessFullVC {
    func setUp(){
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = "Payment Successful"
        self.navigationView.vwBorder.isHidden = false
        btnBrowseMorwEvents.setTitles(text: "Browse more events", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        [self.btnBrowseMorwEvents,self.btnViewMyTicket,btnBrowseMorwEvents,btnGoTopMyAccount].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        btnViewMyTicket.setTitles(text: "View my Ticket", textColour: UIColor.setColor(colorType: .TGBlue), borderColour: UIColor.setColor(colorType: .PlaceHolder))
        btnGoTopMyAccount.setTitles(text: "Go to my account", textColour: UIColor.setColor(colorType: .TGBlack), borderColour: UIColor.setColor(colorType: .PlaceHolder))
        btnNeedHelp.setTitles(text: "Need Help? Contact Us", font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: .clear, textColour: UIColor.setColor(colorType: .TGBlue))
        btnNeedHelp.addRightIcon(image: UIImage(named: "ri8Blue"))
        
    }
    func setUi() {
        lblThankYou.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFour)
        lblThankYou.textColor = UIColor.setColor(colorType: .TGBlue)
        
        lbl1Ticket.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        lbl1Ticket.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblCADPrice.font = UIFont.setFont(fontType: .semiBold, fontSize: .fifteen)
        lblCADPrice.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblTicketForOrder.font = UIFont.setFont(fontType: .semiBold, fontSize: .fifteen)
        lblTicketForOrder.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblRefundPolicy.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        lblRefundPolicy.textColor = UIColor.setColor(colorType: .TGBlack)
        lblNoRefundAnytime.font = UIFont.setFont(fontType: .semiBold, fontSize: .fifteen)
        lblNoRefundAnytime.textColor = UIColor.setColor(colorType: .TGBlack)
        
        lbl1Ticket.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        lbl1Ticket.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblRefundDescription.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
        lblRefundDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
        
    }
}

//MARK: - Actions
extension PaymentSuccessFullVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnGoTopMyAccount:
            self.btnGoTopMyAccountAction()
        case btnBrowseMorwEvents:
            self.btnBrowseMorwEventsAction()
        case btnNeedHelp:
            self.btnNeedHelpAction()
        case btnViewMyTicket:
            self.btnViewMyTicketAction()
       
        default:
            break
        }
    }
    func btnGoTopMyAccountAction() {}
    func btnBrowseMorwEventsAction() {}
    
    func btnNeedHelpAction() {}
    
   func btnViewMyTicketAction() {
      
    }
   
}

//MARK: - NavigationBarViewDelegate
extension PaymentSuccessFullVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        
    self.navigationController?.popViewController(animated: true)
  }
}
