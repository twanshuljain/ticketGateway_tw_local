//
//  TicketTransferModel.swift
//  TicketGateway
//
//  Created by Apple on 13/09/23.
//

import Foundation

// MARK: - TicketTransfer
struct TicketTransfer: Codable {
    var ticketName: String?
    var ticketID, ticketPrice: Int?
    var nameOnTicket: String?
    var ticketOrderID, eventID: Int?
    var ticketType, ticketCurrency: String?
    var quantity, ticketTypeID, baseTicketID: Int?
    var date: String?
    var eventStartDate: String?
    var transferredTo: String?

    enum CodingKeys: String, CodingKey {
        case ticketName = "ticket_name"
        case ticketID = "ticket_id"
        case ticketPrice = "ticket_price"
        case nameOnTicket = "name_on_ticket"
        case ticketOrderID = "ticket_order_id"
        case eventID = "event_id"
        case ticketType = "ticket_type"
        case ticketCurrency = "ticket_currency"
        case quantity
        case ticketTypeID = "ticket_type_id"
        case baseTicketID = "base_ticket_id"
        case date
        case eventStartDate = "event_start_date"
        case transferredTo = "transferred_to"
    }
}
