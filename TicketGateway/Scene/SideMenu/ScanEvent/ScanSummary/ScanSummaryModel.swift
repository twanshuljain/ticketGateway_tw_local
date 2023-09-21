//
//  ScanSummaryModel.swift
//  TicketGateway
//
//  Created by apple on 9/12/23.
//

import Foundation
struct ScanOverviewModel: Encodable {
    var eventId: Int = 0
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
    }
}
struct ScanSummaryModel: Encodable {
    var tab: String = "ACCEPTED"
    var page: Int = 1
    var limit: Int = 10
}
enum TicketStatusList: String {
    case tixToScan = "Tix to scan"
    case tixScanned = "Tix Scanned"
    case accepted = "Accepted"
    case rejected = "Rejected"
    case scannedHardTix = "Scanned Hard Tix"
    case scannedPdfTix = "Scanned PDF Tix"
    case scannedCompsTix = "Scanned Comps Tix"
}
