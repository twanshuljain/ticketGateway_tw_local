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
}

extension MyTicketViewModel{
    func getMyTicketList(complition: @escaping (Bool,String) -> Void ) {
        var getURL = APIName.GetMyTicketList.rawValue + "\(self.ticketDetails?.eventId ?? 0)" + "/"
        APIHandler.shared.executeRequestWith(apiName: .GetMyTicketList, parameters: EmptyModel?.none, methodType: .GET, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<MyTicketList>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    if let data = response.data{
                        self.myTicket = data
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
