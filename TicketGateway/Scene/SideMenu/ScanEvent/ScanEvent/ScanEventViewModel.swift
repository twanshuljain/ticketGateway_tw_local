//
//  ScanEventViewModel.swift
//  TicketGateway
//
//  Created by Apple on 30/06/23.
//

import Foundation

class ScanEventViewModel {
    // MARK: - Variables
    var scanTicketModel = ScanTicketModel()
    var eventId: Int = 0
    var getScanTicketDetails = GetScanTicketDetails()
    func scanTicketApi(scanTicketModel: ScanTicketModel, complition: @escaping (Bool, String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .scanTicket, parameters: scanTicketModel, methodType: .POST, authRequired: true) { (result: Result<ResponseModal<GetScanEventData>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    print("response....",response)
                    self.getScanTicketDetails = GetScanTicketDetails(
                        eventId: response.data?.eventId ?? 0,
                        imageUrl: response.data?.eventCoverImage ?? "",
                        eventName: response.data?.eventName ?? "",
                        availableTicketList: response.data?.availableTicketType ?? []
                    )
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
