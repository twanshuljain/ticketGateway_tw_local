//
//  EventTicketAddOnResponseModel.swift
//  TicketGateway
//
//  Created by Apple on 25/07/23.
//

import Foundation

// MARK: - EventTicketAddOnResponseModel
struct EventTicketAddOnResponseModel: Codable {
    var groupTicketID: Int?
    var isAdvanceSettingAddOn: Bool?
    var addOnMaximumQuantity: Int?
    var isActive: Bool?
    var donationTicketID, addOnItemSizes: Int?
    var isAddOnSaleTicketStatus: Bool?
    var requestTicketID: Int?
    var addOnItemPriceType, addOnSaleStartDate: String?
    var id: Int?
    var guestTicketID: Int?
    var addOnTicketPrice: Int?
    var addOnSaleEndDate: String?
    var eventID: Int?
    var bottleTicketID: Int?
    var addOnLogo: [String]?
    var addOnSaleStartTime: String?
    var freeTicketID: Int?
    var addOnTicketType, addOnDescription, addOnSaleEndTime: String?
    var paidTicketID: Int?
    var addOnName: String?
    var addOnMinimumQuantity: Int?
    var createdAt: String?
    var addOnTicketQuantity: Int?
    var updatedAt: String?
    var ticketID: Int?
    var ticketName: String?

    enum CodingKeys: String, CodingKey {
        case groupTicketID = "group_ticket_id"
        case isAdvanceSettingAddOn = "is_advance_setting_add_on"
        case addOnMaximumQuantity = "add_on_maximum_quantity"
        case isActive = "is_active"
        case donationTicketID = "donation_ticket_id"
        case addOnItemSizes = "add_on_item_sizes"
        case isAddOnSaleTicketStatus = "is_add_on_sale_ticket_status"
        case requestTicketID = "request_ticket_id"
        case addOnItemPriceType = "add_on_item_price_type"
        case addOnSaleStartDate = "add_on_sale_start_date"
        case id
        case guestTicketID = "guest_ticket_id"
        case addOnTicketPrice = "add_on_ticket_price"
        case addOnSaleEndDate = "add_on_sale_end_date"
        case eventID = "event_id"
        case bottleTicketID = "bottle_ticket_id"
        case addOnLogo = "add_on_logo"
        case addOnSaleStartTime = "add_on_sale_start_time"
        case freeTicketID = "free_ticket_id"
        case addOnTicketType = "add_on_ticket_type"
        case addOnDescription = "add_on_description"
        case addOnSaleEndTime = "add_on_sale_end_time"
        case paidTicketID = "paid_ticket_id"
        case addOnName = "add_on_name"
        case addOnMinimumQuantity = "add_on_minimum_quantity"
        case createdAt = "created_at"
        case addOnTicketQuantity = "add_on_ticket_quantity"
        case updatedAt = "updated_at"
        case ticketID = "ticket_id"
        case ticketName = "ticket_name"
    }
}
