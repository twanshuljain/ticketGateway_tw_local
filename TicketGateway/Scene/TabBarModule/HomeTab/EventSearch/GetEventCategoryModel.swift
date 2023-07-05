//
//  GetEventModel.swift
//  TicketGateway
//
//  Created by Apple  on 05/06/23.
//

import Foundation

struct GetEventCategoryModel: Codable {
    var id: Int?
    var name: String?
    var status: Bool?
    var image: String?
    var isActive: Bool?
    var url, description: String?
    var order: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name, status, image
        case isActive = "is_active"
        case url, description, order
    }
}

