//
//  PhoneVerificationViewController.swift
//  TicketGateway
//
//  Created by Apple on 04/07/23.


import UIKit
import SVProgressHUD
enum UserType {
    case new
    case existing
    case changeNumber
}

enum IsComingFrom {
    case login
    case orderSummary
    case home
}

class PhoneVerificationViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var btnSelectCountry: UIButton!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
    @IBOutlet weak var vwNumber: UIView!
    @IBOutlet weak var btnChangeNumber:UIButton!
    @IBOutlet weak var vwEmail:UIView!
    @IBOutlet weak var vwEmaiLabel:UIView!
    @IBOutlet weak var txtEmail:UITextField!
    
    // MARK: - Variable
    var signInViewModel = SignInViewModel()
    var viewModel = PhoneVerifyViewModel()
    var userType: UserType  = .existing
    var isChangeMobileNumberTap = false
    var isComingFrom: IsComingFrom  = .login
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setIntialUiDesign()
    }
}
// MARK: - Functions
extension PhoneVerificationViewController {
    private func setup() {
        navigationView.lblTitle.text = PHONE_VERIFICATION
        navigationView.btnBack.isHidden = false
        navigationView.delegateBarAction = self
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        self.signInViewModel.countries = self.jsonSerial()
        self.collectCountries()
        self.imgCountry.image = nil
        self.txtNumber.delegate = self
        self.vwNumber.layer.cornerRadius = 5
        self.vwNumber.layer.borderWidth = 0.5
        self.vwNumber.layer.borderColor = UIColor.lightGray.cgColor
        self.txtNumber.text = ""
        
        self.vwEmail.layer.cornerRadius = 5
        self.vwEmail.layer.borderWidth = 0.5
        self.vwEmail.layer.borderColor = UIColor.lightGray.cgColor
        self.txtEmail.text = ""
        self.signInViewModel.isForEmail = false
    }
}

