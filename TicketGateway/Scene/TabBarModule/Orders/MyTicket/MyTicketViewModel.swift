//
//  MyTicketViewModel.swift
//  TicketGateway
//
//  Created by apple on 8/24/23.
//

import Foundation
class MyTicketViewModel {
    var ticketDetails: GetMyOrderItem?
    var myTicket:MyTicketList?
    var eventDetail: EventDetail?
    var dispatchGroup1 = DispatchGroup.init()
}

extension MyTicketViewModel{
    func getMyTicketList(complition: @escaping (Bool,String) -> Void ) {
        var getURL = APIName.GetMyTicketList.rawValue + "\(self.ticketDetails?.eventId ?? 0)"
        APIHandler.shared.executeRequestWith(apiName: .GetMyTicketList, parameters: EmptyModel?.none, methodType: .GET, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<MyTicketList>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    defer { self.dispatchGroup1.leave() }
                    if let data = response.data{
                        self.myTicket = data
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
    
    func GetEventDetailApi(eventId:Int, complition: @escaping (Bool,String) -> Void ) {
        let url = APIName.GetEventDetail.rawValue + "\(eventId)"  + "/"
        APIHandler.shared.executeRequestWith(apiName: .GetEventDetail, parameters: EmptyModel?.none, methodType: .GET, getURL: url, authRequired: true) { (result: Result<ResponseModal<EventDetail>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
                        self.eventDetail = response.data ?? EventDetail()
                        print("--------------------",self.eventDetail)
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
