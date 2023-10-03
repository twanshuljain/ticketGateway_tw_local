//
//  ContactOrganiserViewModel.swift
//  TicketGateway
//
//  Created by Apple on 28/08/23.
//

import UIKit

final class ContactOrganiserViewModel{
    // MARK: - Variables
    var selectedReason = ""
    var reasonList = ["Change of plans", "Unable to attend", "Found a better option", "Personal reasons", "Other"]
    var contactOranizer:ContactOrganiserResponseModel?
    var name = ""
    var email = ""
    var message = ""
    var oranizerId:Int?
    var eventDetail: EventDetail?
    var ticketDetails: GetMyOrderItem?
    
}

extension ContactOrganiserViewModel{
    var validateInput: (errorMessage: String, isValid: Bool) {
        if name == ""{
            return ("Please enter name", false)
        }else if Validation.shared.organizerInputValidation(text: email, validationType: .email).0 {
            let errMsg = Validation.shared.organizerInputValidation(text: email, validationType: .email).1
            return (errMsg, false)
        }else if (selectedReason == "") {
            return ("Please select reason", false)
        }else if message == ""{
            return ("Please enter message", false)
        }
        return("", true)
    }
    
    func contactOrganizer(complition: @escaping (Bool,String) -> Void ) {
        let param = ContactOrganiserRequestModel(name: name, email: email ,reason: selectedReason, message: message, organizerId: oranizerId)
        APIHandler.shared.executeRequestWith(apiName: .contactOrganizer, parameters: param, methodType: .POST, getURL: APIName.applyAccessCode.rawValue, authRequired: true) { (result: Result<ResponseModal<ContactOrganiserResponseModel>, Error>) in
            APIHandler.shared.executeRequestWith(
                apiName: .contactOrganizer,
                parameters: param,
                methodType: .POST,
                getURL: APIName.applyAccessCode.rawValue,
                authRequired: true
            ) { (result: Result<ResponseModal<ContactOrganiserResponseModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        if let data = response.data{
                            self.contactOranizer = data
                        }
                        complition(true, response.message ?? "")
                    } else {
                        complition(false,response.message ?? "error message")
                    }
                case .failure(let error):
                    complition(false,"\(error)")
                }
            }
        }
        
    }
}
