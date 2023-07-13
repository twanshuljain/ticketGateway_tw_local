//
//  ContactOrganiserVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
//

import UIKit

class ContactOrganiserVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var lblSunburnReload: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var txtReason: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSendMessage: CustomButtonGradiant!
    
    //MARK: - Variables
    var selectedReason: String?
    var reasonList = ["Choose one", "Question about the event", "Question about my ticket"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setFont()
        self.createPickerView()
        self.dismissPickerView()

    }
}

//MARK: - Functions
extension ContactOrganiserVC {
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.imgBack.image = UIImage(named: CANCEL_ICON)
        self.vwNavigationView.lblTitle.text = CONTACT_ORGANISER
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
    }
    
    func setFont() {
        self.lblSunburnReload.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        self.lblSunburnReload.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        let lbls = [lblName, lblEmailAddress, lblReason, lblMessage]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        
        let txtflds = [txtName, txtEmailAddress, txtReason, txtMessage]
        for txtfld in txtflds {
            txtfld?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            txtfld?.textColor = UIColor.setColor(colorType: .Headinglbl)
        }
        
        self.btnSendMessage.addRightIcon(image: UIImage(named: LEFT_ARROW))
        self.btnSendMessage.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSendMessage.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
        self.lblName.attributedText = getAttributedTextAction(attributedText: "*", firstString: NAME, lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
        self.lblEmailAddress.attributedText = getAttributedTextAction(attributedText: "*", firstString: EMAIL_ADDRESS, lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
        self.lblReason.attributedText = getAttributedTextAction(attributedText: "*", firstString: REASON, lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        [btnSendMessage].forEach{
            $0?.addTarget(self, action: #selector(btnSendAction(sender:)), for: .touchUpInside)
        }
        
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.setColor(colorType: .white)
        pickerView.delegate = self
        txtReason.inputView = pickerView
    }
    func dismissPickerView() {
        
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //      let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.action))
        let button = UIBarButtonItem(title: DONE, style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtReason.inputAccessoryView = toolBar
    }
    @objc func action() {
        view.endEditing(true)
    }
}

//MARK: - Actions
extension ContactOrganiserVC {
    
    @objc func btnSendAction(sender:UIButton) {
        let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
        view?.strTittle = CHANGE_ORGANISER
        view?.strComplimentry = ""
        view?.strSummary = MESSAGE_SUCCESSFULLY_SENT_TO_ORGANISER
        view?.btnStr = OKAY
        self.navigationController?.pushViewController(view!, animated: true)
    }
}


//MARK: - UIPickerViewDelegate, UIPickerViewDataSource,  UITextFieldDelegate
extension ContactOrganiserVC: UIPickerViewDelegate, UIPickerViewDataSource,  UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reasonList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reasonList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedReason = reasonList[row]
        txtReason.text = selectedReason

    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = reasonList[row]
        pickerLabel?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)

        return pickerLabel!
    }
}

//MARK: - NavigationBarViewDelegate
extension ContactOrganiserVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
  
}
