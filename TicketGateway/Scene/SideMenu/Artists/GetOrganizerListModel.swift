//
//  OrganizerListModel.swift
//  TicketGateway
//
//  Created by apple on 9/1/23.
//

import Foundation
struct GetSuggestedOrganizerDataModel: Codable {
    var items: [GetSuggestedOrganizerItemModel]?
    var total: Int?
    var page: Int?
    var size: Int?
    var pages: String?
    enum CodingKeys: String, CodingKey {
        case items = "items"
        case total = "total"
        case page = "page"
        case size = "size"
        case pages = "pages"
    }
}
struct GetSuggestedOrganizerItemModel: Codable {
    var name: String?
    var isEmailOptIn: Bool?
    var isFeatured: Bool?
    var profileImage: String?
    var userId: Int?
    var website: String?
    var isActive: Bool?
    var bio: String?
    var createdAt: String?
    var eventDescription: String?
    var updatedAt: String?
    var facebookId: String?
    var createdBy: String?
    var id: Int?
    var twitterId: String?
    var updatedBy: String?
    var instagramId: String?
    var follower: [Int]?
    var isFollow: Bool?
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case isEmailOptIn = "is_email_opt_in"
        case isFeatured = "is_featured"
        case profileImage = "profile_image"
        case userId = "user_id"
        case website = "website"
        case isActive = "is_active"
        case bio = "bio"
        case createdAt = "created_at"
        case eventDescription = "event_description"
        case updatedAt = "updated_at"
        case facebookId = "facebook_id"
        case createdBy = "created_by"
        case id = "id"
        case twitterId = "twitter_id"
        case updatedBy = "updated_by"
        case instagramId = "instagram_id"
        case follower = "follower"
        case isFollow = "is_follow"
    }
    mutating func changeIsFollow(isFollow: Bool) {
        self.isFollow = isFollow
    }
}
