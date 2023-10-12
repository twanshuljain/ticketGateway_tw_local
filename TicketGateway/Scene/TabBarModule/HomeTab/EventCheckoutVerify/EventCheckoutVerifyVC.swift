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
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
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

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setup()
        
    }

}

//// MARK: - Functions
//extension EventCheckoutVerifyVC {
//    private func setup() {
//        [self.btnContinue, self.btnGoBack].forEach {
//            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
//        }
//        self.txtFirstName.delegate = self
//        self.txtLastName.delegate = self
//        self.txtMobileNumber.delegate = self
//        self.txtEmailAddress.delegate = self
//        btnContinue.setTitles(text: CREATE_ACCOUNT, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
//        navigationView.lblTitle.text = CREATE_ACCOUNT
//        navigationView.btnBack.isHidden = false
//        navigationView.delegateBarAction = self
//        self.txtEmailAddress.text =  objAppShareData.dicToHoldDataOnSignUpModule?.strEmail
//        //self.viewModel.emailAddress = objAppShareData.dicToHoldDataOnSignUpModule?.strEmail ?? ""
//        self.lblFirstName.text = First_Name
//        self.lblErrLastName.text = First_Name
//        self.lblMobileNumber.text = MOBILE_NUMBER
//        self.lblEmailAddress.text = EMAIL_ADDRESS
//        //self.setIntialUiDesign()
//    }
//
//    @objc func textFieldErrorMsg(_ sender: UITextField) {
//        switch sender {
//        case txtFirstName:
//            self.firstNameErrorMsg()
//        case txtLastName:
//            self.lastNameErrorMsg()
//        case txtMobileNumber:
//            self.mobileErrMsg()
//        default:
//            break
//        }
//
//    }
//
//    func firstNameErrorMsg() {
//         if txtFirstName.text == "" {
//             lblErrFirstName.isHidden = falses
//        } else {
//            lblErrFirstName.isHidden = true
//        }
//    }
//
//    func lastNameErrorMsg() {
//         if txtLastName.text == "" {
//             lblErrLastName.isHidden = false
//        } else {
//            lblErrLastName.isHidden = true
//        }
//    }
//
//    func mobileErrMsg() {
//        if txtMobileNumber.text == "" {
//            lblErrMobileNumber.isHidden = false
//        } else {
//            lblErrMobileNumber.isHidden = true
//        }
//    }
//}

//// MARK: - Actions
//extension EventCheckoutVerifyVC {
//    @objc func buttonPressed(_ sender: UIButton) {
//        switch sender {
//        case btnContinue:
//            self.btnContinueAction()
//        case btnGoBack:
//            self.navigationController?.popViewController(animated: false)
//        case btnSelectCountry:
//            self.btnSelectCountryAction()
//        default:
//            break
//        }
//    }
//    func btnEyePasswordAction() {
//        if self.txtPassword.isSecureTextEntry == false {
//            self.btnEyePassword.setImage(UIImage(named: EYE_CLOSE), for: .normal)
//            self.txtPassword.isSecureTextEntry = true
//        } else {
//            self.btnEyePassword.setImage(UIImage(named: EYE_OPEN), for: .normal)
//            self.txtPassword.isSecureTextEntry = false
//        }
//    }
//    func btnEyeCPasswordAction() {
//        if self.txtConfirmPassword.isSecureTextEntry == false {
//            self.btnEyeCPassword.setImage(UIImage(named: EYE_CLOSE), for: .normal)
//            self.txtConfirmPassword.isSecureTextEntry = true
//        } else {
//            self.btnEyeCPassword.setImage(UIImage(named: EYE_OPEN), for: .normal)
//            self.txtConfirmPassword.isSecureTextEntry = false
//        }
//    }
//    func btnSelectCountryAction() {
//        self.view.endEditing(true)
//        let strybrd = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as! RSCountryPickerController
//        strybrd.RScountryDelegate = self
//        strybrd.strCheckCountry = self.viewModel.strCountryName
//        strybrd.modalPresentationStyle = .fullScreen
//        self.navigationController?.present(strybrd, animated: true, completion: nil)
//    }
//    func btnContinueAction() {
//        let isValidate = viewModel.validateUserInput
//        if isValidate.isValid {
//            if Reachability.isConnectedToNetwork() {
//                self.view.showLoading(centreToView: self.view)
//                viewModel.createAccountAPI(complition: { isTrue, messageShowToast in
//                    if isTrue == true {
//                        DispatchQueue.main.async {
//                            //objSceneDelegate.showTabBar()
//                            self.view.stopLoading()
//                            objSceneDelegate.showLogin()
//                        }
//                    } else {
//                        DispatchQueue.main.async {
//                            self.view.stopLoading()
//                            self.showToast(message: messageShowToast)
//                        }
//                    }
//                })
//            } else {
//                DispatchQueue.main.async {
//                    self.view.stopLoading()
//                    self.showToast(message: ValidationConstantStrings.networkLost)
//                }
//            }
//        } else {
//            self.view.stopLoading()
//            self.showToast(message: isValidate.errorMessage)
//        }
//    }
//}
//// MARK: - UITextFieldDelegate
//extension EventCheckoutVerifyVC: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == self.txtFullName {
//            self.txtMobileNumber.becomeFirstResponder()
//        } else if textField == self.txtMobileNumber {
//            self.txtPassword.becomeFirstResponder()
//        } else if textField == self.txtEmailAddress {
//            self.txtPassword.becomeFirstResponder()
//        } else if textField == self.txtPassword {
//            self.txtConfirmPassword.becomeFirstResponder()
//        } else if textField == self.txtConfirmPassword {
//            self.txtConfirmPassword.resignFirstResponder()
//        }
//        return false
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
//        let mobileNoLimit = 11
//        if textField == txtFullName {
//            viewModel.fullName = text.replacingCharacters(in: textRange, with: string)
//        } else if textField == txtMobileNumber {
//            // viewModel.mobileNumber = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
//            let startingLength = textField.text?.count ?? 0
//            let lengthToAdd = string.count
//            let lengthToReplace = range.length
//            let newLength = startingLength + lengthToAdd - lengthToReplace
//            let valid = newLength <= mobileNoLimit
//            if valid{
//                viewModel.mobileNumber = "\(text.replacingCharacters(in: textRange, with: string))"
//            }
//            return valid
//        } else if textField == txtEmailAddress {
//            viewModel.emailAddress = text.replacingCharacters(in: textRange, with: string)
//        } else if textField == txtPassword {
//            var str = "\(text.replacingCharacters(in: textRange, with: string))"
//            if str == " "{
//                return false
//            }else{
//                viewModel.password = text.replacingCharacters(in: textRange, with: string)
//                return true
//            }
//        } else if textField == txtConfirmPassword {
//            var str = "\(text.replacingCharacters(in: textRange, with: string))"
//            if str == " "{
//                return false
//            }else{
//                viewModel.confimePassword = text.replacingCharacters(in: textRange, with: string)
//                return true
//            }
//        }
//        return true
//    }
//}

