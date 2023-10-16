//
//  EventCheckoutVerifyViewController.swift
//  TicketGateway
//
//  Created by Apple on 11/10/23.
//

import UIKit

class EventCheckoutVerifyVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var confirmEmailView: UIStackView!
    @IBOutlet weak var lblConfirmEmailAddress: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtConfirmEmailAddress: UITextField!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var vwNumber: UIView!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
    @IBOutlet weak var btnSelectCountry: UIButton!
    @IBOutlet weak var lblErrFirstName: UILabel!
    @IBOutlet weak var lblErrLastName: UILabel!
    @IBOutlet weak var lblErrMobileNumber: UILabel!
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var lblVerified: UILabel!
    
    
    @IBOutlet weak var vwDottedDIscount: UIView!
    @IBOutlet weak var vwDotteds: UIView!
    @IBOutlet weak var vwDotted: UIView!
    @IBOutlet weak var heightOfTickets: NSLayoutConstraint!
    @IBOutlet weak var heightOfAddOn: NSLayoutConstraint!
    @IBOutlet weak var tblAddedTickets: TicketAddInOrderTableViewList!
    @IBOutlet weak var tblAddOnEtcThings: AddOnAddInOrderTableViewList!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblSubTotalValue: UILabel!
    @IBOutlet weak var lblServiceCharge: UILabel!
    @IBOutlet weak var lblServiceChargeValue: UILabel!
    @IBOutlet weak var lblfacilityFee: UILabel!
    @IBOutlet weak var lblfacilityFeeValue: UILabel!
    @IBOutlet weak var lblProcessingFee: UILabel!
    @IBOutlet weak var lblProcessingFeeValue: UILabel!
    @IBOutlet weak var lblTotalAmt: UILabel!
    @IBOutlet weak var lblTotalAmtValue: UILabel!
    @IBOutlet weak var lblContractOrganiser: UILabel!
    @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblRefundDisc: UILabel!
    @IBOutlet weak var lblDiscouted: UILabel!
    @IBOutlet weak var lblDiscoutedValue: UILabel!
    @IBOutlet weak var discountViewHt : NSLayoutConstraint!
    
    var viewModel = EventCheckoutVerifyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setUi()
        self.setData()
    }

}

// MARK: - Functions
extension EventCheckoutVerifyVC {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightOfTickets.constant = tblAddedTickets.contentSize.height
        if self.viewModel.selectedAddOnList.count == 0{
            self.heightOfAddOn.constant = 0
        }else{
            self.heightOfAddOn.constant = tblAddOnEtcThings.contentSize.height
        }
        
    }
    
    private func setup() {
        self.tblAddedTickets.configure()
        self.tblAddedTickets.selectedCurrencyType = self.viewModel.selectedCurrencyType
        self.tblAddOnEtcThings.configure()
        self.tblAddOnEtcThings.selectedCurrencyType = self.viewModel.selectedCurrencyType
        self.tblAddedTickets.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfTickets.constant = self.tblAddedTickets.contentSize.height
        self.tblAddOnEtcThings.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfAddOn.constant = self.tblAddOnEtcThings.contentSize.height
        
        
        
        
        
        
        self.viewModel.countries = self.jsonSerial()
        self.collectCountries()
        self.txtFirstName.delegate = self
        self.txtLastName.delegate = self
        self.txtMobileNumber.delegate = self
        self.txtEmailAddress.delegate = self
        self.txtConfirmEmailAddress.delegate = self
        
        self.lblVerified.isHidden = true
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = ENTER_DETAIL_TITLE
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.btnBack.isHidden = false
        self.navigationView.lblTitle.isHidden = false
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.setFont(fontType: .medium, fontSize: .fourteen), tintColour: UIColor.setColor(colorType: .btnDarkBlue))
        btnGoBack.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        btnGoBack.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        [self.btnContinue, self.btnGoBack, self.btnSelectCountry].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
       
        
        //self.viewModel.emailAddress = objAppShareData.dicToHoldDataOnSignUpModule?.strEmail ?? ""
        self.lblFirstName.text = First_Name
        self.lblLastName.text = Last_Name
        self.lblMobileNumber.text = MOBILE_NUMBER
        self.lblEmailAddress.text = EMAIL_ADDRESS
        self.lblConfirmEmailAddress.text = CONFIRM_EMAIL
        self.setIntialUiDesign()
        if !UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin) {
            self.confirmEmailView.isHidden = true
            self.apiCallForEmailVerification()
        }else{
            self.confirmEmailView.isHidden = false
        }
    }
    
    func setUi(){
        [self.lblSubTotal,lblSubTotalValue,self.lblfacilityFee,self.lblfacilityFeeValue,self.lblServiceCharge,self.lblServiceChargeValue,self.lblProcessingFee,self.lblProcessingFeeValue].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        [self.lblDiscouted,self.lblDiscoutedValue].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .tgGreen)
        }
        self.lblTotalAmt.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblTotalAmt.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblTotalAmtValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblTotalAmtValue.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblRefundPolicy.font = UIFont.setFont(fontType: .semiBold, fontSize: .twelve)
        self.lblRefundPolicy.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblContractOrganiser.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblContractOrganiser.textColor = UIColor.setColor(colorType: .tgBlue)
        self.lblRefundDisc.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblRefundDisc.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblContractOrganiser.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblContractOrganiser.textColor = UIColor.setColor(colorType: .tgBlue)
        vwDotted.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
        vwDotteds.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
        vwDottedDIscount.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
