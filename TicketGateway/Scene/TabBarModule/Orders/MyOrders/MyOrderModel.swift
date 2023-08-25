//
//  MyOrdersModel.swift
//  TicketGateway
//
//  Created by Apple on 22/08/23.
//

import Foundation
struct MyOrdersModel: Encodable {
    var pageNumber: Int = 1
    var pageLimit: Int = 10
    var filterBy: String = "upcoming"
    var searchText: String = ""
    var sortBy: String = "all"
}
