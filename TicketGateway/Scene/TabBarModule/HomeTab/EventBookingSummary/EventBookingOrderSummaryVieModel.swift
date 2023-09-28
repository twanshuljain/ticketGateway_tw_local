//
//  EventBookingOrderSummaryVieModel.swift
//  TicketGateway
//
//  Created by Apple on 28/07/23.
//

import Foundation
import Stripe

final class EventBookingOrderSummaryVieModel{
    // MARK: - Variables
    var selectedArrTicketList = [EventTicket]()
    var eventDetail:EventDetail?
    var feeStructure :FeeStructure?
    var totalTicketPrice = ""
    var selectedAddOnList = [EventTicketAddOnResponseModel]()
    var eventId:Int?
    var discountType : DiscountType?
    var selectedCurrencyType = ""
}

extension EventBookingOrderSummaryVieModel{
    

}
