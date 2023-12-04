//
//  LoginVC.swift
//  TicketGateway
//
//  Created by Apple  on 11/04/23.
//  swiftlint: disable line_length
//  swiftlint: disable cyclomatic_complexity

import UIKit
import SVProgressHUD
import TweeTextField
class LoginVC: UIViewController{
  //MARK: - Outlets
    @IBOutlet weak var txtEmail: TweeAttributedTextField!
    @IBOutlet weak var txtPassword: TweeAttributedTextField!
    @IBOutlet weak var txtNumber: TweeAttributedTextField!
    @IBOutlet weak var vwFaceBook: UIView!
    @IBOutlet weak var vwGoogle: UIView!
    @IBOutlet weak var vwApple: UIView!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var vwNumber: UIView!
    @IBOutlet weak var vwNumberHeading: UIView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var btnLogin: CustomButtonGradiant!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnNumber: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var btnFaceBook: UIButton!
    @IBOutlet weak var btnGmail: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnSelectCountry: UIButton!
    @IBOutlet weak var imgNumber: UIImageView!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var lblSignIn: UILabel!
    @IBOutlet weak var lblSignInWith: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblPleaseEnterMobileNumber: UILabel!
    @IBOutlet weak var lblDontHaveAnAccount: UILabel!
    @IBOutlet weak var vwBtnSkipView: UIView!
    // MARK: - Variable
    var viewModel = SignInViewModel()
    let viewModelSocialSignIN = SocialSignInVC()
    var profileViewModel: ManageEventProfileViewModel = ManageEventProfileViewModel()
    var isComingFrom: IsComingFrom  = .Login
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SignInViewModel(loginVC: self)
        self.setup()
        self.setIntialUiDesign()
        self.setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
// MARK: - Functions
extension LoginVC {
    // Set UI for label and buttons
    func setUI() {
        self.vwBtnSkipView.isHidden = true
        self.lblSignIn.text = LBL_SIGN_IN
        self.lblSignInWith.text = LBL_OR_SIGNIN_WITH
        self.lblEmail.text = EMAIL
        self.lblMobileNumber.text = MOBILE_NUMBER
        self.lblPleaseEnterMobileNumber.text = PLEASE_ENTER_YOUR_MOBILE_NUMBER_DDESCRIPTION
        self.lblDontHaveAnAccount.text = DONT_HAVE_AN_ACCOUNT
        
        
    }
    // Set up for buttons actions
    private func setup() {
        self.viewModel.countries = self.jsonSerial()
        self.collectCountries()
        [self.btnEmail, self.btnNumber, self.btnLogin, self.btnSignUp, self.btnForgotPassword, self.btnSkip, self.btnSelectCountry, self.btnEye, self.btnGmail, self.btnFaceBook, self.btnApple].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.imgCountry.image = nil
        self.txtEmail.delegate = self
        self.txtNumber.delegate = self
        self.txtPassword.delegate = self
        self.vwNumber.layer.cornerRadius = 5
        self.vwNumber.layer.borderWidth = 0.5
        self.vwNumber.layer.borderColor = UIColor.lightGray.cgColor
        self.isFromNumberOrEmailUI()
        self.btnLogin.setTitles(text: TITLE_LOGIN, font: .systemFont(ofSize: 14), tintColour: .black)
        self.btnEye.setImage(UIImage(named: EYE_CLOSE), for: .normal)
        self.txtPassword.isSecureTextEntry = true
        self.btnLogin.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
    }
    // Apply validations for email and phone number fields
    func isFromNumberOrEmailUI() {
        if viewModel.isFromNumberOrEmail == true {
            self.vwEmail.isHidden = false
            self.vwPassword.isHidden = false
            self.vwNumber.isHidden = true
            self.vwNumberHeading.isHidden = true
            self.imgEmail.image = UIImage(named: ACTIVE_ICON)
            self.imgNumber.image = UIImage(named: UNACTIVE_ICON)
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            self.viewModel.isForEmail = true
        } else {
            self.vwEmail.isHidden = true
            self.vwPassword.isHidden = true
            self.vwNumber.isHidden = false
            self.vwNumberHeading.isHidden = false
            self.imgEmail.image = UIImage(named: UNACTIVE_ICON)
            self.imgNumber.image = UIImage(named: ACTIVE_ICON)
            self.txtNumber.text = ""
            self.viewModel.isForEmail = false
        }
    }
    