// MARK: - Actions
extension PhoneVerificationViewController {
    @IBAction func btnSelectCountryAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as? RSCountryPickerController
        storyBoard?.RScountryDelegate = self
        storyBoard?.strCheckCountry = self.signInViewModel.strCountryName
        storyBoard?.modalPresentationStyle = .fullScreen
        self.navigationController?.present(storyBoard ?? UIViewController(), animated: true, completion: nil)
    }
    @IBAction func btnContinueAction(_ sender: UIButton) {
        if (self.userType == .new) || (userType == .existing && self.isChangeMobileNumberTap == true) {
            viewModel.emailAddress = self.txtEmail.text ?? ""
            viewModel.mobileNumber = self.txtNumber.text ?? ""
            var isValidate = viewModel.validateUserInput
            if (userType == .existing && self.isChangeMobileNumberTap == true) {
                isValidate = viewModel.validateUserMobile
            } else {
                isValidate = viewModel.validateUserInput
            }
            if isValidate.isValid {
                if Reachability.isConnectedToNetwork() {
                    self.view.showLoading(centreToView: self.view)
                    let number = "\(lblDialCountryCode.text ?? "")" + (self.txtNumber.text ?? "")
                    let numberWithoutCode = self.txtNumber.text ?? ""
                    let param = ValidateForNumberRequest(cellPhone: numberWithoutCode, email: self.txtEmail.text ?? "", countryCode: lblDialCountryCode.text ?? "")
                    signInViewModel.checkoutValidateUser(param: param) { isTrue , messageShowToast in
                        if isTrue == true {
                            DispatchQueue.main.async { [self] in
                                self.view.stopLoading()
                                let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
                                UserDefaultManager.share.clearAllUserDataAndModel()
                                let objUserModel = SignInAuthModel(
                                    id: userModel?.id, number: numberWithoutCode,
                                    fullName: userModel?.fullName, email: userModel?.email,
                                    accessToken:  userModel?.accessToken,
                                    refreshToken: userModel?.refreshToken,
                                    strDialCountryCode: "\(lblDialCountryCode.text ?? "")"
                                )
                                UserDefaultManager.share.storeModelToUserDefault(userData: objUserModel, key: .userAuthData)
                                
                                if let view = self.createView(storyboard: .main, storyboardID: .OtpNumberVC) as? OtpNumberVC{
                                    let obj = DataHoldOnSignUpProcessModel.init(
                                        strEmail: "", strNumber: self.txtNumber.text ?? "", strStatus: "",
                                        strDialCountryCode: self.lblDialCountryCode.text ?? "",
                                        strCountryCode: self.signInViewModel.strCountryCode
                                    )
                                    objAppShareData.dicToHoldDataOnSignUpModule = obj
                                    view.isComingFromLogin = false
                                    view.isComingFrom = self.isComingFrom
                                    view.userType = self.userType
                                    view.viewModel.number = "\(lblDialCountryCode.text ?? "") " + "-" + (self.txtNumber.text ?? "")
                                    view.viewModel.eventId = self.viewModel.eventId
                                    view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList ?? [EventTicket]()
                                    view.viewModel.eventDetail = self.viewModel.eventDetail
                                    view.viewModel.feeStructure = self.viewModel.feeStructure
                                    view.viewModel.totalTicketPrice = self.viewModel.totalTicketPrice
                                    view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList ?? [EventTicketAddOnResponseModel]()
                                    view.isChangeMobileNumberTap = self.isChangeMobileNumberTap
                                    view.viewModel.selectedCurrencyType = self.viewModel.selectedCurrencyType
                                    self.navigationController?.pushViewController(view, animated: true)
                                }
                            }
                        }
                        else {
                            DispatchQueue.main.async {
                                self.view.stopLoading()
                                self.showToast(message: messageShowToast)
                            }
                        }
                    }
                } else {
                    self.showToast(message: ValidationConstantStrings.networkLost)
                }
            } else {
                self.view.stopLoading()
                self.showToast(message: isValidate.errorMessage)
            }
        }else if userType == .existing && self.isChangeMobileNumberTap == false{
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
        //        else{
        //            let view = self.createView(storyboard: .main, storyboardID: .OtpNumberVC) as? OtpNumberVC
        //            let obj =   DataHoldOnSignUpProcessModel.init(strEmail: "", strNumber: self.txtNumber.text ?? "", strStatus: "", strDialCountryCode: self.lblDialCountryCode.text ?? "", strCountryCode: self.signInViewModel.strCountryCode)
        //            objAppShareData.dicToHoldDataOnSignUpModule = obj
        //            view?.isComingFromLogin = false
        //            view?.isComingFrom = self.isComingFrom
        //            view?.viewModel.number = "\(lblDialCountryCode.text ?? "") " + "-" + (self.txtNumber.text ?? "")
        //            self.navigationController?.pushViewController(view ?? UIViewController(), animated: true)
        //        }
    }
    
    @IBAction func btnChangeNumberAction(_ sender:UIButton) {
        self.btnChangeNumber.isHidden = true
        self.isChangeMobileNumberTap = true
        self.txtNumber.text = ""
        self.txtNumber.isUserInteractionEnabled = true
        self.btnSelectCountry.isUserInteractionEnabled = true
//        self.vwEmaiLabel.isHidden = false
//        self.vwEmail.isHidden = false
    }
}

