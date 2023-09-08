//
//  ScanDetailModel.swift
//  TicketGateway
//
//  Created by apple on 9/7/23.
//

import Foundation
struct ScanDetailModel: Encodable {
    var name: String = ""
    var event_id: Int = 0
}
struct ScanBarCodeModel: Encodable {
    var qrid: String = ""
    var name: String = ""
    var event_id: Int = 0
    var scan_ticket_types: [String] = []
}
