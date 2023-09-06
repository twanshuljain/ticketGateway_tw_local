//
//  SignInAuthModel.swift
//  TicketGateway
//
//  Created by Apple  on 19/04/23.
//

import UIKit

struct SignInAuthModel: Codable {
    var id: Int?
    var number: String?
    var fullName, email, accessToken, refreshToken, strDialCountryCode, image: String?
    enum CodingKeys: String, CodingKey {
        case id
        case strDialCountryCode
        case fullName = "full_name"
        case email
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case number = "cell_phone"
        case image
    }
}
