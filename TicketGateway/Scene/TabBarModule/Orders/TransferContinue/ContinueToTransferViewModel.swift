//
//  ContinueToTransferViewModel.swift
//  TicketGateway
//
//  Created by Apple on 04/09/23.
//

import Foundation
class ContinueToTransferViewModel {
    // MARK: - Variables
    var ticketDetails: GetMyOrderItem?
    var eventDetail: EventDetail?
    var myTicket:MyTicket?
    var email = ""
    var confirmEmail = ""
    var fullName = ""
    var mobileNumber = ""
    var isChangeName = false
    var isTCsChecked = false
}


extension ContinueToTransferViewModel{
    var validateInput: (errorMessage: String, isValid: Bool) {
        if Validation.shared.organizerInputValidation(text: email, validationType: .email).0 {
            let errMsg = Validation.shared.organizerInputValidation(text: email, validationType: .email).1
            return (errMsg, false)
        }else if email != confirmEmail{
            return ("Please enter valid confirm email", false)
        }else if (isChangeName == true) && (fullName == ""){
            return ("Please enter fullname", false)
        }
        return("", true)
    }
    
    
    func transferTicket(complition: @escaping (Bool,String) -> Void ) {
        var getURL = APIName.TransferTicket.rawValue + "\(self.ticketDetails?.eventId ?? 0)/"
        let param = ContinueTransferRequest(cell_phone: self.mobileNumber, email: self.email, confirm_email: self.confirmEmail, full_name: self.fullName)
        APIHandler.shared.executeRequestWith(apiName: .TransferTicket, parameters: param, methodType: .POST, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<ContactOrganiserResponseModel>, Error>) in
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
    
    func reSendTransferTicket(complition: @escaping (Bool,String) -> Void ) {
        var getURL = APIName.ResendTicketTransfer.rawValue + "\(self.ticketDetails?.eventId ?? 0)/"
        let param = ContinueTransferRequest(cell_phone: self.mobileNumber, email: self.email, confirm_email: self.confirmEmail, full_name: self.fullName)
        APIHandler.shared.executeRequestWith(apiName: .TransferTicket, parameters: param, methodType: .POST, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<ContactOrganiserResponseModel>, Error>) in
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
