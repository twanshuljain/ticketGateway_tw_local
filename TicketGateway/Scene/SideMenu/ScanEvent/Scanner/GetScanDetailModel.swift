//
//  GetScanDetailModel.swift
//  TicketGateway
//
//  Created by apple on 9/7/23.
//

import Foundation
struct GetScanDetailData: Codable {
    var acceptedCount: Int?
    var rejectedCount: Int?
    var totalCount: Int?
    enum CodingKeys: String, CodingKey {
        case acceptedCount = "accepted_count"
        case rejectedCount = "rejected_count"
        case totalCount = "total_count"
    }
}
