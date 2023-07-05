//
//  RefundOptionsVC.swift
//  TicketGateway
//
//  Created by Apple on 07/06/23.
//

import UIKit
import iOSDropDown

class RefundOptionsVC: UIViewController {
    
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblRefundToOriginal: UILabel!
    @IBOutlet weak var swPaymentMethodSwitch: UISwitch!
    
    @IBOutlet weak var lblTGWallet: UILabel!
    @IBOutlet weak var lblGetAFullRefund: UILabel!
    @IBOutlet weak var swTGWalletSwitch: UISwitch!
    
    @IBOutlet weak var lblReasonForRefund: UILabel!
    @IBOutlet weak var txtReasonForRefund: DropDown!
    @IBOutlet weak var btnReasonForRefundDropDown: UIButton!
    
    @IBOutlet weak var lblFullRefund: UILabel!
    @IBOutlet weak var lblBarcodeWillNoLongerValid: UILabel!
    @IBOutlet weak var swFullRefundSwitch: UISwitch!
    
    
    @IBOutlet weak var partialrefundStackView: UIStackView!
    @IBOutlet weak var lblPartialRefund: UILabel!
    @IBOutlet weak var lblBarcodeWillRemainValid: UILabel!
    @IBOutlet weak var swPartialRefundSwitch: UISwitch!
    
    @IBOutlet weak var lblSelectTicket: UILabel!
    @IBOutlet weak var txtSelectTicket: DropDown!
    @IBOutlet weak var btnSelectTicketDropDown: UIButton!
    
    @IBOutlet weak var btnNext: CustomButtonGradiant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setFont()
        self.setUI()
        self.dropdown()
        
    }
    
    func setNavigationView(){
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = "Review Options"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
    }
    
    
    
    func dropdown() {
        txtReasonForRefund.optionArray = ["jndnc", "jndnc", "jndnc", "jndnc"]
        
        txtReasonForRefund.optionIds = [1,23,54,22]
        txtReasonForRefund.didSelect{(selectedText , index ,id) in
            self.txtReasonForRefund.text = "\(selectedText)"}
        
        txtSelectTicket.optionArray = ["xyz", "xyz", "xyz", "xyz"]
        
        txtSelectTicket.optionIds = [1,23,54,22]
        txtSelectTicket.didSelect{(selectedText , index ,id) in
            self.txtSelectTicket.text = "\(selectedText)"}
        
    }
    
    func setFont() {
        let boldlbls = [lblPaymentMethod, lblTGWallet, lblFullRefund, lblPartialRefund]
        for boldlbl in boldlbls {
            boldlbl?.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
            boldlbl?.textColor = UIColor.setColor(colorType: .TGBlack)
        }
        
        self.lblReasonForRefund.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblReasonForRefund.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        let regularLbls = [lblRefundToOriginal, lblGetAFullRefund, lblBarcodeWillNoLongerValid, lblBarcodeWillRemainValid]
        for regularLbl in regularLbls {
            regularLbl?.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
            regularLbl?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        }
        
        self.lblSelectTicket.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblSelectTicket.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.swPaymentMethodSwitch.onTintColor = UIColor.setColor(colorType: .TGBlue)
        self.swTGWalletSwitch.onTintColor = UIColor.setColor(colorType: .TGBlue)
        self.swFullRefundSwitch.onTintColor = UIColor.setColor(colorType: .TGBlue)
        self.swPartialRefundSwitch.onTintColor = UIColor.setColor(colorType: .TGBlue)
        self.lblSelectTicket.attributedText = getAttributedTextAction(attributedText: "*", firstString: "Select Tickets ", lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
        self.txtReasonForRefund.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.txtReasonForRefund.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.txtSelectTicket.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.txtSelectTicket.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        
    }
    
}

//MARK: - Instance Method
extension RefundOptionsVC {
    func setUI () {
        [btnReasonForRefundDropDown,btnSelectTicketDropDown,swPartialRefundSwitch].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnReasonForRefundDropDown:
            self.reasonForRefundDropDown()
        case btnSelectTicketDropDown:
            self.selectTicketDropDown()
        case swPartialRefundSwitch:
            self.partialRefundAction()
        default:
            break
        }
    }
    
    func reasonForRefundDropDown() {
        txtReasonForRefund.showList()
    }
    
    func selectTicketDropDown() {
        txtSelectTicket.showList()
        
    }
    
    func partialRefundAction(){
        if swPartialRefundSwitch.isOn {
            partialrefundStackView.isHidden = false
        }else {
            partialrefundStackView.isHidden = true
        }
    }
    
}
//MARK: -
extension RefundOptionsVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
    
}
