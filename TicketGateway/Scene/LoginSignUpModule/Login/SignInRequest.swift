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
}
struct SignInNumberWithEmailRequest: Codable {
    let email: String?
}
