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
    var eventId:Int?
}
