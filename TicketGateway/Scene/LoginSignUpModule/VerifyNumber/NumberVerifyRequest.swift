//
//  NumberVerifyRequest.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
// swiftlint: disable identifier_name
import Foundation
struct NumberVerifyRequest: Codable {
    var otp: String?
    var cell_phone: String?
    var email: String?
}
