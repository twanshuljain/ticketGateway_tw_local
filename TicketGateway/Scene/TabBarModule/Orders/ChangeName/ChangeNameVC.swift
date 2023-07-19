//
//  ChangeNameVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disbale identifier_name
// swiftlint: disbale function_parameter_count

import UIKit

class ChangeNameVC: UIViewController {

    //MARK: - IBOutlets
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setFont()

    }
}

//MARK: - Functions
extension ChangeNameVC{
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
        
        self.lblFirstName.attributedText = getAttributedTextAction(attributedText: "*", firstString: FIRST_NAME, lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
        self.lblLastName.attributedText = getAttributedTextAction(attributedText: "*", firstString: LAST_NAME, lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
    }
}

//MARK: - Actions
extension ChangeNameVC{
    @IBAction func btnSaveChange(_ sender: Any) {
        let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
        view?.strTittle = TICKET_NAME_CHANGED
        view?.strComplimentry = "1 Ticket(S) with amount $100.00"
        view?.strSummary = TICKET_NAME_SUCCESSFULLY_CHANGED
        view?.btnStr = OKAY
        self.navigationController?.pushViewController(view!, animated: true)
    }
}

//MARK: - NavigationBarViewDelegate
extension ChangeNameVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
    
    
  
}
