//
//  EventBookingTicketOnApplyCouponVC.swift
//  TicketGateway
//
//  Created by Apple  on 12/05/23.
//

import UIKit

class EventBookingTicketOnApplyCouponVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblRefund: UILabel!
    @IBOutlet weak var lblAcceptedTermCon: UILabel!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblEventTicketTypes: TicketTypeListTableView!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
 
    @IBOutlet weak var lblFewTIcketleft: UILabel!
    @IBOutlet weak var lblClickingonCOntinue: UILabel!
    
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    
    //coupon
    @IBOutlet weak var btnCheckTermCondition: UIButton!
    @IBOutlet weak var txtAccessCode : UITextField!
    @IBOutlet weak var viewApplyAccessCode: UIView!
    @IBOutlet weak var btnAppliedCode: CustomButtonGradiant!
    @IBOutlet weak var imgApplyAccessCode: UIImageView!
    @IBOutlet weak var imgCross: UIImageView!
    @IBOutlet weak var lblAccessCode: UILabel!
    @IBOutlet weak var lblonAppliedAccessCodeValidation: UILabel!
    @IBOutlet weak var lblAppliedAccessCodeDIs: UILabel!
    
    //MARK: - Variables
    var isCheckedTerm_COndition = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }

}

//MARK: - Functions
extension EventBookingTicketOnApplyCouponVC {
    private func setup() {
        self.setUi()
        self.tblEventTicketTypes.configure()
        self.navigationView.delegateBarAction = self
          self.navigationView.lblTitle.text = "Sunburn reload NYE - toronto"
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.lblDiscripation.text = "Saturday, March 18 • 6:00 AM"
          self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
          self.navigationView.delegateBarAction = self
        self.tblEventTicketTypes.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.tblHeight.constant = self.tblEventTicketTypes.contentSize.height
        [self.btnContinue,self.btnAppliedCode,btnCheckTermCondition].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.txtAccessCode.delegate = self
        self.txtAccessCode.autocorrectionType = .no
     }
    func setUi(){
        self.lblAcceptedTermCon.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFewTIcketleft.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFewTIcketleft.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblRefund.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblRefund.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblClickingonCOntinue.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        
        self.lblAccessCode.font = UIFont.setFont(fontType: .regular, fontSize: .nineteen)
        self.lblAccessCode.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblAppliedAccessCodeDIs.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAppliedAccessCodeDIs.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblAppliedAccessCodeDIs.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        btnAppliedCode.setTitles(text: "Applied", font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        self.btnCheckTermCondition.setImage(UIImage(named: "unactiveTerm"), for: .normal)
        
     }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblHeight.constant = tblEventTicketTypes.contentSize.height
        
   }
}

//MARK: - Actions
extension EventBookingTicketOnApplyCouponVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case btnAppliedCode:
            self.btnAppliedCodeAction()
        case btnCheckTermCondition :
            self.btnCheckTermConditionAction()
        default:
            break
        }
    }
    
   func btnContinueAction() {
       let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketAddOnsVC) as? EventBookingTicketAddOnsVC
       self.navigationController?.pushViewController(view!, animated: true)
    }
    func btnAppliedCodeAction() {
         
     }
    
    func btnCheckTermConditionAction(){
        if isCheckedTerm_COndition == false
        {
            isCheckedTerm_COndition = true
            self.btnCheckTermCondition.setImage(UIImage(named: "activeTerm"), for: .normal)
        }
        else {
            isCheckedTerm_COndition = false
            self.btnCheckTermCondition.setImage(UIImage(named: "unactiveTerm"), for: .normal)
        }
        
    }
}

// MARK: - TextField Delegate
extension EventBookingTicketOnApplyCouponVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var copystring  = ""
        if textField == self.txtAccessCode{
           print(string)

            if string.count > 1{
                if let theString = UIPasteboard.general.string {
                       print("String is \(theString)")
                       copystring  =  theString.replacingOccurrences(of: " ", with: "")
                    if copystring.count >= 9
                    {
                       self.txtAccessCode.text = String(copystring.prefix(20))
                    }
                    else
                    {
                        self.txtAccessCode.text = String(copystring)
                    }
                    return false
                       //UIPasteboard.general.string = ""
                }
            }
            else
            if (range.location == 0 && string == " ") {
                        return false
            }
            else if string == " "
            {
                return false
            }
            
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
}

//MARK: - NavigationBarViewDelegate
extension EventBookingTicketOnApplyCouponVC : NavigationBarViewDelegate {
    func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}

