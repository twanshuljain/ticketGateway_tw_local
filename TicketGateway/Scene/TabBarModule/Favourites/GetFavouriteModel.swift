//
//  GetFavouriteModel.swift
//  TicketGateway
//
//  Created by apple on 8/25/23.
//

import Foundation
struct GetFavouriteResponse : Codable {
    let data : GetFavouriteData?
    let status_code : Int?
    let message : String?
    let error : String?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case status_code = "status_code"
        case message = "message"
        case error = "error"
    }
}

struct GetFavouriteData : Codable {
    let items : [GetFavouriteItem]?
    let total : Int?
    let page : Int?
    let size : Int?
    let pages : String?
    
    enum CodingKeys: String, CodingKey {
        
        case items = "items"
        case total = "total"
        case page = "page"
        case size = "size"
        case pages = "pages"
    }
}
struct GetFavouriteItem : Codable {
    let eventTitle : String?
    let coverImage : GetFavouriteCoverImage?
    let totalLike : Int?
    let location : String?
    let eventCountry : String?
    let eventId : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case eventTitle = "event_title"
        case coverImage = "cover_image"
        case totalLike = "total_like"
        case location = "location"
        case eventCountry = "event_country"
        case eventId = "event_id"
    }
}

struct GetFavouriteCoverImage : Codable {
    let eventAdditionalCoverImages : [String]?
    let eventCoverImage : String?
    let id : Int?
    let eventId : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case eventAdditionalCoverImages = "event_additional_cover_images"
        case eventCoverImage = "event_cover_image"
        case id = "id"
        case eventId = "event_id"
    }
}
// MARK: Get Venue Data
struct GetVenueData : Codable {
    let items : [GetVenueItem]?
    let total : Int?
    let page : Int?
    let size : Int?
    let pages : String?
    
    enum CodingKeys: String, CodingKey {
        
        case items = "items"
        case total = "total"
        case page = "page"
        case size = "size"
        case pages = "pages"
    }
}
struct GetVenueItem: Codable {
    let id: Int?
    let venueName: String?
    let image: String?
    let totalLike: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case venueName = "venue_name"
        case totalLike = "total_like"
    }
}
