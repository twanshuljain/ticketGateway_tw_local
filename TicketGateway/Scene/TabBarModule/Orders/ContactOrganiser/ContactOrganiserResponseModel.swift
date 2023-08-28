//
//  ContactOrganiserResponseModel.swift
//  TicketGateway
//
//  Created by Apple on 28/08/23.
//

import Foundation

// MARK: - DataClass
struct ContactOrganiserResponseModel: Codable {
    var email: String?
    var id: Int?
    var message: String?
    var organizerID: Int?
    var createdAt: String?
    var name, reason: String?
    var userID: Int?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case email, id, message
        case organizerID = "organizer_id"
        case createdAt = "created_at"
        case name, reason
        case userID = "user_id"
        case updatedAt = "updated_at"
    }
}
