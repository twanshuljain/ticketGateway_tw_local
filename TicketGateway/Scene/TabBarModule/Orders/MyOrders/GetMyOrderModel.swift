//
//  GetMyOrderModel.swift
//  TicketGateway
//
//  Created by Apple on 22/08/23.
//

import Foundation
import UIKit
struct GetMyOrderResponse: Codable {
    var data: GetMyOrderData?
    var statusCode: Int?
    var message: String?
    var error: String?
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case statusCode = "status_code"
        case message = "message"
        case error = "error"
    }
}
struct GetMyOrderData: Codable {
    var items: [GetMyOrderItem]?
    var total: Int?
    var page: Int?
    var size: Int?
    var pages: Int?
    enum CodingKeys: String, CodingKey {
        case items = "items"
        case total = "total"
        case page = "page"
        case size = "size"
        case pages = "pages"
    }
}
struct GetMyOrderItem: Codable {
    var eventTitle: String?
    var eventId: Int?
    var coverImage: MyOrderCoverImage?
    var location: String?
    var eventStartDate: String?
    var eventEndDate: String?
    enum CodingKeys: String, CodingKey {
        case eventTitle = "event_title"
        case eventId = "event_id"
        case coverImage = "cover_image"
        case eventStartDate = "event_start_date"
        case eventEndDate = "event_end_date"
    }
}
struct MyOrderCoverImage: Codable {
    var eventId: Int?
    var eventAdditionalCoverImages: [String]?
    var eventCoverImage: String?
    var id: Int?
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case eventAdditionalCoverImages = "event_additional_cover_images"
        case eventCoverImage = "event_cover_image"
    }
}