//        self.btnContinue.alpha = 0.5
//        self.btnContinue.isUserInteractionEnabled = false
    }
    
    func setData() {
        var serviceCharge =  Double(self.viewModel.feeStructure?.serviceFees?.charge ?? 0)
        var processingCharge = Double((self.viewModel.feeStructure?.processingFees?.charge ?? 0))
        var facilityCharge = Double(self.viewModel.feeStructure?.facilityFees?.charge ?? 0)
        let subTotal = self.viewModel.eventDetail?.event?.eventTicketFinalPrice ?? 0.0
        let discountValue = self.viewModel.eventDetail?.event?.discountValue ?? 0.0
        let discountedFinalPrice = self.viewModel.eventDetail?.event?.discountedFinalPrice ?? 0.0
        
        if self.viewModel.feeStructure?.serviceFees?.chargeType == "PERCENTAGE"{
            serviceCharge = (subTotal / 100) * serviceCharge
        }
        
        if self.viewModel.feeStructure?.processingFees?.chargeType == "PERCENTAGE"{
            processingCharge = (subTotal / 100) * processingCharge
        }
        
        if self.viewModel.feeStructure?.facilityFees?.chargeType == "PERCENTAGE"{
            facilityCharge = (subTotal / 100) * facilityCharge
        }
        
        
        let convertedServiceCharge = self.convertToTwoDecimalPlaces(serviceCharge)
        let convertedProcessingCharge = self.convertToTwoDecimalPlaces(processingCharge)
        let convertedFacilityCharge = self.convertToTwoDecimalPlaces(facilityCharge)
        
        let convertedSubTotal = self.convertToTwoDecimalPlaces(subTotal)
        let convertedDiscountValue = self.convertToTwoDecimalPlaces(discountValue)
        _ = self.convertToTwoDecimalPlaces(discountedFinalPrice)
        
        
        self.lblServiceChargeValue.text = "\(self.viewModel.selectedCurrencyType)\(convertedServiceCharge ?? "")"
        self.lblProcessingFeeValue.text = "\(self.viewModel.selectedCurrencyType)\(convertedProcessingCharge ?? "")"
        self.lblfacilityFeeValue.text = "\(self.viewModel.selectedCurrencyType)\(convertedFacilityCharge ?? "")"
        self.lblSubTotalValue.text = "\(self.viewModel.selectedCurrencyType)\(convertedSubTotal ?? "")"
        var total = 0.0
        
//        if isPercentage{
//            serviceCharge = (serviceCharge / 100) * subTotal
//            processingCharge = (serviceCharge / 100) * subTotal
//            facilityCharge = (facilityCharge / 100) * subTotal
//            discountedFinalPrice = (discountedFinalPrice / 100) * subTotal
//            total = serviceCharge + processingCharge + facilityCharge + discountedFinalPrice
//        }else{
//            total = serviceCharge + processingCharge + facilityCharge + discountedFinalPrice
//        }
        
        if discountValue != 0.0 && self.viewModel.discountType != nil{
            total = serviceCharge + processingCharge + facilityCharge + discountedFinalPrice
            self.lblDiscouted.isHidden = false
            self.lblDiscoutedValue.isHidden = false
            self.discountViewHt.constant = 40
            self.lblDiscoutedValue.text = self.viewModel.discountType == .PERCENTAGE ? "-\(convertedDiscountValue ?? "")%" : "- \(self.viewModel.selectedCurrencyType)\(convertedDiscountValue ?? "")"
        }else{
            total = serviceCharge + processingCharge + facilityCharge + subTotal
            self.lblDiscouted.isHidden = true
            self.lblDiscoutedValue.isHidden = true
            self.discountViewHt.constant = 0
        }
        
        
        
        self.lblTotalAmtValue.text = "\(self.viewModel.selectedCurrencyType)\(convertToTwoDecimalPlaces(total) ?? "")"
        self.viewModel.totalTicketPrice = "\(convertToTwoDecimalPlaces(total) ?? "")"
        self.tblAddedTickets.selectedArrTicketList = self.viewModel.selectedArrTicketList
        self.tblAddOnEtcThings.selectedAddOnList = self.viewModel.selectedAddOnList
        DispatchQueue.main.async {
            self.tblAddedTickets.reloadData()
            self.tblAddOnEtcThings.reloadData()
        }
    }

    @objc func textFieldErrorMsg(_ sender: UITextField) {
        switch sender {
        case txtFirstName:
            self.firstNameErrorMsg()
        case txtLastName:
            self.lastNameErrorMsg()
        case txtMobileNumber:
            self.mobileErrMsg()
        case btnSelectCountry:
            self.btnSelectCountryAction()
        default:
            break
        }

    }

    func firstNameErrorMsg() {
         if txtFirstName.text == "" {
             lblErrFirstName.isHidden = false
        } else {
            lblErrFirstName.isHidden = true
        }
    }

    func lastNameErrorMsg() {
         if txtLastName.text == "" {
             lblErrLastName.isHidden = false
        } else {
            lblErrLastName.isHidden = true
        }
    }

    func mobileErrMsg() {
        if txtMobileNumber.text == "" {
            lblErrMobileNumber.isHidden = false
        } else {
            lblErrMobileNumber.isHidden = true
        }
    }
}

