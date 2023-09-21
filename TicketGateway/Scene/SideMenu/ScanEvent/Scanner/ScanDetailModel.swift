//
//  ScanDetailModel.swift
//  TicketGateway
//
//  Created by apple on 9/7/23.
//

import Foundation
struct ScanDetailModel: Encodable {
    var name: String = ""
    var eventId: Int = 0
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case eventId = "event_id"
    }
}
struct ScanBarCodeModel: Encodable {
    var qrid: String = ""
    var name: String = ""
    var eventId: Int = 0
    var scanTicketTypes: [String] = []
    enum CodingKeys: String, CodingKey {
        case qrid = "qrid"
        case name = "name"
        case eventId = "event_id"
        case scanTicketTypes = "scan_ticket_types"
    }

}
