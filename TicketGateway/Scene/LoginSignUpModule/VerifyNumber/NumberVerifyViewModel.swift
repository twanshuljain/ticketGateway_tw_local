//
//  NumberVerifyViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 25/04/23.
// swiftlint: disable line_length
// swiftlint: disable force_cast
// swiftlint: disable cyclomatic_complexity
// swiftlint: disable function_body_length

import UIKit
final class NumberVerifyViewModel {
    var number: String = ""
    var otp: String = ""
    var arrMail: [EmailListUser] = [EmailListUser]()
    var countdownTimer: Timer!
    var totalTime = 60
    var otpNumVC: OtpNumberVC?
    init() {
    }
    init(otpNumVC: OtpNumberVC) {
        self.otpNumVC = otpNumVC
    }
}
extension NumberVerifyViewModel {
    var validateUserInput: (errormessage: String, isValid: Bool) {
        if Validation.shared.textValidation(text: otp, validationType: .otp).0 {
            let errMsg = Validation.shared.textValidation(text: otp, validationType: .otp).1
            return (errMsg, false)
        }
        return ("", true)
    }
    func signUpVerifyNumberAPI(complition: @escaping (Bool, String) -> Void) {
        let param = NumberVerifyRequest( otp: otp, cell_phone: (objAppShareData.dicToHoldDataOnSignUpModule?.strDialCountryCode ?? "")+(objAppShareData.dicToHoldDataOnSignUpModule?.strNumber ?? ""))
        APIHandler.shared.executeRequestWith(apiName: .verifyNumberOtp, parameters: param, methodType: .POST) { (result: Result<ResponseModal<[EmailListUser]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    self.arrMail = response.data!
                    print(self.arrMail)
                    complition(true, response.message ?? "")
                } else {
                    complition(false, response.message ?? "Error message")
                }
            case .failure(let error):
                complition(false, "\(error)")
            }
        }
    }
    
    
    func checkoutVerifyOTP(complition: @escaping (Bool, String) -> Void) {
        let param = NumberVerifyRequest( otp: otp, cell_phone: objAppShareData.dicToHoldDataOnSignUpModule?.strNumber ?? "")
        APIHandler.shared.executeRequestWith(apiName: .checkoutVerifyNumberOtp, parameters: param, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    complition(true, response.message ?? "")
                } else {
                    complition(false, response.message ?? "Error message")
                }
            case .failure(let error):
                complition(false, "\(error)")
            }
        }
    }
}
