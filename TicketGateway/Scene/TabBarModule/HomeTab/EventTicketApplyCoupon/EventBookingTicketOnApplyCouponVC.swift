//
//  EventBookingTicketOnApplyCouponVC.swift
//  TicketGateway
//
//  Created by Apple  on 12/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable trailing_whitespace
import UIKit
import iOSDropDown

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
    @IBOutlet weak var btnDown: UIButton!
    @IBOutlet weak var accesCodeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var accesCodeStackView: UIStackView!
    @IBOutlet weak var enterAccesCodeStackView: UIStackView!
    @IBOutlet weak var lblTotalTicketPrice :DropDown!
    @IBOutlet weak var enterAccessCodeBgView: UIView!
    @IBOutlet weak var parentView: UIView!
    //MARK: - Variables
    let viewModel = EventBookingTicketOnApplyCouponViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setNavigationData()
        self.apiCall()
    }
    
}

//MARK: - Functions
extension EventBookingTicketOnApplyCouponVC {
    
    func setNavigationData(){
        self.navigationView.lblTitle.text = (viewModel.eventDetail?.event?.title ?? "") + " - " + (self.viewModel.eventDetail?.eventLocation?.eventCountry ?? "")
        
        let dateTime = "\(viewModel.eventDetail?.eventDateObj?.eventStartDate?.getDateFormattedFrom() ?? "")" + " • " + "\(viewModel.eventDetail?.eventDateObj?.eventStartTime?.getFormattedTime() ?? "")"
        self.navigationView.lblDiscripation.text = dateTime
        
       self.lblRefund.text = "Refund Policy : Refund available \(self.viewModel.eventDetail?.eventRefundPolicy?.policyDescription ?? "")"
        
    }
      
    private func setup() {
        self.setUi()
        self.tblEventTicketTypes.configure()
        self.tblEventTicketTypes.updatedPrice = { price in
            self.viewModel.eventDetail?.event?.eventTicketFinalPrice = price
            self.lblTotalTicketPrice.text = "CA$ \(price)"
        }
        self.navigationView.delegateBarAction = self
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.delegateBarAction = self
        self.tblEventTicketTypes.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.tblHeight.constant = self.tblEventTicketTypes.contentSize.height
        [self.btnContinue, self.btnAppliedCode, self.btnCheckTermCondition, self.btnDown].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.txtAccessCode.delegate = self
        self.txtAccessCode.autocorrectionType = .no
        
        
        txtAccessCode.isUserInteractionEnabled = true
        tblEventTicketTypes.finalPrice = Double(self.viewModel.totalTicketPrice) ?? 0.0
        tblEventTicketTypes.selectedArrTicketList = self.viewModel.selectedArrTicketList
        tblEventTicketTypes.arrTicketList = viewModel.defaultTicket
        
        self.setData()
    }
    
    func setData(){
        self.lblTotalTicketPrice.text = self.viewModel.totalTicketPrice
    }
    
