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
    var arrDataForAccessCode : [EventTicket]?
    var defaultTicket = [EventTicket]()
    var arrTicketList : [EventTicket]?
    var ticketId = ""
    var eventId:Int?
    var dispatchGroup:DispatchGroup = DispatchGroup()
    let semaphore = DispatchSemaphore(value: 1)
    var dispatchGroup1 = DispatchGroup.init()
    var dispatchGroup2 = DispatchGroup.init()
    var arrAddOnTicketList: [EventTicketAddOnResponseModel]?
}
 
extension EventBookingTicketOnApplyCouponViewModel {
    func applyAccessCode(accessCode:String,complition: @escaping (Bool,String) -> Void ) {
        //let accessCode = "MOON"
        let param = AccessCodeRequestModel(eventId: eventId, accessCode: accessCode)
        APIHandler.shared.executeRequestWith(apiName: .applyAccessCode, parameters: param, methodType: .POST, getURL: APIName.applyAccessCode.rawValue, authRequired: true) { (result: Result<ResponseModal<[EventTicket]>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup1.leave() }
                if response.status_code == 200 {
                    if let data = response.data{
                        self.arrDataForAccessCode?.removeAll()
                        self.arrDataForAccessCode = []
                        self.arrDataForAccessCode = data
                        self.arrDataForAccessCode?.forEach({ data in
                            self.arrTicketList?.removeAll(where: { $0.uniqueTicketID == data.uniqueTicketID })
                        })
                        self.arrTicketList?.appendAtBeginning(newItem: data)
                        //self.arrTicketList?.append(contentsOf: data)
                        print("---------------arrDataForAccessCode", self.arrDataForAccessCode)
                        print("---------------arrTicketList", self.arrTicketList)
                    }
                    complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
               defer { self.dispatchGroup1.leave() }
                complition(false,"\(error)")
            }
        }
    }
    
    func getEventTicketList(complition: @escaping (Bool,String) -> Void ) {
        var getURL = APIName.getTicketList.rawValue + "\(self.eventId ?? 0)" + "/"
       // var getURL = APIName.GetTicketList.rawValue + "12" + "/"
        APIHandler.shared.executeRequestWith(apiName: .getTicketList, parameters: EmptyModel?.none, methodType: .GET, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<[EventTicket]>, Error>) in
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
        var getURL = APIName.getFeeStructure.rawValue + "\(eventId)" + "/"
        APIHandler.shared.executeRequestWith(apiName: .getFeeStructure, parameters: EmptyModel?.none, methodType: .POST, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<FeeStructure>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup2.leave() }
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
                defer { self.dispatchGroup2.leave() }
                complition(false,"\(error)")
            }
        }
    }
    
    func getAddOnTicketList(complition: @escaping (Bool,String) -> Void ) {
        // var getURL = APIName.GetTicketList.rawValue + self.ticketId + "/"
        var getURL = APIName.getAddOnList.rawValue + "\(self.eventDetail?.event?.id ?? 0)" + "/"
        APIHandler.shared.executeRequestWith(apiName: .getAddOnList, parameters: EmptyModel?.none, methodType: .GET, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<[EventTicketAddOnResponseModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    if let data = response.data{
                        self.arrAddOnTicketList = data
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
