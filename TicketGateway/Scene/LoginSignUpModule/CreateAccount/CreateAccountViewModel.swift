//
//  CreateAccountViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 17/04/23.
// swiftlint: disable line_length
import UIKit
import Foundation
final class CreateAccountViewModel {
    // MARK: - Variable
    var fullName: String = ""
    var mobileNumber: String = ""
    var emailAddress: String = ""
    var password: String = ""
    var confimePassword: String = ""
    var objUserModel: UserAccountModel?
    var isFromWelcomeScreen = false
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var countries = [[String: String]]()
    var RScountriesModel = [CountryInfo]()
    var crateAccountVC: CreateAccountVC?
    init() {
    }
    init(crateAccountVC: CreateAccountVC) {
        self.crateAccountVC = crateAccountVC
    }
}
// MARK: - Functions
extension CreateAccountViewModel {
    var validateUserInput: (errorMessage: String, isValid: Bool) {
        if Validation.shared.textValidation(text: fullName, validationType: .name).0 {
            let errMsg = Validation.shared.textValidation(text: fullName, validationType: .name).1
            return (errMsg, false)
        } else if Validation.shared.textValidation(text: mobileNumber, validationType: .number).0 {
            let errMsg = Validation.shared.textValidation(text: mobileNumber, validationType: .number).1
            return (errMsg, false)
        } else if Validation.shared.textValidation(text: emailAddress, validationType: .email).0 {
            let errMsg = Validation.shared.textValidation(text: emailAddress, validationType: .email).1
            return (errMsg, false)
        } else if Validation.shared.textValidation(text: password, validationType: .password).0 {
            let errMsg = Validation.shared.textValidation(text: password, validationType: .password).1
            return (errMsg, false)
        } else if Validation.shared.textValidation(text: confimePassword, validationType: .confirmPassword).0 {
            let errMsg = Validation.shared.textValidation(text: confimePassword, validationType: .confirmPassword).1
            return (errMsg, false)
        }
        else if Validation.shared.textComparisonValidation(firstText: password, secondText: confimePassword, validationType: .password).0 {
            let errMsg = Validation.shared.textComparisonValidation(firstText: password, secondText: confimePassword, validationType: .password).1
            return (errMsg, false)
        }
        return("", true)
    }

    func createAccountAPI(complition: @escaping (Bool, String) -> Void) {
        let param = CreateAccountRequest(firstName: fullName, lastName: "", mobileNumber: mobileNumber, emailAddress: emailAddress, password: password, confimePassword: confimePassword, role: "user", isVerify: true, countryCode: self.strCountryDialCode)
        APIHandler.shared.executeRequestWith(apiName: .registerUser, parameters: param, methodType: .POST) { (result: Result<ResponseModal<UserAccountModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        self.objUserModel =  response.data
                        UserDefaultManager.share.storeModelToUserDefault(userData: self.objUserModel, key: .userAuthData)
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
