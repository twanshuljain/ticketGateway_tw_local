//
//  CreateAccountRequest.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
//

import Foundation

struct CreateAccountRequest: Codable {
    let firstName: String
    let lastName: String
    let mobileNumber: String
    let emailAddress: String
    let password: String
    let confimePassword: String
    let role: String
    let isVerify: Bool
    let countryCode: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case emailAddress = "email"
        case mobileNumber = "cell_phone"
        case password = "password"
        case confimePassword = "confirm_password"
        case role = "role"
        case isVerify = "is_verify"
        case countryCode =  "countryCode"
    }
}
