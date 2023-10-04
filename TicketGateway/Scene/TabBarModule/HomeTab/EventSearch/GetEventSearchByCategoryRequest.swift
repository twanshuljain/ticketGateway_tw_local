//
//  GetEventSearchRequest.swift
//  TicketGateway
//
//  Created by Apple on 13/07/23.

import Foundation

enum SortBy: String {
    case popular = "POPULAR"
    case recent = "RECENT"
    case priceLowToHigh = "PRICE_LOW_TO_HIGH"
    case priceHighToLow = "PRICE_HIGH_TO_LOW"
    case noneValue = ""
}

struct GetEventSearchByCategoryRequest: Codable {
    var category: String?
    var countryName: String?
    var sortBy: String?
    var limit: String?
    var page: String?
    enum CodingKeys: String, CodingKey {
        case category = "category"
        case countryName = "countryName"
        case sortBy = "sort_by"
        case limit
        case page
    }
}

struct GetEventSearch: Codable {
    let searchKey: String?
    enum CodingKeys: String, CodingKey {
        case searchKey = "search_key"
    }
}
