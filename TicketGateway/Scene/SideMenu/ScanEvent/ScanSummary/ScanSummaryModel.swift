//
//  ScanSummaryModel.swift
//  TicketGateway
//
//  Created by apple on 9/12/23.
//

import Foundation
struct ScanSummaryModel: Encodable {
    var event_id: Int = 0
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
