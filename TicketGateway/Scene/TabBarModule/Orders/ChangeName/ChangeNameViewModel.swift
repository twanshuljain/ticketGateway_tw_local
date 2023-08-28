//
//  ChangeNameViewModel.swift
//  TicketGateway
//
//  Created by Apple on 28/08/23.
//

import Foundation

final class ChangeNameViewModel{
    var firstName = ""
    var lastName = ""
    var ticketId = ""
    var ticketOrderId = ""
}

extension ChangeNameViewModel{
    var validateInput: (errorMessage: String, isValid: Bool) {
        if firstName == ""{
           return ("Please enter first name", false)
       }else if lastName == ""{
           return ("Please enter last name", false)
       }
        return("", true)
    }
    
    func changeTicketName(complition: @escaping (Bool,String) -> Void ) {
        let param = ChangeNameRequestModel(ticketId: Int(ticketId), firstName: firstName, lastName: lastName, ticketOrderId: Int(ticketOrderId))
        APIHandler.shared.executeRequestWith(apiName: .ChangeTicketName, parameters: param, methodType: .POST, getURL: APIName.ApplyAccessCode.rawValue, authRequired: true) { (result: Result<ResponseModal<ContactOrganiserResponseModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                complition(false,"\(error)")
            }
        }
    }
}
