//
//  ScanEventModel.swift
//  TicketGateway
//
//  Created by apple on 9/6/23.
//

import Foundation
struct ScanTicketModel: Encodable {
    var name: String = ""
    var scanPin: String = ""
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case scanPin = "scan_pin"
    }
}
struct GetScanTicketDetails {
    var name: String = ""
    var eventId: Int = 0
    var imageUrl: String = ""
    var eventName: String = ""
    var selectedTicketType: [String] = []
    var availableTicketList: [String] = []
}
