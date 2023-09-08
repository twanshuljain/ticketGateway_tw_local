//
//  GetScanEventModel.swift
//  TicketGateway
//
//  Created by apple on 9/6/23.
//

import Foundation
struct GetScanEventResponse: Codable {
    var data: GetScanEventData?
    var status_code: Int?
    var message: String?
    var error: String?
}
struct GetScanEventData: Codable {
    var eventId: Int?
    var eventName: String?
    var eventCoverImage: String?
    var availableTicketType: [String]?
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case eventName = "event_name"
        case eventCoverImage = "event_cover_image"
        case availableTicketType = "available_ticket_type"
    }
}
