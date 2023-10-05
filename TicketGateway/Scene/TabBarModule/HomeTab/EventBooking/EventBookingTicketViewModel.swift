//
//  EventBookingTicketViewModel.swift
//  TicketGateway
//
//  Created by Apple on 14/07/23.
//

import Foundation

final class EventBookingTicketViewModel{
    // MARK: - Variables
    var isCheckedTermCondition = false
    var ticketId = ""
    var eventDetail:EventDetail?
    var eventId: Int?
    var arrTicketList: [EventTicket]?
    var selectedArrTicketList = [EventTicket]()
    var feeStructure:FeeStructure?
    var dispatchGroup:DispatchGroup = DispatchGroup()

}
// MARK: - Functions
extension EventBookingTicketViewModel{
    func getEventTicketList(complition: @escaping (Bool,String) -> Void ) {
        var getURL = APIName.getTicketList.rawValue + "\(self.eventId ?? 0)" + "/"
       // var getURL = APIName.GetTicketList.rawValue + "12" + "/"
        APIHandler.shared.executeRequestWith(apiName: .getTicketList, parameters: EmptyModel?.none, methodType: .GET, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<[EventTicket]>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup.leave() }
                if response.statusCode == 200 {
                    if let data = response.data{
                        self.arrTicketList = data
                        print("---------------ARRTICKETDATA", self.arrTicketList ?? [])
                        //self.arrTicketList?.append(contentsOf: data)
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup.leave() }
                complition(false,"\(error)")
            }
        }
    }

    func getEventTicketFeeStructure(complition: @escaping (Bool,String) -> Void ) {
        guard let eventId = self.eventDetail?.event?.id else {return}
        var getURL = APIName.getFeeStructure.rawValue + "\(eventId)" + "/"
        APIHandler.shared.executeRequestWith(apiName: .getFeeStructure, parameters: EmptyModel?.none, methodType: .POST, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<FeeStructure>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    if let data = response.data{
                        self.feeStructure = data
                        complition(true, response.message ?? "")
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
