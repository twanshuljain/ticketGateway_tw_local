//
//  NumberVerifyRequest.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
// swiftlint: disable identifier_name
import Foundation
struct NumberVerifyRequest: Codable {
    let otp: String
    let cell_phone: String
}
