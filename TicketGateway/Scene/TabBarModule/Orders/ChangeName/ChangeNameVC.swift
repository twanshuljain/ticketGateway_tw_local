//
//  ChangeNameVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
// swiftlint: disable line_length

import UIKit

class ChangeNameVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var lblSelectTicket: UILabel!
    @IBOutlet weak var btnSelectTicket: UIButton!
    @IBOutlet weak var txtSelectTickte: UITextField!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lblTicketNameChange: UILabel!
    @IBOutlet weak var btnSaveChanges: CustomButtonGradiant!
    @IBOutlet weak var btnCancel: UIButton!
    
    var viewModel = ChangeNameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setFont()
    }
}
// MARK: - Functions
extension ChangeNameVC {
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = CHANGE_NAME
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
    }
    func setFont() {
        self.lblSelectTicket.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblSelectTicket.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.txtSelectTickte.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.txtSelectTickte.textColor = UIColor.setColor(colorType: .headinglbl)
        self.lblFirstName.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblFirstName.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.txtFirstName.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.txtFirstName.textColor = UIColor.setColor(colorType: .headinglbl)
        self.lblLastName.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblLastName.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.txtLastName.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.txtLastName.textColor = UIColor.setColor(colorType: .headinglbl)
        self.lblTicketNameChange.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTicketNameChange.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnSaveChanges.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSaveChanges.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnSaveChanges.addRightIcon(image: UIImage(named: SAVE_ICON))
        self.btnCancel.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnCancel.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.lblFirstName.attributedText = getAttributedTextAction(attributedText: "*", firstString: FIRST_NAME, lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve), attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        self.lblLastName.attributedText = getAttributedTextAction(attributedText: "*", firstString: LAST_NAME, lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve), attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
        self.txtFirstName.text = viewModel.firstName
        self.txtLastName.text = viewModel.lastName
    }
    
    func apiCall(){
        self.view.endEditing(true)
        viewModel.firstName = self.txtFirstName.text ?? ""
        viewModel.lastName = self.txtLastName.text ?? ""
        
        let isValidate = viewModel.validateInput
        
        if isValidate.isValid{
            if Reachability.isConnectedToNetwork() //check internet connectivity
            {
                self.view.showLoading(centreToView: self.view)
                viewModel.changeTicketName(complition: { isTrue, messageShowToast in
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
        }else{
            self.showToast(message: isValidate.errorMessage)
        }
    }
    
    func navigateToManageSellTicketSuccessfully(){
        if let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully{
            view.strTittle = TICKET_NAME_CHANGED
            view.strComplimentry = "1 Ticket(S) with amount $100.00"
            view.strSummary = TICKET_NAME_SUCCESSFULLY_CHANGED
            view.btnStr = OKAY
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}
// MARK: - Actions
extension ChangeNameVC {
    @IBAction func btnSaveChange(_ sender: Any) {
        self.apiCall()
    }
}
// MARK: - NavigationBarViewDelegate
extension ChangeNameVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
}
