//
//  MyOrdersModel.swift
//  TicketGateway
//
//  Created by Apple on 22/08/23.
//

import Foundation
struct MyOrdersModel: Encodable {
    var page: Int = 1
    var limit: Int = 10
    var filterBy: String = ""
    var searchQuery: String = ""
    var sortBy: String = ""
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case limit = "limit"
        case filterBy = "filter_by"
        case searchQuery = "search_query"
        case sortBy = "sort_by"
    }
}
