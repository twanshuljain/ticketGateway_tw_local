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
    @IBOutlet weak var btnAppliedAccessCode: UIButton!
    @IBOutlet weak var accesCodeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var accesCodeStackView: UIStackView!
    @IBOutlet weak var enterAccesCodeStackView: UIStackView!
    @IBOutlet weak var lblTotalTicketPrice :DropDown!
    @IBOutlet weak var enterAccessCodeBgView: UIView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var btnRemoveAccessCode : UIButton!
    @IBOutlet weak var lblAccessCodeTopSpace: NSLayoutConstraint!
    
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
        //  self.navigationView.lblTitle.text = (viewModel.eventDetail?.event?.title ?? "") + " - " + (self.viewModel.eventDetail?.eventLocation?.eventCountry ?? "")
        if let eventTitle = viewModel.eventDetail?.event?.title{
            self.navigationView.lblTitle.text = eventTitle
        }
        
        if let eventCountry = self.viewModel.eventDetail?.eventLocation?.eventCountry{
            self.navigationView.lblTitle.text! += " - \(eventCountry)"
        }
        
//        let dateTime = "\(viewModel.eventDetail?.eventDateObj?.eventStartDate?.getDateFormattedFrom() ?? "")" + " • " + "\(viewModel.eventDetail?.eventDateObj?.eventStartTime?.getFormattedTime() ?? "")"
//        self.navigationView.lblDiscripation.text = dateTime
        
        if let date = viewModel.eventDetail?.eventDateObj?.eventStartDate{
            self.navigationView.lblDiscripation.text = date.getDateFormattedFrom()
        }
        
        if let time = viewModel.eventDetail?.eventDateObj?.eventStartTime{
            self.navigationView.lblDiscripation.text! += " • \(time.getFormattedTime())"
        }
       self.lblRefund.text = "Refund Policy : Refund available \(self.viewModel.eventDetail?.eventRefundPolicy?.policyDescription ?? "")"
        
    }
      
    private func setup() {
        self.setUi()
        self.tblEventTicketTypes.configure()
        self.tblEventTicketTypes.updatedPrice = { price in
            self.viewModel.arrTicketList?.removeAll()
            self.viewModel.arrTicketList = self.tblEventTicketTypes.arrTicketList
            self.viewModel.eventDetail?.event?.eventTicketFinalPrice = price
            self.lblTotalTicketPrice.text = "\(AppShareData.sharedObject().getTicketCurrency(currencyType: self.tblEventTicketTypes.arrTicketList?.last?.ticketCurrencyType ?? "")) \(price)"
            self.viewModel.selectedCurrencyType = AppShareData.sharedObject().getTicketCurrency(currencyType: self.tblEventTicketTypes.arrTicketList?.last?.ticketCurrencyType ?? "")
        }
        self.navigationView.delegateBarAction = self
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.delegateBarAction = self
        self.tblEventTicketTypes.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.tblHeight.constant = self.tblEventTicketTypes.contentSize.height
        [self.btnContinue, self.btnAppliedCode, self.btnCheckTermCondition, self.btnAppliedAccessCode, self.btnRemoveAccessCode].forEach {
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
        self.viewModel.selectedCurrencyType = AppShareData.sharedObject().getTicketCurrency(currencyType: self.tblEventTicketTypes.arrTicketList?.last?.ticketCurrencyType ?? "")
        self.lblTotalTicketPrice.text = "\(AppShareData.sharedObject().getTicketCurrency(currencyType: self.tblEventTicketTypes.arrTicketList?.last?.ticketCurrencyType ?? "")) \(Double(self.viewModel.totalTicketPrice) ?? 0.0)"
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
        
        self.btnAppliedAccessCodeAction()
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
                        if self.viewModel.arrTicketList?.count == 0{
                            self.showAlertWithOkButton(message: messageShowToast) {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }else{
                            self.tblEventTicketTypes.arrTicketList = self.viewModel.arrTicketList
                            self.setData()
                            self.tblEventTicketTypes.reloadData()
                        }
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
            self.viewModel.dispatchGroup2.enter()
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
        
        self.viewModel.dispatchGroup2.notify(queue: .main) {
            self.callAddOnApi()
        }
    }
    
    func callAddOnApi() {
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getAddOnTicketList(complition: { isTrue, showMessage in
                if isTrue {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: showMessage)
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
    
    func navigateToPaymentEventBookingTicketAddOns(){
        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketAddOnsVC) as? EventBookingTicketAddOnsVC{
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.totalTicketPriceWithAddOn = self.viewModel.eventDetail?.event?.eventTicketFinalPrice ?? 0.0
            view.viewModel.totalTicketPriceWithoutAddOn = self.viewModel.eventDetail?.event?.eventTicketFinalPrice ?? 0.0
            view.viewModel.feeStructure = self.viewModel.feeStructure
            view.viewModel.selectedArrTicketList = self.tblEventTicketTypes.selectedArrTicketList
            view.viewModel.eventId = self.viewModel.eventId
            view.viewModel.selectedCurrencyType = self.viewModel.selectedCurrencyType
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func navigateToEventPromoCode(){
        if let view = self.createView(storyboard: .home, storyboardID: .EventPromoCodeVC) as? EventPromoCodeVC {
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.feeStructure = self.viewModel.feeStructure
            view.viewModel.selectedArrTicketList = self.tblEventTicketTypes.selectedArrTicketList
            view.viewModel.eventId = self.viewModel.eventId
            view.viewModel.selectedAddOnList = []
            view.viewModel.selectedCurrencyType = self.viewModel.selectedCurrencyType
            self.navigationController?.pushViewController(view, animated: true)
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
        case btnAppliedAccessCode:
            self.btnAppliedAccessCodeAction()
        case btnRemoveAccessCode:
            self.btnRemoveAccessCodeAction()
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
               if (self.viewModel.arrAddOnTicketList?.count == 0) || (self.viewModel.arrAddOnTicketList == nil){
                   self.navigateToEventPromoCode()
               }else{
                   self.navigateToPaymentEventBookingTicketAddOns()
               }
//               if let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketAddOnsVC) as? EventBookingTicketAddOnsVC{
//                   view.viewModel.eventDetail = self.viewModel.eventDetail
//                   view.viewModel.totalTicketPriceWithAddOn = self.viewModel.eventDetail?.event?.eventTicketFinalPrice ?? 0.0
//                   view.viewModel.totalTicketPriceWithoutAddOn = self.viewModel.eventDetail?.event?.eventTicketFinalPrice ?? 0.0
//                   view.viewModel.feeStructure = self.viewModel.feeStructure
//                   view.viewModel.selectedArrTicketList = self.tblEventTicketTypes.selectedArrTicketList
//                   view.viewModel.eventId = self.viewModel.eventId
//                   self.navigationController?.pushViewController(view, animated: true)
//               }
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
                self.btnAppliedCode.isUserInteractionEnabled = false
                self.viewModel.dispatchGroup1.enter()
                viewModel.applyAccessCode(accessCode: txtAccessCode.text ?? "",complition: { isTrue, messageShowToast in
                    if isTrue == true {
                        DispatchQueue.main.async {
                            self.lblAppliedAccessCodeDIs.text = "Access code applied"
                            self.btnRemoveAccessCode.isHidden = false
                            self.lblAppliedAccessCodeDIs.isHidden = false
                            self.lblAppliedAccessCodeDIs.textColor = UIColor.setColor(colorType: .tgGreen)
                            //self.imgApplyAccessCode.isHidden = false
                            self.imgApplyAccessCode.isHidden = true
                            self.enterAccessCodeBgView.borderColor = UIColor.setColor(colorType: .tgBlue)
                            self.btnAppliedCode.setTitles(text: "Applied", font: UIFont.setFont(fontType: .medium, fontSize: .fourteen), tintColour:UIColor.setColor(colorType: .btnDarkBlue))
                        }
                    } else {
                        DispatchQueue.main.async {
                            //  self.view.stopLoading()
                            self.btnAppliedCode.isUserInteractionEnabled = true
                            self.lblAppliedAccessCodeDIs.text = messageShowToast
                            self.lblAppliedAccessCodeDIs.isHidden = false
                            self.lblAppliedAccessCodeDIs.textColor = UIColor.setColor(colorType: .tgRed)
                            //self.showToast(message: messageShowToast)
                        }
                    }
                })
            } else {
                DispatchQueue.main.async {
                    //  self.parentView.stopLoading()
                    self.showToast(message: ValidationConstantStrings.networkLost)
                }
            }
        
        self.viewModel.dispatchGroup1.notify(queue: .main) {
            self.tblEventTicketTypes.arrTicketList = self.viewModel.arrTicketList
            self.tblEventTicketTypes.reloadData()
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
    
    func btnAppliedAccessCodeAction() {
        if viewModel.isAccessCodeAvailable {
            enterAccesCodeStackView.isHidden = false
            accesCodeViewHeight.constant = 300
            accesCodeStackView.isHidden = false
            lblAccessCodeTopSpace.constant = 10
            // isAccessCodeAvailable = false
            btnDown.setImage(UIImage(named: "circlechevronUp_ip"), for: .normal)
        } else {
            enterAccesCodeStackView.isHidden = true
            accesCodeViewHeight.constant = 55
            lblAccessCodeTopSpace.constant = 18
            accesCodeStackView.isHidden = true
            btnDown.setImage(UIImage(named: "circleChevron-down_ip"), for: .normal)
        }
        viewModel.isAccessCodeAvailable = !viewModel.isAccessCodeAvailable
    }
    
    func btnRemoveAccessCodeAction() {
        self.btnAppliedCode.isUserInteractionEnabled = true
        self.lblAppliedAccessCodeDIs.text = ""
        self.btnRemoveAccessCode.isHidden = true
        self.lblAppliedAccessCodeDIs.isHidden = true
        self.txtAccessCode.text = ""
        btnAppliedCode.setTitles(text: "Apply", font: UIFont.setFont(fontType: .medium, fontSize: .fourteen), tintColour: UIColor.setColor(colorType: .btnDarkBlue))
        self.viewModel.arrDataForAccessCode?.forEach({ ticketData in
            self.viewModel.arrTicketList?.removeAll(where: { $0.uniqueTicketID == ticketData.uniqueTicketID })
        })
        self.tblEventTicketTypes.arrTicketList = self.viewModel.arrTicketList
        self.tblEventTicketTypes.reloadData()
    }
    
}

// MARK: - TextField Delegate
extension EventBookingTicketOnApplyCouponVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        btnAppliedCode.isUserInteractionEnabled = true
        var copystring  = ""
        if textField == self.txtAccessCode{
            print(string)
            self.lblAppliedAccessCodeDIs.text = ""
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

