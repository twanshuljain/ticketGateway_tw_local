//
//  ContinueToTransferVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
// swiftlint: disable line_length

import UIKit

class ContinueToTransferVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblConfirmEmail: UILabel!
    @IBOutlet weak var txtConfirmEmail: UITextField!
    @IBOutlet weak var lblNameOnTicket: UILabel!
    @IBOutlet weak var txtNameOnTicket: UITextField!
    @IBOutlet weak var btnChangeNumber: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblOnceTicketTransfer: UILabel!
    @IBOutlet weak var btnTransferTicket: CustomButtonGradiant!
    @IBOutlet weak var btnCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.btnTransferTicket.addTarget(self, action: #selector(showAlert(_:)), for: .touchUpInside)
        self.setNavigationView()
    }
    @objc func showAlert (_ sender: UIButton) {
        self.showAlert(title: TRANSFER_TICKETS, message: "Are you sure to transfer ticket to mangesh@ticketgateway.com.", complition: {_ in
            let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
            view?.strTittle = TICKET_TRANSFERRED
            view?.strComplimentry = "1 Ticket(S) with amount $100.00"
            view?.strSummary = "Ticket for Order Id #32916222 has been successfully transferred to mangesh@ticketgateway.com"
            view?.btnStr = OKAY
            self.navigationController?.pushViewController(view!, animated: true)
        })
    }
}

// MARK: - Functions
extension ContinueToTransferVC {
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = TRANSFER_TICKETS
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
    }
    func setFont() {
        let lbls = [lblPhoneNumber, lblEmail, lblConfirmEmail, lblNameOnTicket]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        let txtflds = [txtPhoneNumber, txtEmail, txtConfirmEmail, txtNameOnTicket]
        for txtfld in txtflds {
            txtfld?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            txtfld?.textColor = UIColor.setColor(colorType: .headinglbl)
        }
        self.btnChangeNumber.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnChangeNumber.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblOnceTicketTransfer.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblOnceTicketTransfer.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnTransferTicket.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        self.btnTransferTicket.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnTransferTicket.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnCancel.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnCancel.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.lblEmail.attributedText = getAttributedTextAction(attributedText: "*", firstString: EMAIL_ADDRESS, lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve), attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        self.lblConfirmEmail.attributedText = getAttributedTextAction(attributedText: "*", firstString: CONFIRM_EMAIL_ADDRESS, lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve), attributedColor: UIColor.red, isToUnderLineAttributeText: false)
    }
}
// MARK: - NavigationBarViewDelegate
extension ContinueToTransferVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
}
