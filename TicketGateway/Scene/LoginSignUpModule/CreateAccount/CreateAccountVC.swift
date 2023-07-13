//
//  CreateAccountVC.swift
//  TicketGateway
//
//  Created by Apple on 13/04/23.
//

import UIKit
import SVProgressHUD

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
   
  // MARK: - Variable
    let viewModel = CreateAccountViewModel()
   
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
 
  }
}
// MARK: - Functions
extension CreateAccountVC {
  private func setup() {
      self.viewModel.countries = self.jsonSerial()
      self.collectCountries()
      [self.btnContinue, self.btnSelectCountry,self.btnEyePassword,self.btnEyeCPassword].forEach {
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
    self.txtEmailAddress.text =  objAppShareData.DicToHoldDataOnSignUpModule?.strEmail
    self.viewModel.emailAddress = objAppShareData.DicToHoldDataOnSignUpModule?.strEmail ?? ""
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
    case btnSelectCountry : self.btnSelectCountryAction()
    default:
      break
    }
  }
    
    func btnEyePasswordAction(){
        if self.txtPassword.isSecureTextEntry == false{
            self.btnEyePassword.setImage(UIImage(named: EYE_CLOSE), for: .normal)
            self.txtPassword.isSecureTextEntry = true
        }
        else {
            self.btnEyePassword.setImage(UIImage(named: EYE_OPEN), for: .normal)
            self.txtPassword.isSecureTextEntry = false
        }
    }
    func btnEyeCPasswordAction(){
        if self.txtConfirmPassword.isSecureTextEntry == false{
            self.btnEyeCPassword.setImage(UIImage(named: EYE_CLOSE), for: .normal)
            self.txtConfirmPassword.isSecureTextEntry = true
        }
        else {
            self.btnEyeCPassword.setImage(UIImage(named: EYE_OPEN), for: .normal)
            self.txtConfirmPassword.isSecureTextEntry = false
        }
    }
    func btnSelectCountryAction(){
        self.view.endEditing(true)
         let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as! RSCountryPickerController
        sb.RScountryDelegate = self
        sb.strCheckCountry = self.viewModel.strCountryName
        sb.modalPresentationStyle = .fullScreen
        self.navigationController?.present(sb, animated: true, completion: nil)
    }
  func btnContinueAction() {
    let isValidate = viewModel.ValidateUserInput
      if isValidate.isValid {
          if Reachability.isConnectedToNetwork(){
              SVProgressHUD.show()
              viewModel.createAccountAPI(complition: { isTrue, messageShowToast in
                  if isTrue == true {
                      SVProgressHUD.dismiss()
                      DispatchQueue.main.async {
                          objSceneDelegate.showTabBar()
                      }
                  } else {
                      DispatchQueue.main.async {
                          SVProgressHUD.dismiss()
                          self.showToast(message: messageShowToast)
                      }
                  }
              })
          } else {
              DispatchQueue.main.async {
                  SVProgressHUD.dismiss()
                  self.showToast(message: ValidationConstantStrings.networkLost)
              }
          }
      }else {
          SVProgressHUD.dismiss()
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
    if textField == txtFullName {
      viewModel.fullName = text.replacingCharacters(in: textRange, with: string)
    } else if textField == txtMobileNumber {
        viewModel.mobileNumber = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
    }else if textField == txtEmailAddress {
      viewModel.emailAddress = text.replacingCharacters(in: textRange, with: string)
    } else if textField == txtPassword{
      viewModel.password = text.replacingCharacters(in: textRange, with: string)
    }else if textField == txtConfirmPassword{
      viewModel.confimePassword = text.replacingCharacters(in: textRange, with: string)
    }
    return true
  }
}
// MARK: - NavigationBarViewDelegate
extension CreateAccountVC : NavigationBarViewDelegate {
  func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}

// MARK: -  Country Code
extension CreateAccountVC :RSCountrySelectedDelegate  {
    func setIntialUiDesign()
    {
        //Defoult Country
         //UI Changes---
        self.imgCountry.image = nil
        if self.imgCountry.image == nil
        {
            let str = NSLocale.current.regionCode
            let imagePath = "CountryPicker.bundle/\(str ?? "IN").png"
            self.imgCountry.image = UIImage(named: imagePath)
            self.lblDialCountryCode.text = "+91"
            let arr = viewModel.RScountriesModel.filter({$0.dial_code == str})
            
            if arr.count>0{
                let country = arr[0]
                viewModel.strCountryDialCode = country.dial_code
                 self.lblDialCountryCode.text = country.dial_code
                self.viewModel.strCountryCode = country.country_code
                self.viewModel.strCountryName = country.country_name
                self.lblDialCountryCode.text = country.dial_code
                self.viewModel.strCountryCode = country.country_code
                let imagePath = "CountryPicker.bundle/\( country.country_code).png"
                self.imgCountry.image = UIImage(named: imagePath)
            }
        }
        else{
            //noting to do
        }
    }
    
    func collectCountries() {
        for country in viewModel.countries  {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            viewModel.RScountriesModel.append(CountryInfo(country_code:code,dial_code:dailcode, country_name:name))
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
    }
}


















