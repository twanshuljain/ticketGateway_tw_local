//
//  EventTiclketAddOnViewModel.swift
//  TicketGateway
//
//  Created by Apple on 20/07/23.
//

import Foundation
class EventTiclketAddOnViewModel {
    var addOnTableData = ["Tshirt_ip", "Tshirt_ip", "Tshirt_ip", "Tshirt_ip"]
    var lblNumberOfCount = 0
    var totalTicketPriceWithoutAddOn = 0.0
    var totalTicketPriceWithAddOn = 0.0
    var totalTicketPrice = ""
    var feeStructure:FeeStructure?
    var ticketId = ""
    var eventDetail:EventDetail?
    var arrAddOnTicketList: [EventTicketAddOnResponseModel]?
    var selectedArrTicketList = [EventTicket]()
    var selectedAddOnList = [EventTicketAddOnResponseModel]()
    var eventId: Int?
    var selectedCurrencyType = ""

    func getAddOnTicketList(complition: @escaping (Bool,String) -> Void ) {
        // var getURL = APIName.GetTicketList.rawValue + self.ticketId + "/"
        var getURL = APIName.getAddOnList.rawValue + "\(self.eventDetail?.event?.id ?? 0)" + "/"
        APIHandler.shared.executeRequestWith(apiName: .getAddOnList, parameters: EmptyModel?.none, methodType: .GET, getURL: getURL, authRequired: true) { (result: Result<ResponseModal<[EventTicketAddOnResponseModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    if let data = response.data{
                        self.arrAddOnTicketList = data
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
