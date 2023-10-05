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
    var eventId: Int?
    var selectedArrTicketList: [EventTicket]?
    var eventDetail:EventDetail?
    var feeStructure :FeeStructure?
    var totalTicketPrice = ""
    var selectedAddOnList: [EventTicketAddOnResponseModel]?
    var objUserModel: SignInAuthModel?
    var selectedCurrencyType = ""
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
                if response.statusCode == 200 {
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

    func checkoutVerifyOTP(isComingFrom: IsComingFrom,complition: @escaping (Bool, String) -> Void) {
        var param: NumberVerifyRequest?

        let numberWithoutCode = objAppShareData.dicToHoldDataOnSignUpModule?.strNumber ?? ""
        let number = "\(objAppShareData.dicToHoldDataOnSignUpModule?.strDialCountryCode ?? "")" + (objAppShareData.dicToHoldDataOnSignUpModule?.strNumber ?? "")
        param = NumberVerifyRequest(otp: otp, cell_phone: number)
        APIHandler.shared.executeRequestWith(apiName: .checkoutVerifyNumberOtp, parameters: param, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    if isComingFrom == .orderSummary && UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin) {
                        UserDefaultManager.share.clearAllUserDataAndModel()
                        self.objUserModel = SignInAuthModel(id: response.data?.id, number: numberWithoutCode, fullName: response.data?.fullName, email:  response.data?.email, accessToken:  response.data?.accessToken, refreshToken: response.data?.refreshToken, strDialCountryCode: objAppShareData.dicToHoldDataOnSignUpModule?.strDialCountryCode ?? "")
                        UserDefaultManager.share.storeModelToUserDefault(userData: self.objUserModel, key: .userAuthData)
                        UserDefaultManager.share.guestUserLogin(value: false, key: .isGuestLogin)
                    }
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