    func setUi(){
        self.lblAppliedAccessCodeDIs.isHidden = true
        self.imgApplyAccessCode.isHidden = true
        self.enterAccessCodeBgView.borderColor = UIColor.setColor(colorType: .borderColor)
        self.lblAppliedAccessCodeDIs.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblAcceptedTermCon.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFewTIcketleft.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFewTIcketleft.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblRefund.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblRefund.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblClickingonCOntinue.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        self.lblAccessCode.font = UIFont.setFont(fontType: .regular, fontSize: .nineteen)
        self.lblAccessCode.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblAppliedAccessCodeDIs.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAppliedAccessCodeDIs.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblAppliedAccessCodeDIs.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 17), tintColour: UIColor.setColor(colorType: .btnDarkBlue))
        btnAppliedCode.setTitles(text: "Apply", font: UIFont.setFont(fontType: .medium, fontSize: .fourteen), tintColour: UIColor.setColor(colorType: .btnDarkBlue))
        self.btnCheckTermCondition.setImage(UIImage(named: IMAGE_UNACTIVE_TERM_ICON), for: .normal)
        
        self.btnDownAction()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblHeight.constant = tblEventTicketTypes.contentSize.height
        
    }
    
    func apiCall(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            self.viewModel.dispatchGroup.enter()
            viewModel.getEventTicketList(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    DispatchQueue.main.async {
                        self.tblEventTicketTypes.arrTicketList = self.viewModel.arrTicketList
                         self.tblEventTicketTypes.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.parentView.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
        
        self.viewModel.dispatchGroup.notify(queue: .main) {
            self.apiCallForFeeStructure()
        }
    }
    
    func apiCallForFeeStructure() {
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getEventTicketFeeStructure(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    print(self.viewModel.feeStructure)
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.parentView.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
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
        case btnDown:
            self.btnDownAction()
        default:
            break
        }
    }

   func btnContinueAction() {
       if viewModel.isCheckedTerm_COndition == true {
           /*
           let view = self.createView(storyboard: .home, storyboardID: .EventPromoCodeVC) as! EventPromoCodeVC
           view.selectedArrTicketList = self.viewModel.selectedArrTicketList
           view.eventId = self.viewModel.eventId
           view.eventDetail = self.viewModel.eventDetail
           view.feeStructure = self.viewModel.feeStructure
           self.navigationController?.pushViewController(view, animated: true)
            */
           if self.tblEventTicketTypes.selectedArrTicketList.count == 0{
               self.showToast(message: "Please select ticket")
           }else{
               if let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketAddOnsVC) as? EventBookingTicketAddOnsVC{
                   view.viewModel.eventDetail = self.viewModel.eventDetail
                   view.viewModel.feeStructure = self.viewModel.feeStructure
                   view.viewModel.selectedArrTicketList = self.tblEventTicketTypes.selectedArrTicketList
                   view.viewModel.eventId = self.viewModel.eventId
                   self.navigationController?.pushViewController(view, animated: true)
               }
           }
       } else {
           self.showToast(message: "Please Accept Terms and Condition")

       }
       
       
       
//       if let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketAddOnsVC) as? EventBookingTicketAddOnsVC{
//           view.totalTicketPrice = self.viewModel.totalTicketPrice
//           view.feeStructure = self.viewModel.feeStructure
//           self.navigationController?.pushViewController(view, animated: true)
//       }
    }
    func btnAppliedCodeAction() {
        
       
            if Reachability.isConnectedToNetwork() //check internet connectivity
            {
                //  self.view.showLoading(centreToView: UIView())
                viewModel.applyAccessCode(accessCode: txtAccessCode.text ?? "",complition: { isTrue, messageShowToast in
                    if isTrue == true {
                        // self.view.stopLoading()
                        DispatchQueue.main.async {
                            self.tblEventTicketTypes.isFromAccessCode = true
                            self.viewModel.defaultTicket.append(contentsOf: self.viewModel.arrDataForAccessCode)
                            self.tblEventTicketTypes.arrDataAccessCode = self.viewModel.defaultTicket
                            self.lblAppliedAccessCodeDIs.isHidden = false
                            self.lblAppliedAccessCodeDIs.textColor = UIColor.setColor(colorType: .tgGreen)
                            self.imgApplyAccessCode.isHidden = false
                            self.enterAccessCodeBgView.borderColor = UIColor.setColor(colorType: .tgBlue)
                            self.btnAppliedCode.setTitles(text: "Applied", font: UIFont.setFont(fontType: .medium, fontSize: .fourteen), tintColour:UIColor.setColor(colorType: .btnDarkBlue))
                            self.tblEventTicketTypes.reloadData()
                        }
                    } else {
                        DispatchQueue.main.async {
                            //  self.view.stopLoading()
                            self.showToast(message: messageShowToast)
                        }
                    }
                })
            } else {
                DispatchQueue.main.async {
                    //  self.parentView.stopLoading()
                    self.showToast(message: ValidationConstantStrings.networkLost)
                }
            }
        
       
        
    }
    
    func btnCheckTermConditionAction(){
        if viewModel.isCheckedTerm_COndition == false
        {
            viewModel.isCheckedTerm_COndition = true
            self.btnCheckTermCondition.setImage(UIImage(named: IMAGE_ACTIVE_TERM_ICON), for: .normal)
        }
        else {
            viewModel.isCheckedTerm_COndition = false
            self.btnCheckTermCondition.setImage(UIImage(named: IMAGE_UNACTIVE_TERM_ICON), for: .normal)
        }
        
    }
    
    func btnDownAction() {
        if viewModel.isAccessCodeAvailable {
            enterAccesCodeStackView.isHidden = false
            accesCodeViewHeight.constant = 300
            accesCodeStackView.isHidden = false
            // isAccessCodeAvailable = false
            btnDown.setImage(UIImage(named: "circleChevron-down_ip"), for: .normal)
        } else {
            enterAccesCodeStackView.isHidden = true
            accesCodeViewHeight.constant = 55
            accesCodeStackView.isHidden = true
           
            btnDown.setImage(UIImage(named: "circlechevronUp_ip"), for: .normal)
        }
        viewModel.isAccessCodeAvailable = !viewModel.isAccessCodeAvailable
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

