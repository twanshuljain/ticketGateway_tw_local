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
    var myTicket:MyTicketList?
    var selectedTicket:MyTicket?
}

extension ChangeNameViewModel{
    var validateInput: (errorMessage: String, isValid: Bool) {
        if firstName == ""{
           return ("Please enter first name", false)
       } else if lastName == ""{
           return ("Please enter last name", false)
       }
        return("", true)
    }

    func changeTicketName(complition: @escaping (Bool,String) -> Void ) {
        var getURL = APIName.changeTicketName.rawValue + "\(self.selectedTicket?.ticketOrderID ?? 0)/"
        let param = ChangeNameRequestModel(ticketId: selectedTicket?.ticketOrderID ?? 0, firstName: firstName, lastName: lastName, ticketOrderId: selectedTicket?.ticketOrderID ?? 0)
        APIHandler.shared.executeRequestWith(apiName: .changeTicketName, parameters: param, methodType: .POST, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<ContactOrganiserResponseModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
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
