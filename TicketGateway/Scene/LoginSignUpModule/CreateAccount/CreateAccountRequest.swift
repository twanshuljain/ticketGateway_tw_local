//
//  CreateAccountRequest.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
//

import Foundation

struct CreateAccountRequest: Codable {
  let fullName: String
  let mobileNumber: String
  let emailAddress: String
  let password: String
  let confimePassword: String
  let role: String
  let isVerify: Bool
  enum CodingKeys: String, CodingKey {
    case fullName = "full_name"
    case emailAddress = "email"
    case mobileNumber = "cell_phone"
    case password = "password"
    case confimePassword = "confirm_password"
    case role = "role"
    case isVerify = "is_verify"
  }
}
