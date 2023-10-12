//
//  GetFavouriteModel.swift
//  TicketGateway
//
//  Created by apple on 8/25/23.
//

import Foundation

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
    let eventTitle: String?
    let coverImage: GetFavouriteCoverImage?
    let totalLike: Int?
    let location: String?
    let eventCountry: String?
    let eventId: Int?
    let eventStartDate: String?
    let eventEndDate: String?
    let eventStartTime: String?
    let eventEndTime: String?
    let locationType: String?
    let isMultiLocation: Bool?
    enum CodingKeys: String, CodingKey {
        case eventTitle = "event_title"
        case coverImage = "cover_image"
        case totalLike = "total_like"
        case location = "location"
        case eventCountry = "event_country"
        case eventId = "event_id"
        case eventStartDate = "event_start_date"
        case eventEndDate = "event_end_date"
        case eventStartTime = "event_start_time"
        case eventEndTime = "event_end_time"
        case locationType = "location_type"
        case isMultiLocation = "is_multi_location"
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
    let website : String?
    let isApproved : Bool?
    let userId : String?
    let minimumAge : String?
    let id : Int?
    let address : String?
    let isVerified : Bool?
    let isActive : Bool?
    let createdAt : String?
    let state : String?
    let facebookId : String?
    let crowd : String?
    let updatedAt : String?
    let city : String?
    let linkedinId : String?
    let dressCode : String?
    let createdBy : String?
    let zipCode : String?
    let instagramId : String?
    let music : String?
    let updatedBy : String?
    let image : String?
    let youtubeId : String?
    let description : String?
    let venueName : String?
    let eventId : String?
    let cellPhone : String?
    let price : String?
    let venueTypeId : Int?
    let ratio : String?
    let venueTypeName : String?
    let isLike : Bool?
    let totalLike : Int?
    let matchingEventCount: Int?
    enum CodingKeys: String, CodingKey {
        case website = "website"
        case isApproved = "is_approved"
        case userId = "user_id"
        case minimumAge = "minimum_age"
        case id = "id"
        case address = "address"
        case isVerified = "is_verified"
        case isActive = "is_active"
        case createdAt = "created_at"
        case state = "state"
        case facebookId = "facebook_id"
        case crowd = "crowd"
        case updatedAt = "updated_at"
        case city = "city"
        case linkedinId = "linkedin_id"
        case dressCode = "dress_code"
        case createdBy = "created_by"
        case zipCode = "zip_code"
        case instagramId = "instagram_id"
        case music = "music"
        case updatedBy = "updated_by"
        case image = "image"
        case youtubeId = "youtube_id"
        case description = "description"
        case venueName = "venue_name"
        case eventId = "event_id"
        case cellPhone = "cell_phone"
        case price = "price"
        case venueTypeId = "venue_type_id"
        case ratio = "ratio"
        case venueTypeName = "venue_type_name"
        case isLike = "is_like"
        case totalLike = "total_like"
        case matchingEventCount = "matching_event_count"
    }
}
