//
//  LoginViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
//

import Foundation
import UIKit
final class SignInViewModel {
    // MARK: - Variable
    var loginVC : LoginVC?
    var isFromNumberOrEmail = true // number = false , email = true
    var isFromWelcomeScreen = false
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var countries = [[String: String]]()
    var RScountriesModel = [CountryInfo]()
    var email: String = ""
    var password: String = ""
    var number: String = ""
    var isForEmail: Bool = false
    var objUserModel: SignInAuthModel?
    
    init() {
    }
    init(loginVC: LoginVC) {
        self.loginVC = loginVC
    }
}
// MARK: - Functions
extension SignInViewModel {
    var validateUserInput:(errormessage: String, isValid: Bool){
        if isForEmail == true {
            if Validation.shared.textValidation(text: email, validationType: .email).0 {
                let errMsg = Validation.shared.textValidation(text: email, validationType: .email).1
                return (errMsg, false)
            }
            if Validation.shared.textValidation(text: password, validationType: .password).0 {
                let errMsg = Validation.shared.textValidation(text: password, validationType: .password).1
                return (errMsg, false)
            }
        } else {
            if Validation.shared.textValidation(text: number, validationType: .number).0 {
                let errMsg = Validation.shared.textValidation(text: number, validationType: .number).1
                return (errMsg, false)
            }
        }
        return ("", true)
    }
    func signInAPI(complition: @escaping (Bool,String) -> Void ) {
        let paramForEmail = SignInRequest(emailPhone: email, password: password)
        let paramForNumber = SignInForNumberRequest(cellphone: number)
        if isForEmail == true {
            APIHandler.shared.executeRequestWith(apiName: .signInUser, parameters: paramForEmail, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        DispatchQueue.main.async {
                            if self.isForEmail == true {
                                self.objUserModel = response.data
                                UserDefaultManager.share.storeModelToUserDefault(userData: self.objUserModel, key: .userAuthData)
                                objAppShareData.userAuth = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
                            } else {
                                // Send to Otp screen,,,.
                            }
                        }
                        complition(true, response.message ?? "")
                    } else {
                        complition(false,response.message ?? "error message")
                    }
                case .failure(let error):
                    complition(false, "\(error)")
                }
            }
        } else {
            APIHandler.shared.executeRequestWith(apiName: .signInNumber, parameters: paramForNumber, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        DispatchQueue.main.async {
                            self.objUserModel = response.data
                            print(self.objUserModel as Any)
                            self.objUserModel =  response.data
                            // UserDefaultManager.share.storeModelToUserDefault(userData: self.objUserModel, key: .userAuthData)
                        }
                        complition(true, response.message ?? "")
                    } else {
                        complition(false,response.message ?? "error message")
                    }
                case .failure(let error):
                    complition(false, "\(error)")
                }
            }
        }
    }
    
    func checkoutVerifyResendOTP(userType: UserType,complition: @escaping (Bool,String) -> Void ) {
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        var authTokenString = userType == .new ? false : true
        let paramForNumber:ValidateForNumberRequest?
        if userType == .new{
            paramForNumber = ValidateForNumberRequest(cellPhone: userModel?.number, email: userModel?.email)
        }else{
            paramForNumber = ValidateForNumberRequest()
        }
        APIHandler.shared.executeRequestWith(apiName: .checkoutVerifyResendOtp, parameters: paramForNumber, methodType: .POST, authTokenString: authTokenString) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        complition(true, response.message ?? "")
                    } else {
                        complition(false,response.message ?? "error message")
                    }
                case .failure(let error):
                    complition(false, "\(error)")
                }
            }
        
    }
    
    func checkoutValidateUser(param: ValidateForNumberRequest,complition: @escaping (Bool,String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .checkoutValidateUser, parameters: param, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        complition(true, response.message ?? "")
                    } else {
                        complition(false,response.message ?? "error message")
                    }
                case .failure(let error):
                    complition(false, "\(error)")
                }
            }
        
    }
}
