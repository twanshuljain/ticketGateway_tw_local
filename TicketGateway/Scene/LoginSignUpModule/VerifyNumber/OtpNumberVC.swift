//
//  OtpSignInVC.swift
//  TicketGateway
//
//  Created by Apple on 12/04/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name


import UIKit
import SVProgressHUD

class OtpNumberVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var txtOtp1: UITextField!
    @IBOutlet weak var txtOtp2: UITextField!
    @IBOutlet weak var txtOtp3: UITextField!
    @IBOutlet weak var txtOtp4: UITextField!
    @IBOutlet weak var lblSentVerification: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblApplyAuto: UILabel!
    @IBOutlet weak var lblReceiveOtp: UILabel!
    @IBOutlet weak var vwResend: UIView!
    @IBOutlet weak var btnResendOtp: UIButton!
    
    // MARK: - Variable
    let viewModel =  NumberVerifyViewModel()
    let viewModelResendOtp = SignInViewModel()
    var isComingFromLogin = true
    var userType: UserType  = .existing
    var otpVerified: ((Bool, String) -> Void)?
    var isComingFrom: IsComingFrom  = .Login
    var isChangeMobileNumberTap = false
   
     override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
         self.setText()

     }
}

// MARK: - Functions
extension OtpNumberVC {
    
    func setText() {
        lblSentVerification.text = SENT_VERIFICATION_CODE_TO
        lblApplyAuto.text = AUTO_APPLY
        lblReceiveOtp.attributedText = getAttributedOtpStr(str: "You will receive OTP in 00:00s")
    }
    
    
    
    
    private func setup() {
        [self.btnContinue,self.btnResendOtp].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        [self.txtOtp1,self.txtOtp2,self.txtOtp3,self.txtOtp4].forEach{$0?.delegate = self}
        [self.txtOtp1,self.txtOtp2,self.txtOtp3,self.txtOtp4].forEach{$0?.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)}
        navigationView.delegateBarAction = self
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        navigationView.lblTitle.text = OTP_VERIFICATION
        navigationView.btnBack.isHidden = false
        navigationView.delegateBarAction = self
        
        if viewModel.number != "" {
          self.lblMobileNumber.text = viewModel.number
        }
        self.startTimer()
        self.vwResend.isHidden = true
    }
    
//    private func setViewTextFields() {
//        [txtOtp1, txtOtp2, txtOtp3, txtOtp4].forEach {
//            $0?.delegate = self
//            if $0 == self.txtOtp1 {
//                $0?.becomeFirstResponder()
//            }
//        }
  //  }
    
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
}

