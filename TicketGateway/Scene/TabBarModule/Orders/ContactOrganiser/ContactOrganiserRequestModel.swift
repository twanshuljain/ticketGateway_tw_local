//
//  ContactOrganiserRequestModel.swift
//  TicketGateway
//
//  Created by Apple on 28/08/23.
//

import UIKit
struct ContactOrganiserRequestModel: Codable {
    var name, email, reason, message : String?
    var organizerId : Int?
    
    enum CodingKeys: String, CodingKey {
        case name, email, reason, message
        case organizerId = "organizer_id"
    }
}
