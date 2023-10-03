//
//  FavoriteRequestModel.swift
//  TicketGateway
//
//  Created by Apple on 04/08/23.


import Foundation
struct FavoriteRequestModel: Codable {
    var eventId: Int?
    var likeStatus: Bool?
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case likeStatus = "like_status"
    }
}
