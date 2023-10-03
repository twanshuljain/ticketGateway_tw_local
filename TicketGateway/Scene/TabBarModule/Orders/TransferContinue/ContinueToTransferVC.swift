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
    @IBOutlet weak var viewChangeName: UIView!
    
    // MARK: - Variables
    var viewModel = ContinueToTransferViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        //self.btnTransferTicket.addTarget(self, action: #selector(showAlert(_:)), for: .touchUpInside)
        self.setNavigationView()
        self.setData()
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
        self.viewModel.isTCsChecked = false
        self.btnCheck.setBackgroundImage(UIImage.init(named: "uncheck_ip"), for: .normal)
        self.btnTransferTicket.isUserInteractionEnabled = false
        self.btnTransferTicket.alpha = 0.5
        self.btnCheck.cornerRadius = 2
        self.btnCheck.borderWidth = 0.5
        self.btnCheck.borderColor = .lightGray
        self.viewChangeName.backgroundColor = UIColor.setColor(colorType: .bgPurpleColor)
    }
    
    func setData() {
        self.txtNameOnTicket.isUserInteractionEnabled = false
        self.txtNameOnTicket.text = self.viewModel.myTicket?.nameOnTicket ?? ""
    }
    
    func navigateToManageSellTicketSuccessfully() {
        if let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully{
            view.strTittle = TICKET_TRANSFERRED
            view.strComplimentry = "1 Ticket(S) with amount $\(self.viewModel.myTicket?.ticketPrice ?? 0)"
            view.strSummary = "Ticket for Order Id #\(self.viewModel.myTicket?.orderNumber ?? "") has been successfully transferred to \(self.viewModel.email)"
            view.btnStr = OKAY
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func apiTransferTicket() {
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            self.view.showLoading(centreToView: self.view)
            viewModel.transferTicket(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.navigateToManageSellTicketSuccessfully()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
}
// MARK: - Actions
extension ContinueToTransferVC {
    func showAlert() {
        self.showAlert(title: TRANSFER_TICKETS, message: "Are you sure to transfer ticket to \(self.viewModel.email).", complition: {_ in
            self.apiTransferTicket()
        })
    }
    
    @IBAction func btnChangeNumberAction(_ sender:UIButton) {
        self.viewChangeName.backgroundColor = .clear
        self.viewModel.isChangeName = true
        self.txtNameOnTicket.isUserInteractionEnabled = true
    }
    
    @IBAction func btnTransferTicketAction(_ sender:UIButton) {
        self.view.endEditing(true)
        self.viewModel.mobileNumber = self.txtPhoneNumber.text ?? ""
        self.viewModel.email = self.txtEmail.text ?? ""
        self.viewModel.confirmEmail = self.txtConfirmEmail.text ?? ""
        self.viewModel.fullName = self.txtNameOnTicket.text ?? ""
        
        let isValidate = viewModel.validateInput
        
        if isValidate.isValid{
            self.showAlert()
        } else {
            self.showToast(message: isValidate.errorMessage)
        }
    }
    
    @IBAction func btnCheckTCAction(_ sender:UIButton) {
        self.viewModel.isTCsChecked = !self.viewModel.isTCsChecked
        if self.viewModel.isTCsChecked{
            self.btnCheck.cornerRadius = 2
            self.btnCheck.borderWidth = 0.5
            self.btnCheck.borderColor = .lightGray
            self.btnCheck.setBackgroundImage(UIImage.init(named: "uncheck_ip"), for: .normal)
            self.btnTransferTicket.isUserInteractionEnabled = false
            self.btnTransferTicket.alpha = 0.5
        } else {
            self.btnCheck.cornerRadius = 0
            self.btnCheck.borderWidth = 0
            self.btnCheck.borderColor = .clear
            self.btnCheck.setBackgroundImage(UIImage.init(named: "active_ip"), for: .normal)
            self.btnTransferTicket.isUserInteractionEnabled = true
            self.btnTransferTicket.alpha = 1
        }
        
    }
}
// MARK: - NavigationBarViewDelegate
extension ContinueToTransferVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
}
