//
//  MyTicketResponseModel.swift
//  TicketGateway
//
//  Created by Apple on 28/08/23.
//

import Foundation

// MARK: - DataClass
struct MyTicketList: Codable {
    var items: [MyTicket]?
    var total, page, size: Int?
    var pages: Int?
}

// MARK: - Item
struct MyTicket: Codable {
    var ticketName: String?
    var ticketID: Int?
    var nameOnTicket: String?
    var ticketPrice, ticketOrderID, eventID: Int?
    var ticketType, ticketCurrency: String?
    var quantity, ticketTypeID, baseTicketID: Int?
    var date: String?
    var eventStartDate: Date?

    enum CodingKeys: String, CodingKey {
        case ticketName = "ticket_name"
        case ticketID = "ticket_id"
        case nameOnTicket = "name_on_ticket"
        case ticketPrice = "ticket_price"
        case ticketOrderID = "ticket_order_id"
        case eventID = "event_id"
        case ticketType = "ticket_type"
        case ticketCurrency = "ticket_currency"
        case quantity
        case ticketTypeID = "ticket_type_id"
        case baseTicketID = "base_ticket_id"
        case date
        case eventStartDate = "event_start_date"
    }
}
