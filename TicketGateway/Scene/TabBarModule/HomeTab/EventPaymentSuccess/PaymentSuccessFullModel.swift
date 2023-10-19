//
//  PaymentSuccessFullModel.swift
//  TicketGateway
//
//  Created by apple on 10/19/23.
//

import Foundation
struct PaymentSuccessFullModel: Encodable {
    var userId: Int = 0
    var eventId: Int = 0
    var checkoutId: String = ""
    var orderId: Int = 0
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case eventId = "event_id"
        case checkoutId = "checkout_id"
        case orderId = "order_id"
    }
}
