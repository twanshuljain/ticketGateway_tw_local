//
//  GetScanSummaryModel.swift
//  TicketGateway
//
//  Created by apple on 9/12/23.
//

import Foundation
// MARK: Get Scan OverView Data
struct GetScanOverviewData: Codable {
    init() {}
    var eventId: Int?
    var eventName: String?
    var eventCoverImage: String?
    var totalTicketInEvent: Int?
    var tixToScan: Int?
    var tixScanned: Int?
    var tixAccepted: Int?
    var tixRejected: Int?
    var scannedHardTix: Int?
    var scannedPdfTix: Int?
    var scannedCompsTix: Int?
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case eventName = "event_name"
        case eventCoverImage = "event_cover_image"
        case totalTicketInEvent = "total_ticket_in_event"
        case tixToScan = "tix_to_scan"
        case tixScanned = "tix_scanned"
        case tixAccepted = "tix_accepted"
        case tixRejected = "tix_rejected"
        case scannedHardTix = "scanned_hard_tix"
        case scannedPdfTix = "scanned_pdf_tix"
        case scannedCompsTix = "scanned_comps_tix"
    }
}
// MARK: Get Scan Summary Data
struct GetScanSummaryData : Codable {
    let items : [GetScanSummaryItem]?
    let total : Int?
    let page : Int?
    let size : Int?
    let pages : String?

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case total = "total"
        case page = "page"
        case size = "size"
        case pages = "pages"
    }
}
struct GetScanSummaryItem: Codable {
    init() {}
    var eventId: Int?
    var orderTicketsId: Int?
    var order: Int?
    var operatorName: String?
    var status: Bool?
    var createdAt: String?
    var createdBy: String?
    var id: Int?
    var qrCode: String?
    var nameOnTix: String?
    var ticketType: String?
    var errorDetail: String?
    var updatedAt: String?
    var updatedBy: String?
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case orderTicketsId = "order_tickets_id"
        case order = "order"
        case operatorName = "operator_name"
        case status = "status"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case id = "id"
        case qrCode = "qr_code"
        case nameOnTix = "name_on_tix"
        case ticketType = "ticket_type"
        case errorDetail = "error_detail"
        case updatedAt = "updated_at"
        case updatedBy = "updated_by"
    }
}
