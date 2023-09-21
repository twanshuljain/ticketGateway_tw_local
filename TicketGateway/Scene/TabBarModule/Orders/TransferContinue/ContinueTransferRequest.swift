//
//  ContinueTransferRequest.swift
//  TicketGateway
//
//  Created by Apple on 04/09/23.
//

import Foundation

struct ContinueTransferRequest: Codable {
    var cellPhone, email, confirmEmail, fullName: String?
    enum CodingKeys: String, CodingKey {
        case cellPhone = "cell_phone"
        case email = "email"
        case confirmEmail = "confirm_email"
        case fullName = "full_name"
    }
}
