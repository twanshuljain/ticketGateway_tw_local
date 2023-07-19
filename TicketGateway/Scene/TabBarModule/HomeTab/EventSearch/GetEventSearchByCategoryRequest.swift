//
//  GetEventSearchRequest.swift
//  TicketGateway
//
//  Created by Apple on 13/07/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import Foundation
struct GetEventSearchByCategoryRequest: Codable {
    var category: String?
    
    
    enum CodingKeys: String, CodingKey {
        case category = "category"
        
    }
}

struct GetEventSearch: Codable {
    
    let search_key: String?
}
