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
    var filter_by: String = ""
    var search_query: String = ""
    var sort_by: String = ""
}
