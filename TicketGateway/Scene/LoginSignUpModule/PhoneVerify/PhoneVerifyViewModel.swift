//
//  PhoneVerifyViewModel.swift
//  TicketGateway
//
//  Created by Apple on 21/08/23.
//

import UIKit

final class PhoneVerifyViewModel{
    var mobileNumber: String = ""
    var emailAddress: String = ""
    var eventId:Int?
    var selectedArrTicketList : [EventTicket]?
    var eventDetail:EventDetail?
    var feeStructure :FeeStructure?
    var totalTicketPrice = ""
    var selectedAddOnList:[EventTicketAddOnResponseModel]?
    var selectedCurrencyType = ""
}

extension PhoneVerifyViewModel{
    var validateUserInput: (errorMessage: String, isValid: Bool) {
        if Validation.shared.textValidation(text: mobileNumber, validationType: .number).0 {
            let errMsg = Validation.shared.textValidation(text: mobileNumber, validationType: .number).1
            return (errMsg, false)
        } else if Validation.shared.textValidation(text: emailAddress, validationType: .email).0 {
            let errMsg = Validation.shared.textValidation(text: emailAddress, validationType: .email).1
            return (errMsg, false)
        }
        return("", true)
    }
    
    var validateUserMobile: (errorMessage: String, isValid: Bool) {
        if Validation.shared.textValidation(text: mobileNumber, validationType: .number).0 {
            let errMsg = Validation.shared.textValidation(text: mobileNumber, validationType: .number).1
            return (errMsg, false)
        }
        return("", true)
    }
}