// MARK: - RSCountrySelectedDelegate
extension PhoneVerificationViewController: RSCountrySelectedDelegate {
    func setIntialUiDesign() {
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        if isComingFrom == .orderSummary{
            if self.userType == .new {
                btnChangeNumber.isHidden = true
                self.txtNumber.text = ""
                self.txtNumber.isUserInteractionEnabled = true
                self.btnSelectCountry.isUserInteractionEnabled = true
                self.vwEmaiLabel.isHidden = false
                self.vwEmail.isHidden = false
            } else {
                btnChangeNumber.isHidden = false
                let number = userModel?.number
                if number?.contains("+91") ?? false{
                    self.txtNumber.text = userModel?.number?.replacingOccurrences(of: "+91", with: "")
                } else {
                    self.txtNumber.text = number
                }
                self.txtNumber.isUserInteractionEnabled = false
                self.btnSelectCountry.isUserInteractionEnabled = false
                self.vwEmaiLabel.isHidden = true
                self.vwEmail.isHidden = true
            }
        } else {
            btnChangeNumber.isHidden = true
            self.txtNumber.text = ""
            self.txtNumber.isUserInteractionEnabled = false
            self.btnSelectCountry.isUserInteractionEnabled = false
            self.vwEmaiLabel.isHidden = true
            self.vwEmail.isHidden = true
        }
        self.txtNumber.addDoneButtonOnKeyboard()
        // Defoult Country
        // UI Changes---
        self.imgCountry.image = nil
        if self.imgCountry.image == nil {
            var str = ""
            var arr = signInViewModel.RScountriesModel.filter({$0.dialCode == str})
            
            if userModel?.strDialCountryCode != nil && userModel?.strDialCountryCode != ""{
                str = userModel?.strDialCountryCode ?? ""
                arr = signInViewModel.RScountriesModel.filter({$0.dialCode == str})
                
                if !arr.indices.contains(0) {
                    str = NSLocale.current.regionCode ?? ""
                    arr = signInViewModel.RScountriesModel.filter({$0.countryCode == str})
                }
            } else {
                str = NSLocale.current.regionCode ?? ""
                arr = signInViewModel.RScountriesModel.filter({$0.countryCode == str})
            }
           
            self.lblDialCountryCode.text = "+91"
            var imagePath = "CountryPicker.bundle/\(str).png"
            
            if arr.count == 2{
                arr.removeAll { country in
                    country.countryCode != (NSLocale.current.regionCode ?? "")
                }
            }
            
            if let flagImg = UIImage(named: imagePath) {
                self.imgCountry.image = flagImg
            } else {
                if arr.indices.contains(0) {
                    str = arr[0].countryCode
                    imagePath = "CountryPicker.bundle/\(str).png"
                    self.imgCountry.image = UIImage(named: imagePath)
                }
            }
            if !arr.isEmpty {
                let country = arr[0]
                self.signInViewModel.strCountryDialCode = country.dialCode
                self.lblDialCountryCode.text = country.dialCode
                self.signInViewModel.strCountryCode = country.countryCode
                self.signInViewModel.strCountryName = country.countryName
                self.lblDialCountryCode.text = country.dialCode
                self.signInViewModel.strCountryCode = country.countryCode
                let imagePath = "CountryPicker.bundle/\( country.countryCode).png"
                self.imgCountry.image = UIImage(named: imagePath)
            }
        } else {
            // noting to do
        }
    }
    func collectCountries() {
        for country in signInViewModel.countries {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            signInViewModel.RScountriesModel.append(CountryInfo(countryCode: code, dialCode: dailcode, countryName: name))
        }
    }
    func RScountrySelected(countrySelected country: CountryInfo) {
        let imagePath = "CountryPicker.bundle/\(country.countryCode).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.signInViewModel.strCountryDialCode = country.dialCode
        self.lblDialCountryCode.text = country.dialCode
        self.signInViewModel.strCountryCode = country.countryCode
        self.signInViewModel.strCountryName = country.countryName
        self.txtNumber.becomeFirstResponder()
    }
}
// MARK: - UITextFieldDelegate
extension PhoneVerificationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  textField == self.txtNumber {
            self.txtNumber.resignFirstResponder()
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let charsLimit = 12
        
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        if textField == txtNumber {
            signInViewModel.number = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            return newLength <= charsLimit
        }
        return true
    }
}
// MARK: - NavigationBarViewDelegate
extension PhoneVerificationViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
