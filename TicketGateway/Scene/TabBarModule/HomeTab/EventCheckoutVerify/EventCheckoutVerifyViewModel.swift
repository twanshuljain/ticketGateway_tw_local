//
//  EventCheckoutVerifyViewModel.swift
//  TicketGateway
//
//  Created by Apple on 12/10/23.
//

import Foundation


class EventCheckoutVerifyViewModel{
    
    // MARK: - Variable
    var firstName: String = ""
    var lastName: String = ""
    var mobileNumber: String = ""
    var emailAddress: String = ""
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var countries = [[String: String]]()
    var RScountriesModel = [CountryInfo]()
    var emailVerifyResponse:CheckEmailResponse?
    var authModel: SignInAuthModel?

    var eventId:Int?
    var selectedArrTicketList : [EventTicket]?
    var eventDetail:EventDetail?
    var feeStructure :FeeStructure?
    var totalTicketPrice = ""
    var selectedAddOnList:[EventTicketAddOnResponseModel]?
    var selectedCurrencyType = ""
    
}

extension EventCheckoutVerifyViewModel{
    var validateUserInput: (errorMessage: String, isValid: Bool) {
        if Validation.shared.textValidation(text: emailAddress, validationType: .email).0 {
            let errMsg = Validation.shared.textValidation(text: emailAddress, validationType: .email).1
            return (errMsg, false)
        }else if Validation.shared.textValidation(text: firstName, validationType: .firstname).0 {
            let errMsg = Validation.shared.textValidation(text: firstName, validationType: .firstname).1
            return (errMsg, false)
        }else if Validation.shared.textValidation(text: lastName, validationType: .lastname).0 {
            let errMsg = Validation.shared.textValidation(text: lastName, validationType: .lastname).1
            return (errMsg, false)
        } else if Validation.shared.textValidation(text: mobileNumber, validationType: .number).0 {
            let errMsg = Validation.shared.textValidation(text: mobileNumber, validationType: .number).1
            return (errMsg, false)
        }
        return("", true)
    }
    
    
    func checkEmail(param:CheckEmail,complition: @escaping (Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(apiName: .checkEmail, parameters: param, methodType: .POST) { (result: Result<ResponseModal<CheckEmailResponse>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        self.emailVerifyResponse =  response.data
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
    
    func checkoutValidateUser(param: ValidateForNumberRequest,complition: @escaping (Bool,String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .checkoutValidateUser, parameters: param, methodType: .POST, authRequired: false) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        self.authModel = response.data
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
