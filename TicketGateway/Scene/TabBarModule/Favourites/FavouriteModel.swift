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
    var limit: Int = 10
    var page: Int = 1
}
struct VenueLikeDislikeModel: Encodable {
    var venueId: Int = 0
    var likeStatus: Bool = false
    enum CodingKeys: String, CodingKey {
        case venueId = "venue_id"
        case likeStatus = "like_status"
    }
}
