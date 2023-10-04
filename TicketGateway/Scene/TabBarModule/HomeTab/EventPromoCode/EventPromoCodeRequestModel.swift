//
//  EventPromoCodeRequestModel.swift
//  TicketGateway
//
//  Created by Apple on 24/08/23.
//

import Foundation

enum DiscountType:String {
    case AMOUNT = "AMOUNT"
    case PERCENTAGE = "PERCENTAGE"
}

struct EventPromoCodeRequestModel: Codable {
    var eventId: Int?
    var promoCode: String?

    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case promoCode = "promo_code"
    }
}
