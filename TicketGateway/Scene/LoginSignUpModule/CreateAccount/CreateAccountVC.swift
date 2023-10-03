//
//  CreateAccountVC.swift
//  TicketGateway
//
//  Created by Apple on 13/04/23.
// swiftlint: disable line_length
// swiftlint: disable force_cast

import UIKit
import SVProgressHUD
import TweeTextField
class CreateAccountVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var btnEyePassword: UIButton!
    @IBOutlet weak var btnEyeCPassword: UIButton!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var vwNumber: UIView!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
    @IBOutlet weak var btnSelectCountry: UIButton!
    @IBOutlet weak var lblErrFullName: UILabel!
    @IBOutlet weak var lblErrMobileNumber: UILabel!
    @IBOutlet weak var lblErrPassword: UILabel!
    @IBOutlet weak var lblErrConfirmPassword: UILabel!
    // MARK: - Variable
    let viewModel = CreateAccountViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // NOTE:- Error message label not required as we are showing toast on continue button
//        [txtFullName, txtPassword, txtConfirmPassword, txtMobileNumber].forEach {
//            $0?.addTarget(self, action: #selector(textFieldErrorMsg(_:)), for: .allEditingEvents)
//        }
    }
}
// MARK: - Functions
extension CreateAccountVC {
    private func setup() {
        self.viewModel.countries = self.jsonSerial()
        self.collectCountries()
        [self.btnContinue, self.btnSelectCountry, self.btnEyePassword, self.btnEyeCPassword].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.txtFullName.delegate = self
        self.txtMobileNumber.delegate = self
        self.txtEmailAddress.delegate = self
        self.txtPassword.delegate = self
        self.txtConfirmPassword.delegate = self
        btnContinue.setTitles(text: CREATE_ACCOUNT, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        navigationView.lblTitle.text = CREATE_ACCOUNT
        navigationView.btnBack.isHidden = false
        navigationView.delegateBarAction = self
        self.txtEmailAddress.text =  objAppShareData.dicToHoldDataOnSignUpModule?.strEmail
        self.viewModel.emailAddress = objAppShareData.dicToHoldDataOnSignUpModule?.strEmail ?? ""
        self.btnEyePassword.setImage(UIImage(named: EYE_CLOSE), for: .normal)
        self.btnEyeCPassword.setImage(UIImage(named: EYE_CLOSE), for: .normal)
        self.txtPassword.isSecureTextEntry = true
        self.txtConfirmPassword.isSecureTextEntry = true
        self.lblFullName.text = Full_Name
        self.lblMobileNumber.text = MOBILE_NUMBER
        self.lblEmailAddress.text = EMAIL_ADDRESS
        self.lblPassword.text = PASSWORD
        self.lblConfirmPassword.text = CONFIRM_PASSWORD
        self.setIntialUiDesign()
    }
}
// MARK: - Actions
extension CreateAccountVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case btnEyeCPassword:
            self.btnEyeCPasswordAction()
        case btnEyePassword:
            self.btnEyePasswordAction()
        case btnSelectCountry:
            self.btnSelectCountryAction()
        default:
            break
        }
    }
    func btnEyePasswordAction() {
        if self.txtPassword.isSecureTextEntry == false {
            self.btnEyePassword.setImage(UIImage(named: EYE_CLOSE), for: .normal)
            self.txtPassword.isSecureTextEntry = true
        } else {
            self.btnEyePassword.setImage(UIImage(named: EYE_OPEN), for: .normal)
            self.txtPassword.isSecureTextEntry = false
        }
    }
    func btnEyeCPasswordAction() {
        if self.txtConfirmPassword.isSecureTextEntry == false {
            self.btnEyeCPassword.setImage(UIImage(named: EYE_CLOSE), for: .normal)
            self.txtConfirmPassword.isSecureTextEntry = true
        } else {
            self.btnEyeCPassword.setImage(UIImage(named: EYE_OPEN), for: .normal)
            self.txtConfirmPassword.isSecureTextEntry = false
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
    func btnContinueAction() {
        let isValidate = viewModel.validateUserInput
        if isValidate.isValid {
            if Reachability.isConnectedToNetwork() {
                self.view.showLoading(centreToView: self.view)
                viewModel.createAccountAPI(complition: { isTrue, messageShowToast in
                    if isTrue == true {
                        DispatchQueue.main.async {
                            //objSceneDelegate.showTabBar()
                            self.view.stopLoading()
                            objSceneDelegate.showLogin()
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
        } else {
            self.view.stopLoading()
            self.showToast(message: isValidate.errorMessage)
        }
    }
}
// MARK: - UITextFieldDelegate
extension CreateAccountVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtFullName {
            self.txtMobileNumber.becomeFirstResponder()
        } else if textField == self.txtMobileNumber {
            self.txtPassword.becomeFirstResponder()
        } else if textField == self.txtEmailAddress {
            self.txtPassword.becomeFirstResponder()
        } else if textField == self.txtPassword {
            self.txtConfirmPassword.becomeFirstResponder()
        } else if textField == self.txtConfirmPassword {
            self.txtConfirmPassword.resignFirstResponder()
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        let mobileNoLimit = 11
        if textField == txtFullName {
            viewModel.fullName = text.replacingCharacters(in: textRange, with: string)
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
        } else if textField == txtEmailAddress {
            viewModel.emailAddress = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtPassword {
            var str = "\(text.replacingCharacters(in: textRange, with: string))"
            if str == " "{
                return false
            }else{
                viewModel.password = text.replacingCharacters(in: textRange, with: string)
                return true
            }
        } else if textField == txtConfirmPassword {
            var str = "\(text.replacingCharacters(in: textRange, with: string))"
            if str == " "{
                return false
            }else{
                viewModel.confimePassword = text.replacingCharacters(in: textRange, with: string)
                return true
            }
        }
        return true
    }
}
// MARK: - NavigationBarViewDelegate
extension CreateAccountVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.viewControllers.forEach({ controller in
            if controller is SignUpVC{
                self.navigationController?.popToViewController(controller, animated: false)
            }
        })
        
    }
}

// MARK: -  Country Code
extension CreateAccountVC: RSCountrySelectedDelegate  {
    func setIntialUiDesign() {
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
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
            
            let imagePath = "CountryPicker.bundle/\(str ?? "IN").png"
            self.imgCountry.image = UIImage(named: imagePath)
            self.lblDialCountryCode.text = "+91"
            
            if !arr.isEmpty {
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
// MARK: -
extension CreateAccountVC {
    
    @objc func textFieldErrorMsg(_ sender: UITextField) {
        switch sender {
        case txtFullName:
            self.fullNameErrorMsg()
        case txtPassword:
            self.passwordErrorMsg()
        case txtConfirmPassword:
            self.confirmErrorMsg()
        case txtMobileNumber:
            self.mobileErrMsg()
        default:
            break
        }
     
    }
    
    func fullNameErrorMsg() {
         if txtFullName.text == "" {
             lblErrFullName.isHidden = false
        } else {
            lblErrFullName.isHidden = true
        }
    }
   
    
    func passwordErrorMsg() {
        if txtPassword.text == "" {
            lblErrPassword.isHidden = false
        } else {
            lblErrPassword.isHidden = true
        }
    }
    
    func confirmErrorMsg() {
        if txtConfirmPassword.text == "" {
            lblConfirmPassword.isHidden = false
            
        } else {
            lblConfirmPassword.isHidden = true
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
