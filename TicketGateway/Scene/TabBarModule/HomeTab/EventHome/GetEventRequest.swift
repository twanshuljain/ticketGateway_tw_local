//
//  GetEventRequest.swift
//  TicketGateway
//
//  Created by Apple on 10/07/23.
//

import UIKit

enum EventType:String {
    case free = "free"
    case popular = "popular"
    case virtual = "virtual"
    case weekend = "weekend"
    case upcoming = "upcoming"
}

struct GetEventRequest: Codable {
    var eventType: String?
    var limit: String?
    var page: String?

    enum CodingKeys: String, CodingKey {
        case eventType = "event_type"
        case limit
        case page
    }
}
