//
//  EventBookingTicketOnApplyCouponRequestModel.swift
//  TicketGateway
//
//  Created by Apple on 08/08/23.
//

import Foundation
struct AccessCodeRequestModel: Codable {
    var eventId: Int?
    var access_code: String?
    
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case access_code = "access_code"
    }
}
