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
    enum CodingKeys: String, CodingKey {
        case cellphone = "cell_phone"
    }
}
struct SignInNumberWithEmailRequest: Codable {
    let email: String?
}


struct ValidateForNumberRequest: Codable {
    var cell_phone: String?
    var email: String?
    var country_code: String?
    var first_name: String?
    var last_name: String?
}
