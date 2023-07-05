//
//  ForgotPasswordModel.swift
//  TicketGateway
//
//  Created by Apple  on 19/04/23.
//

import Foundation

// MARK: - ForgotPasswordRequestModel
struct ForgotPasswordRequestModel: Codable {
    let email: String
}

// MARK: - ForgotPasswordModel

struct ForgotPasswordModel: Codable {
  var resetTokenExpiration: String?
  var userID, id: Int?
  var resetToken: String?
  var isVerify: Bool?
    
  enum CodingKeys: String, CodingKey {
    case resetTokenExpiration = "reset_token_expiration"
    case userID = "user_id"
    case id
    case resetToken = "reset_token"
    case isVerify = "is_verify"
  }
}