// MARK: - Actions
extension OtpNumberVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case btnResendOtp :
            self.btnResenOtpAction()
        default:
            break
        }
    }
    
    func btnResenOtpAction() {
        self.vwResend.isHidden = true
        if self.isComingFrom == .OrderSummary{
            if Reachability.isConnectedToNetwork(){
                self.view.showLoading(centreToView: self.view)
                viewModelResendOtp.checkoutVerifyResendOTP(userType: self.userType) { isTrue , messageShowToast in
                    if isTrue == true {
                        DispatchQueue.main.async { [self] in
                            self.view.stopLoading()
                            self.viewModel.totalTime = 60
                            [self.txtOtp1,txtOtp2,txtOtp3,txtOtp4].forEach{$0?.text = ""}
                            self.startTimer()
                            self.vwResend.isHidden = true
                            btnContinue.isEnabled = true
                            btnContinue.alpha = 1
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
        }else{
            if Reachability.isConnectedToNetwork(){
                self.view.showLoading(centreToView: self.view)
                viewModelResendOtp.signInAPI { isTrue , messageShowToast in
                    if isTrue == true {
                        DispatchQueue.main.async { [self] in
                            self.view.stopLoading()
                            self.viewModel.totalTime = 60
                            [self.txtOtp1,txtOtp2,txtOtp3,txtOtp4].forEach{$0?.text = ""}
                            self.startTimer()
                            self.vwResend.isHidden = true
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
        }
    }
      
    
    func btnContinueAction() {
        let otp = "\(self.txtOtp1.text ?? "")" + "\(self.txtOtp2.text ?? "")" + "\(self.txtOtp3.text ?? "")" + "\(self.txtOtp4.text ?? "")"
        self.viewModel.otp = otp
        if self.txtOtp1.text ?? "" == "" || self.txtOtp2.text ?? "" == "" || self.txtOtp3.text ?? "" == "" || self.txtOtp4.text ?? "" == "" {
            self.showToast(message: PLEASE_ENTER_OTP)
        } else {
            if self.isComingFrom == .OrderSummary{
                if (self.userType == .new) || (self.userType == .existing && self.isChangeMobileNumberTap == true){
                    if Reachability.isConnectedToNetwork(){
                        self.view.showLoading(centreToView: self.view)
                        viewModel.checkoutVerifyOTP(isComingFrom: self.isComingFrom, complition: { isTrue, messageShowToast  in
                            if isTrue == true {
                                DispatchQueue.main.async {
                                    self.view.stopLoading()
                                    self.navigateToPaymentVc()
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.view.stopLoading()
                                    self.showToast(message: messageShowToast)
                                }
                            }
                        })
                    }else {
                        self.showToast(message: ValidationConstantStrings.networkLost)
                    }
                }else{
                    if Reachability.isConnectedToNetwork(){
                        self.view.showLoading(centreToView: self.view)
                        viewModel.checkoutVerifyOTP(isComingFrom: isComingFrom, complition: { isTrue, messageShowToast  in
                            DispatchQueue.main.async {
                                self.view.stopLoading()
                            }
                            if isTrue == true {
                                self.otpVerified?(true, messageShowToast)
                            } else {
                                self.otpVerified?(false, messageShowToast)
                            }
                        })
                    }else {
                        self.showToast(message: ValidationConstantStrings.networkLost)
                    }
                }
            }else{
                //            // REMOVE WHEN API IS WORKING
                //            if isComingFromLogin{
                //                let view  = self.createView(storyboard: .main, storyboardID: .LoginNmberWithEmailVC) as! LoginNmberWithEmailVC
                //                view.viewModel?.arrMail.append(EmailListUser(name: "", email: ""))
                //                self.navigationController?.pushViewController(view, animated: true)
                //            }else{
                //                let view = self.createView(storyboard: .home, storyboardID: .EventBookingPaymentMethodVC) as? EventBookingPaymentMethodVC
                //                self.navigationController?.pushViewController(view!, animated: true)
                //            }
                
                //     ------------------------------------
                //        TO BE DONE WHEN API IS WORKING
                if Reachability.isConnectedToNetwork(){
                    self.view.showLoading(centreToView: self.view)
                    viewModel.signUpVerifyNumberAPI(complition: { isTrue, messageShowToast  in
                        if isTrue == true {
                            DispatchQueue.main.async {
                                self.view.stopLoading()
                                let view = self.createView(storyboard: .main, storyboardID: .VerifyPopupVC) as! VerifyPopupVC
                                view.strMessage = "Your number has been verified successfully!"
                                view.closerForBack = { istrue in
                                    if istrue ==  true
                                    {
                                        let view  = self.createView(storyboard: .main, storyboardID: .LoginNmberWithEmailVC) as! LoginNmberWithEmailVC
                                        view.isComingFrom = self.isComingFrom
                                        view.viewModel?.arrMail = self.viewModel.arrMail
                                        self.navigationController?.pushViewController(view, animated: true)
                                    }
                                }
                                view.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
                                self.present(view, animated: true)
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.view.stopLoading()
                                self.showToast(message: messageShowToast)
                            }
                        }
                    })
                }else {
                    self.showToast(message: ValidationConstantStrings.networkLost)
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension OtpNumberVC : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
    
   
    @objc func textFieldDidChange(textField: UITextField){
      let text = textField.text
      if text?.count == 1 {
        switch textField{
        case txtOtp1:
          txtOtp2.becomeFirstResponder()
        case txtOtp2:
          txtOtp3.becomeFirstResponder()
        case txtOtp3:
          txtOtp4.becomeFirstResponder()
        case txtOtp4:
          txtOtp4.resignFirstResponder()
        default:
          break
        }
      }else if text?.count == 0{
        switch textField{
        case txtOtp1:
          txtOtp1.becomeFirstResponder()
        case txtOtp2:
          txtOtp1.becomeFirstResponder()
        case txtOtp3:
          txtOtp2.becomeFirstResponder()
        case txtOtp4:
           txtOtp3.becomeFirstResponder()
        default:
          break
        }
      }else if text?.count ?? 0 >= 2 {
        switch textField{
        case txtOtp1:
          var string = txtOtp1.text
          string?.removeFirst()
          txtOtp1.text = string
          txtOtp2.becomeFirstResponder()
        case txtOtp2:
          var string = txtOtp2.text
          string?.removeFirst()
          txtOtp2.text = string
          txtOtp3.becomeFirstResponder()
        case txtOtp3:
          var string = txtOtp3.text
          string?.removeFirst()
          txtOtp3.text = string
          txtOtp4.becomeFirstResponder()
        case txtOtp4:
          var string = txtOtp4.text
          string?.removeFirst()
          txtOtp4.text = string
          txtOtp4.resignFirstResponder()
        default:
          break
        }
      }
      else{
      }
    }
}

// MARK: - NavigationBarViewDelegate
extension OtpNumberVC : NavigationBarViewDelegate {
  func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}


extension OtpNumberVC {
    func startTimer() {
        self.viewModel.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func getAttributedOtpStr(str:String) -> NSAttributedString{
        
        let attributedString = NSMutableAttributedString(string: str)

        // Define attributes for the "00:00" portion (e.g., make it bold)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.setFont(fontType: .bold, fontSize: .sixteen) // You can adjust the font size as needed
        ]
        // Apply the attributes to the specific range containing "00:00"
        attributedString.addAttributes(attributes, range: NSRange(location: 24, length: 6)) // Adjust the range as needed
        return attributedString
    }
    
    @objc func updateTime() {
        // Create an attributed string
        lblReceiveOtp.attributedText = getAttributedOtpStr(str: "Your OTP will expire in \(timeFormatted(self.viewModel.totalTime))s")
       // lblReceiveOtp.text = "Your OTP will expire in \(timeFormatted(self.viewModel.totalTime))"
        
        if self.viewModel.totalTime != 0 {
            self.viewModel.totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        self.viewModelResendOtp.number = "\(objAppShareData.dicToHoldDataOnSignUpModule?.strDialCountryCode ?? "+91")\(objAppShareData.dicToHoldDataOnSignUpModule?.strNumber ?? "7898525961")"
        self.vwResend.isHidden = false
        self.viewModel.countdownTimer.invalidate()
        btnContinue.isEnabled = false
        btnContinue.alpha = 0.5
    }
}







