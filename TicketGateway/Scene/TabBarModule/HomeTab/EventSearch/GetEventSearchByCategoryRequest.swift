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

enum SortBy:String {
case POPULAR = "POPULAR"
case RECENT = "RECENT"
case PRICE_LOW_TO_HIGH = "PRICE_LOW_TO_HIGH"
case PRICE_HIGH_TO_LOW = "PRICE_HIGH_TO_LOW"
case None = ""
}


struct GetEventSearchByCategoryRequest: Codable {
    var category: String?
    var countryName:String?
    var sortBy:String?
    var limit: String?
    var page: String?
    
    enum CodingKeys: String, CodingKey {
        case category = "category"
        case countryName = "country_name"
        case sortBy = "sort_by"
        case limit
        case page
    }
}

struct GetEventSearch: Codable {
    
    let search_key: String?
}
