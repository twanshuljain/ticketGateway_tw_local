//
//  FavoriteRequestModel.swift
//  TicketGateway
//
//  Created by Apple on 04/08/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import Foundation
struct FavoriteRequestModel: Codable {
    var event_id: Int?
    var like_status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case event_id = "event_type"
        case like_status = "like_status"
        
    }
}