    // Get User Profile API Calling
    func getUserProfileData() {
        if Reachability.isConnectedToNetwork() {
            self.profileViewModel.getUserProfileData(complition: { isTrue, message in
                DispatchQueue.main.async {
                    objSceneDelegate.showTabBar()
                }
            })
        } else {
            DispatchQueue.main.async {
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
}
// MARK: - Actions
extension LoginVC {
    // Actions for UIButton
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnLogin:
            self.btnLoginAction()
        case btnEmail:
            self.btnEmailAction()
        case btnSignUp:
            self.btnSignUpAction()
        case btnForgotPassword:
            self.btnForgotPasswordAction()
        case btnNumber:
            self.btnNumberAction()
        case btnSkip:
            self.btnSkipAction()
        case btnSelectCountry:
            self.btnSelectCountryAction()
        case btnEye:
            self.btnEyeAction()
        case btnGmail:
            self.btnGoogleAction()
        case btnFaceBook:
            self.btnFaceBookAction()
        case btnApple:
            self.btnAppleAction()
        default:
            break
        }
    }
    // Handling password hide and show from eye button
    func btnEyeAction() {
        if self.txtPassword.isSecureTextEntry == false {
            self.btnEye.setImage(UIImage(named: EYE_CLOSE), for: .normal)
            self.txtPassword.isSecureTextEntry = true
        } else {
            self.btnEye.setImage(UIImage(named: EYE_OPEN), for: .normal)
            self.txtPassword.isSecureTextEntry = false
        }
    }
    func btnSkipAction() {
        UserDefaultManager.share.guestUserLogin(value: true, key: .isGuestLogin)
        objSceneDelegate.showTabBar()
    }
    // Checking login button validation and called Login API 
    func btnLoginAction() {
        print("Login Tapped")
        let isValidate = viewModel.validateUserInput
        if isValidate.isValid {
            if Reachability.isConnectedToNetwork() {
                self.view.showLoading(centreToView: self.view)
                viewModel.signInAPI { isTrue, messageShowToast in
                    if isTrue == true {
                        DispatchQueue.main.async { [self] in
                            self.view.stopLoading()
                            if self.viewModel.isFromNumberOrEmail == true {
                                self.getUserProfileData()
                               // objSceneDelegate.showTabBar()
                            } else {
                                let view = self.createView(storyboard: .main, storyboardID: .OtpNumberVC) as? OtpNumberVC
                                let obj =   DataHoldOnSignUpProcessModel.init(strEmail: self.txtEmail.text ?? "", strNumber:   self.txtNumber.text ?? "" , strStatus: "", strDialCountryCode: self.lblDialCountryCode.text!, strCountryCode: self.viewModel.strCountryCode)
                                 objAppShareData.dicToHoldDataOnSignUpModule = obj
                                view?.isComingFromLogin = true
                                view?.isComingFrom = self.isComingFrom
                                view?.viewModel.number = "\(lblDialCountryCode.text ?? "") " + "-" + (self.txtNumber.text ?? "")
                                self.navigationController?.pushViewController(view ?? UIViewController(), animated: true)
                            }
                        }
                    } else {
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
            DispatchQueue.main.async {
               self.showToast(message: isValidate.errormessage)
            }
        }
      }

    func btnSignUpAction() {
        if  self.viewModel.isFromWelcomeScreen {
            let view = self.createView(storyboard: .main, storyboardID: .SignUpVC)
            let viewC = view as? SignUpVC
            viewC?.viewModel.isFromWelcomeScreen = false
            self.navigationController?.pushViewController(view, animated: true)
        } else {
            self.viewModel.isFromWelcomeScreen = false
            let view = self.createView(storyboard: .main, storyboardID: .SignUpVC)
            self.navigationController?.pushViewController(view, animated: true)
          //  self.navigationController?.popViewController(animated: true)
        }
    }
    func btnEmailAction() {
        self.viewModel.isFromNumberOrEmail = true
        self.isFromNumberOrEmailUI()
    }
    func btnNumberAction() {
        self.viewModel.isFromNumberOrEmail = false
        self.isFromNumberOrEmailUI()
    }
    func btnForgotPasswordAction() {
        let view = self.createView(storyboard: .main, storyboardID: .ForgotPasswordVC)
        self.navigationController?.pushViewController(view, animated: true)
    }
    func btnSelectCountryAction() {
        self.view.endEditing(true)
         let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as? RSCountryPickerController
        sb?.RScountryDelegate = self
        sb?.strCheckCountry = self.viewModel.strCountryName
        sb?.modalPresentationStyle = .fullScreen
        self.navigationController?.present(sb ?? UIViewController(), animated: true, completion: nil)
    }
    func btnAppleAction() {
        self.viewModelSocialSignIN.funcAppleLoginIntegration(uiviewController: self)
    }
    func btnGoogleAction() {
        viewModelSocialSignIN.funGoogleSignIn(uiviewController: self)
    }
    func btnFaceBookAction() {
        viewModelSocialSignIN.funcFaceBookSignIn(uiviewController: self)
    }
}
// MARK: - UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if viewModel.isFromNumberOrEmail == true {
            if textField == self.txtEmail {
                self.txtPassword.becomeFirstResponder()
            } else if textField == self.txtPassword {
                self.txtPassword.resignFirstResponder()
            }
        } else {
            if  textField == self.txtNumber {
                self.txtNumber.resignFirstResponder()
            }
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        if textField == txtEmail {
            viewModel.email = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtPassword {
            viewModel.password = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtNumber {
            //viewModel.number = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
            viewModel.number = text.replacingCharacters(in: textRange, with: string)
        }
        return true
    }
}

// MARK: - Country Code
extension LoginVC: RSCountrySelectedDelegate {
    func setIntialUiDesign() {
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        self.txtNumber.addDoneButtonOnKeyboard()
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
     //       let arr = viewModel.RScountriesModel.filter({$0.country_code == str})
            
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
            viewModel.RScountriesModel.append(CountryInfo(country_code:code, dial_code:dailcode, country_name:name))
        }
    }
    func RScountrySelected(countrySelected country: CountryInfo) {
        let imagePath = "CountryPicker.bundle/\(country.country_code).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.viewModel.strCountryDialCode = country.dial_code
        self.lblDialCountryCode.text = country.dial_code
        self.viewModel.strCountryCode = country.country_code
        self.viewModel.strCountryName = country.country_name
        self.txtNumber.becomeFirstResponder()
    }
}
//MARK: -
extension LoginVC {
    
    @objc func textFieldErrorMsg(_ sender: UITextField) {
        switch sender {
        case txtEmail:
            self.emailError()
        case txtPassword:
            self.passwordError()
        case txtNumber:
            self.numberError()
        default:
            break
        }
     
    }
    
    
    func emailError() {
        if txtEmail.text == "" {
            txtEmail.infoTextColor = .red
            txtEmail.infoFontSize = 12.0
            txtEmail.showInfo("Enter your email", animated: true)
        } else {
            txtEmail.infoTextColor = .clear
        }
    }
   
    
    func passwordError() {
        if txtPassword.text == "" {
            txtPassword.infoTextColor = .red
            txtPassword.infoFontSize = 12.0
            txtPassword.showInfo("Enter your password", animated: true)
        } else {
            txtPassword.infoTextColor = .clear
        }
    }
  
    func numberError() {
        if txtNumber.text == "" {
            txtNumber.infoTextColor = .clear
            txtNumber.infoFontSize = 12.0
            txtNumber.showInfo("Enter your mobile number", animated: true)
        } else {
            txtNumber.infoTextColor = .clear
        }
    }
  
}
