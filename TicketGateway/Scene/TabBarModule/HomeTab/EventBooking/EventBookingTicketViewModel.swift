//
//  EventBookingTicketViewModel.swift
//  TicketGateway
//
//  Created by Apple on 14/07/23.
//
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import Foundation


final class EventBookingTicketViewModel{
    //MARK: - Variables
    var isCheckedTerm_COndition = false
    var ticketId = ""
    var eventDetail:EventDetail?
    var eventId:Int?
    var arrTicketList : [EventTicket]?
    var selectedArrTicketList = [EventTicket]()
    var feeStructure:FeeStructure?
    var dispatchGroup:DispatchGroup = DispatchGroup()
    
}
//MARK: - Functions
extension EventBookingTicketViewModel{
    func getEventTicketList(complition: @escaping (Bool,String) -> Void ) {
        var getURL = APIName.GetTicketList.rawValue + "\(self.eventId ?? 0)" + "/"
       // var getURL = APIName.GetTicketList.rawValue + "12" + "/"
        APIHandler.shared.executeRequestWith(apiName: .GetTicketList, parameters: EmptyModel?.none, methodType: .GET, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<[EventTicket]>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup.leave() }
                if response.status_code == 200 {
                    if let data = response.data{
                        self.arrTicketList = data
                        print("---------------ARRTICKETDATA", self.arrTicketList ?? [])
                        //self.arrTicketList?.append(contentsOf: data)
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                }else{
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
        var getURL = APIName.GetFeeStructure.rawValue + "\(eventId)" + "/"
        APIHandler.shared.executeRequestWith(apiName: .GetFeeStructure, parameters: EmptyModel?.none, methodType: .POST, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<FeeStructure>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    if let data = response.data{
                        self.feeStructure = data
                        complition(true, response.message ?? "")
                    }
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
