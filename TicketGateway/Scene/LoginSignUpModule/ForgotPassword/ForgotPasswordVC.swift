//
//  ForgotPasswordVC.swift
//  TicketGateway
//
//  Created by Apple on 13/04/23.
// swiftlint: disable line_length
// swiftlint: disable force_cast

import UIKit
import SVProgressHUD
import TweeTextField

class ForgotPasswordVC: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var txtEmail: TweeAttributedTextField!
    @IBOutlet weak var lblHeadingDescription: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
// MARK: - Variable
    let viewModel = ForgotPasswordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}
// MARK: - Functions
extension ForgotPasswordVC {
    private func setup() {
        [self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        txtEmail.delegate = self
        // Error message label not required as we are showing toast on continue button
//        txtEmail.addTarget(self, action: #selector(textFldErrorMsg(_:)), for: .allEditingEvents)
       self.btnContinue.setTitles(text: TITLE_CONTINUE, font: .systemFont(ofSize: 14), tintColour: .black)
        self.btnContinue.setImage(UIImage(named: RIGHT_ARROW_ICON), for: .normal)
        self.navigationView.lblTitle.text = FORGOT_PASSWORD
        self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.delegateBarAction = self
        self.lblHeadingDescription.text = DONT_WORRY
        self.lblEmail.attributedText = getAttributedTextAction(attributedText: "*", firstString: "Email ", lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve), attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
    }
}
// MARK: - Actions
extension ForgotPasswordVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
    func btnContinueAction() {
        let isValidate = viewModel.validateUserInput
        if isValidate.isValid {
            if Reachability.isConnectedToNetwork() {
                SVProgressHUD.show()
                viewModel.forgotPasswordAPI { isTrue, messageShowToast in
                    if isTrue == true {
                        SVProgressHUD.dismiss()
                        DispatchQueue.main.async {
                           // self.showToast(message: EMAIL_LINK_SENT)
                            let vc = self.createView(storyboard: .main, storyboardID: .EmailSentVC) as! EmailSentVC
                            vc.strForEmail = self.txtEmail.text ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                for controller in self.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: LoginVC.self) {
                                        self.navigationController!.popToViewController(controller, animated: true)
                                        break
                                    }
                                }
                            //self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            self.showToast(message: messageShowToast)
                        }
                    }
                }
            } else {
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        } else {
            self.showToast(message: isValidate.errormessage)
        }
    }
}

// MARK: - UITextFieldDelegate
extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  textField == self.txtEmail {
            self.txtEmail.resignFirstResponder()
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        if textField == txtEmail {
            viewModel.email = text.replacingCharacters(in: textRange, with: string)
        }
        return true
    }
}
// MARK: -
extension ForgotPasswordVC {
    
        @objc func textFldErrorMsg(_ sender: UITextField) {
            if txtEmail.text == "" {
                txtEmail.infoTextColor = .red
                txtEmail.infoFontSize = 12.0
                txtEmail.showInfo("Enter your email", animated: true)
            } else {
                txtEmail.infoTextColor = .clear
            }
        }
    
}







// MARK: - NavigationBarViewDelegate
extension ForgotPasswordVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
