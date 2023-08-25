//
//  FavouriteModel.swift
//  TicketGateway
//
//  Created by apple on 8/25/23.
//

import Foundation
struct FavouriteModel: Encodable {
    var limit: Int = 10
    var page: Int = 1
}
struct VenueModel: Encodable {
    var pageLimit: Int = 10
    var pageNumber: Int = 1
}
