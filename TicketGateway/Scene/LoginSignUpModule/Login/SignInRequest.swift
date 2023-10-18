//
//  SignInRequest.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
import Foundation
struct SignInRequest: Codable {
    let emailPhone: String?
    let password: String?
    enum CodingKeys: String, CodingKey {
        case emailPhone = "email_phone"
        case password = "password"
    }
}
struct SignInForNumberRequest: Codable {
    let cellphone: String?
    let countryCode: String?
    enum CodingKeys: String, CodingKey {
        case cellphone = "cell_phone"
        case countryCode = "country_code"
    }
}
struct SignInNumberWithEmailRequest: Codable {
    let email: String?
}


struct ValidateForNumberRequest: Encodable {
    var cellPhone: String?
    var email: String?
    var countryCode: String?
    var firstName: String?
    var lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case cellPhone = "cell_phone"
        case email
        case countryCode = "country_code"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
