//
//  EventCheckoutVerifyModel.swift
//  TicketGateway
//
//  Created by Apple on 12/10/23.
//

import Foundation

struct CheckEmail: Codable {
    var emailAddress: String?
    
    enum CodingKeys: String, CodingKey {
        case emailAddress = "email"
    }
}


// MARK: - CheckEmailResponse
struct CheckEmailResponse: Codable {
    var email, firstName, lastName, cellPhone: String?
    var id: Int?
    var countryCode: String?

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case cellPhone = "cell_phone"
        case id
        case countryCode = "country_code"
    }
}
