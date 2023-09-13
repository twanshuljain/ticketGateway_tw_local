//
//  GetScanSummaryModel.swift
//  TicketGateway
//
//  Created by apple on 9/12/23.
//

import Foundation
struct GetScanSummaryData: Codable {
    init() {}
    var eventId: Int?
    var eventName: String?
    var eventCoverImage: String?
    var totalTicketInEvent: Int?
    var tixToScan: Int?
    var tixScanned: Int?
    var tixAccepted: Int?
    var tixRejected: Int?
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case eventName = "event_name"
        case eventCoverImage = "event_cover_image"
        case totalTicketInEvent = "total_ticket_in_event"
        case tixToScan = "tix_to_scan"
        case tixScanned = "tix_scanned"
        case tixAccepted = "tix_accepted"
        case tixRejected = "tix_rejected"
    }
}
