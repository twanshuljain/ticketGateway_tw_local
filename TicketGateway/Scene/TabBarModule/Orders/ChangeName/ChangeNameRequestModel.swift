//
//  ChangeNameRequestModel.swift
//  TicketGateway
//
//  Created by Apple on 28/08/23.
//

import Foundation

struct ChangeNameRequestModel:Codable{
    var ticketId: Int?
    var firstName, lastName: String?
    var ticketOrderId: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case ticketId = "ticket_id"
        case ticketOrderId = "ticket_order_id"
    }
}
