//
//  EventPromoCodeModel.swift
//  TicketGateway
//
//  Created by Apple on 24/08/23.
//

import UIKit

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)


// MARK: - PromoCode
struct PromoCode: Codable {
    var promoCodeLimit, promoCodeStartTime: String?
    var promoCodeTicketQuantity: Int?
    var promoCodeEndTime, discountType, createdAt: String?
    var id, discountValue: Int?
    var updatedAt: String?
    var eventID: Int?
    var isPromoCodeStartNow: Bool?
    var code: String?
    var isPromoCodeEndWithSale: Bool?
    var codeType, promoCodeStartDate, promoCodeEndDate: String?

    enum CodingKeys: String, CodingKey {
        case promoCodeLimit = "promo_code_limit"
        case promoCodeStartTime = "promo_code_start_time"
        case promoCodeTicketQuantity = "promo_code_ticket_quantity"
        case promoCodeEndTime = "promo_code_end_time"
        case discountType = "discount_type"
        case createdAt = "created_at"
        case id
        case discountValue = "discount_value"
        case updatedAt = "updated_at"
        case eventID = "event_id"
        case isPromoCodeStartNow = "is_promo_code_start_now"
        case code
        case isPromoCodeEndWithSale = "is_promo_code_end_with_sale"
        case codeType = "code_type"
        case promoCodeStartDate = "promo_code_start_date"
        case promoCodeEndDate = "promo_code_end_date"
    }
}
