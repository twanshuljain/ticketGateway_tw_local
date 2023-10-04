//
//  EventBookingTicketModel.swift
//  TicketGateway
//
//  Created by Apple on 14/07/23.
//

import Foundation

// MARK: - Datum
struct EventTicket: Codable {
    var id, ticketPrice: Int?
    var isETicket, isActive: Bool?
    var eventID: Int?
    var isSavaricketStatusCheckout, isCall: Bool?
    var uniqueTicketID: String?
    var ticketID: Int?
    var ticketVisibility: String?
    var ticketDescription: String?
    var createdAt, ticketType: String?
    var ticketTypeId : Int?
    var ticketMinimumQuantity: Int?
    var ticketSaleStartDate, updatedAt, ticketCurrencyType: String?
    var ticketMaximumQuantity: Int?
    var selectedTicketQuantity: Int?
    var ticketSaleEndDate: String?
    var ticketName: String?
    var isAdvanceSetting: Bool?
    var ticketSaleStartTime: String?
    var isAbsorbFee: Bool?
    var ticketSalesChannel, ticketSaleEndTime: String?
    var ticketQuantity, ticketIndex: Int?
    var allowPerTicket: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case ticketPrice = "ticket_price"
        case isETicket = "is_e_ticket"
        case isActive = "is_active"
        case eventID = "event_id"
        case isSavaricketStatusCheckout = "is_sale_ticket_status_checkout"
        case isCall = "is_call"
        case uniqueTicketID = "unique_ticket_id"
        case ticketID = "ticket_id"
        case ticketVisibility = "ticket_visibility"
        case ticketDescription = "ticket_description"
        case createdAt = "created_at"
        case ticketType = "ticket_type"
        case ticketTypeId = "ticket_type_id"
        case ticketMinimumQuantity = "ticket_minimum_quantity"
        case ticketSaleStartDate = "ticket_sale_start_date"
        case updatedAt = "updated_at"
        case ticketCurrencyType = "ticket_currency_type"
        case ticketMaximumQuantity = "ticket_maximum_quantity"
        case ticketSaleEndDate = "ticket_sale_end_date"
        case ticketName = "ticket_name"
        case isAdvanceSetting = "is_advance_setting"
        case ticketSaleStartTime = "ticket_sale_start_time"
        case isAbsorbFee = "is_absorb_fee"
        case ticketSalesChannel = "ticket_sales_channel"
        case ticketSaleEndTime = "ticket_sale_end_time"
        case ticketQuantity = "ticket_quantity"
        case ticketIndex = "ticket_index"
        case allowPerTicket = "allow_per_ticket"
    }
}


// MARK: - FeeStructure
struct FeeStructure: Codable {
    var serviceFees: Int?
    var processingFees: String?
    var facilityFees: Int?

    enum CodingKeys: String, CodingKey {
        case serviceFees = "service_fees"
        case processingFees = "processing_fees"
        case facilityFees = "facility_fees"
    }
}
