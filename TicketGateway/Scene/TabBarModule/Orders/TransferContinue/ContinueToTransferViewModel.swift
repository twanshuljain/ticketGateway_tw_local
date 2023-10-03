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
    var ticketTransfer: TicketTransfer?
}


extension ContinueToTransferViewModel{
    var validateInput: (errorMessage: String, isValid: Bool) {
        if Validation.shared.organizerInputValidation(text: email, validationType: .email).0 {
            let errMsg = Validation.shared.organizerInputValidation(text: email, validationType: .email).1
            return (errMsg, false)
        }else if email != confirmEmail{
            return ("Please enter valid confirm email", false)
        }else if (isChangeName == true) && (fullName == "") {
            return ("Please enter fullname", false)
        }
        return("", true)
    }
    
    
    func transferTicket(complition: @escaping (Bool,String) -> Void ) {
        let getURL = APIName.transferTicket.rawValue + "\(self.myTicket?.ticketOrderID ?? 0)/"
        let param = ContinueTransferRequest(cellPhone: self.mobileNumber, email: self.email, confirmEmail: self.confirmEmail, fullName: self.fullName)
        APIHandler.shared.executeRequestWith(apiName: .transferTicket, parameters: param, methodType: .POST, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<TicketTransfer>, Error>) in
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
    
    func reSendTransferTicket(transferId: Int?,complition: @escaping (Bool,String) -> Void ) {
        let getURL = APIName.resendTicketTransfer.rawValue + "\(transferId ?? 0)/"
        APIHandler.shared.executeRequestWith(apiName: .transferTicket, parameters: EmptyModel?.none, methodType: .GET, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<TicketTransfer>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    self.ticketTransfer = response.data
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