// MARK: - Actions
extension EventCheckoutVerifyVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case btnGoBack:
            self.navigationController?.popViewController(animated: true)
        case btnSelectCountry:
            self.btnSelectCountryAction()
        default:
            break
        }
    }
    func btnSelectCountryAction() {
        self.view.endEditing(true)
        let strybrd = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as! RSCountryPickerController
        strybrd.RScountryDelegate = self
        strybrd.strCheckCountry = self.viewModel.strCountryName
        strybrd.modalPresentationStyle = .fullScreen
        self.navigationController?.present(strybrd, animated: true, completion: nil)
    }
    
    func navigateToPaymentVc(){
        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingPaymentMethodVC) as? EventBookingPaymentMethodVC{
            view.viewModel.eventId = self.viewModel.eventId
            view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList ?? [EventTicket]()
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.feeStructure = self.viewModel.feeStructure
            view.viewModel.totalTicketPrice = self.viewModel.totalTicketPrice
            view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList ?? [EventTicketAddOnResponseModel]()
            view.viewModel.selectedCurrencyType = self.viewModel.selectedCurrencyType
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func apiCallForEmailVerification(){
        if Reachability.isConnectedToNetwork() {
            let param = CheckEmail(emailAddress: self.txtEmailAddress.text ?? "")
            self.view.showLoading(centreToView: self.view)
            viewModel.checkEmail(param: param) { isTrue, messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.lblVerified.isHidden =  false
                        self.txtEmailAddress.borderColor = UIColor.setColor(colorType: .tgGreen)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.lblVerified.isHidden =  true
                        self.txtEmailAddress.borderColor = UIColor.setColor(colorType: .borderLineColour)
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    
    func apiCallForValidateUser(){
        if Reachability.isConnectedToNetwork() {
            self.view.showLoading(centreToView: self.view)
            let param = ValidateForNumberRequest(cellPhone: self.txtMobileNumber.text ?? "", email: self.txtEmailAddress.text ?? "", countryCode: self.lblDialCountryCode.text ?? "" , firstName: self.txtFirstName.text ?? "", lastName: self.txtLastName.text ?? "")
            viewModel.checkoutValidateUser(param: param) { isTrue , messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async { [self] in
                        self.view.stopLoading()
                        let userModel = self.viewModel.authModel
                        UserDefaultManager.share.clearAllUserDataAndModel()
                        let objUserModel = SignInAuthModel(id: userModel?.id, number: userModel?.number, firstName: userModel?.firstName, lastName: userModel?.lastName, email:  userModel?.email, accessToken:  userModel?.accessToken, refreshToken: userModel?.refreshToken, strDialCountryCode: "\(lblDialCountryCode.text ?? "")")
                        UserDefaultManager.share.storeModelToUserDefault(userData: objUserModel, key: .userAuthData)
                        
                        self.navigateToPaymentVc()
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }

    }
    
    func btnContinueAction() {
        viewModel.emailAddress = self.txtEmailAddress.text ?? ""
        viewModel.confirmEmailAddress = self.txtConfirmEmailAddress.text ?? ""
        viewModel.firstName = self.txtFirstName.text ?? ""
        viewModel.lastName = self.txtLastName.text ?? ""
        viewModel.mobileNumber = self.txtMobileNumber.text ?? ""
        let isValidate = viewModel.validateUserInput
        if isValidate.isValid {
            self.apiCallForValidateUser()
        } else {
            self.view.stopLoading()
            self.showToast(message: isValidate.errorMessage)
        }
    }
}

// MARK: -  Country Code
extension EventCheckoutVerifyVC: RSCountrySelectedDelegate  {
    func setIntialUiDesign() {
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        self.txtEmailAddress.text =  userModel?.email ?? ""
        self.txtFirstName.text = userModel?.firstName ?? ""
        self.txtLastName.text = userModel?.lastName ?? ""
        self.txtConfirmEmailAddress.text = self.txtEmailAddress.text ?? ""
        
        let number = userModel?.number
        if number?.contains("+91") ?? false{
            self.txtMobileNumber.text = userModel?.number?.replacingOccurrences(of: "+91", with: "")
        }else{
            self.txtMobileNumber.text = number
        }
        
        self.txtMobileNumber.addDoneButtonOnKeyboard()
        // Defoult Country
        // UI Changes---
        self.imgCountry.image = nil
        if self.imgCountry.image == nil {
            var str = ""
            var arr = viewModel.RScountriesModel.filter({$0.dial_code == str})
            
            if userModel?.strDialCountryCode != nil && userModel?.strDialCountryCode != ""{
                str = userModel?.strDialCountryCode ?? ""
                arr = viewModel.RScountriesModel.filter({$0.dial_code == str})
                
                if !arr.indices.contains(0){
                    str = NSLocale.current.regionCode ?? ""
                    arr = viewModel.RScountriesModel.filter({$0.country_code == str})
                }
            }else{
                str = NSLocale.current.regionCode ?? ""
                arr = viewModel.RScountriesModel.filter({$0.country_code == str})
            }
           
            self.lblDialCountryCode.text = "+91"
            var imagePath = "CountryPicker.bundle/\(str).png"
            
            if arr.count == 2{
                arr.removeAll { country in
                    country.country_code != (NSLocale.current.regionCode ?? "")
                }
            }
            
            if let flagImg = UIImage(named: imagePath){
                self.imgCountry.image = flagImg
            }else{
                if arr.indices.contains(0){
                    str = arr[0].country_code
                    imagePath = "CountryPicker.bundle/\(str).png"
                    self.imgCountry.image = UIImage(named: imagePath)
                }
            }
            if arr.count>0 {
                let country = arr[0]
                self.viewModel.strCountryDialCode = country.dial_code
                self.lblDialCountryCode.text = country.dial_code
                self.viewModel.strCountryCode = country.country_code
                self.viewModel.strCountryName = country.country_name
                self.lblDialCountryCode.text = country.dial_code
                self.viewModel.strCountryCode = country.country_code
                let imagePath = "CountryPicker.bundle/\( country.country_code).png"
                self.imgCountry.image = UIImage(named: imagePath)
            }
        } else {
            // noting to do
        }
    }
    func collectCountries() {
        for country in viewModel.countries {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            viewModel.RScountriesModel.append(CountryInfo(country_code: code, dial_code: dailcode, country_name: name))
        }
    }
    func RScountrySelected(countrySelected country: CountryInfo) {
        let imagePath = "CountryPicker.bundle/\(country.country_code).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.viewModel.strCountryDialCode = country.dial_code
        self.lblDialCountryCode.text = country.dial_code
        self.viewModel.strCountryCode = country.country_code
        self.viewModel.strCountryName = country.country_name
        self.txtMobileNumber.becomeFirstResponder()
        self.viewModel.mobileNumber = ""
        self.txtMobileNumber.text = ""
    }
}
// MARK: - UITextFieldDelegate
extension EventCheckoutVerifyVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.txtEmailAddress {
            self.apiCallForEmailVerification()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtEmailAddress {
            self.txtFirstName.becomeFirstResponder()
        } else if textField == self.txtFirstName {
            self.txtLastName.becomeFirstResponder()
        } else if textField == self.txtLastName {
            self.txtMobileNumber.becomeFirstResponder()
        } else if textField == self.txtMobileNumber {
            self.txtMobileNumber.becomeFirstResponder()
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        let mobileNoLimit = 11
        if textField == txtEmailAddress {
           viewModel.emailAddress = text.replacingCharacters(in: textRange, with: string)
       }else if textField == txtFirstName {
            viewModel.firstName = text.replacingCharacters(in: textRange, with: string)
        }else if textField == txtLastName {
            viewModel.lastName = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtMobileNumber {
            // viewModel.mobileNumber = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            let valid = newLength <= mobileNoLimit
            if valid{
                viewModel.mobileNumber = "\(text.replacingCharacters(in: textRange, with: string))"
            }
            return valid
        }
        return true
    }
}
// MARK: - NavigationBarViewDelegate
extension EventCheckoutVerifyVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
        
    }
}
