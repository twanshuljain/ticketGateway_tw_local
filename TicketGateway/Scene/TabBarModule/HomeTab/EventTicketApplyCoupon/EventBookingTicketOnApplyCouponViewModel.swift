//
//  EventBookingTicketOnApplyCouponViewModel.swift
//  TicketGateway
//
//  Created by Apple on 28/07/23.
//
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import Foundation

final class EventBookingTicketOnApplyCouponViewModel{
    // MARK: - Variables
    var eventDetail :EventDetail?
    var isCheckedTerm_COndition = false
    var totalTicketPrice = ""
    var feeStructure :FeeStructure?
    var isAccessCodeAvailable = false
    var selectedArrTicketList = [EventTicket]()
    var arrDataForAccessCode = [EventTicket]()
    var defaultTicket = [EventTicket]()
    var ticketId = ""
    var eventId:Int?
}
 
extension EventBookingTicketOnApplyCouponViewModel {
    func applyAccessCode(accessCode:String,complition: @escaping (Bool,String) -> Void ) {
      // guard let eventId = self.eventDetail?.event?.id else {return}
        //let accessCode = "MOON"
       let eventId = 34
//       // var getURL = APIName.ApplyAccessCode.rawValue + "\(34)" + "/"
      // var getURL = APIName.ApplyAccessCode.rawValue + "\(eventId)" + "/"
//       // var getURL = APIName.GetTicketList.rawValue + "12" + "/"
        let param = AccessCodeRequestModel(eventId: eventId, access_code: accessCode)
        APIHandler.shared.executeRequestWith(apiName: .ApplyAccessCode, parameters: param, methodType: .POST, getURL: APIName.ApplyAccessCode.rawValue, authRequired: true) { (result: Result<ResponseModal<[EventTicket]>, Error>) in
            switch result {
            case .success(let response):
               // defer { self.dispatchGroup.leave() }
                if response.status_code == 200 {
                    if let data = response.data{
                        self.arrDataForAccessCode = data
                        print("---------------arrDataForAccessCode", self.arrDataForAccessCode )
                        //self.arrTicketList?.append(contentsOf: data)
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
              //  defer { self.dispatchGroup.leave() }
                complition(false,"\(error)")
            }
        }
    }
}
