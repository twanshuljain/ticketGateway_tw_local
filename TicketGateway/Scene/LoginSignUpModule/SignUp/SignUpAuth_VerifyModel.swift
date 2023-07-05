//
//  SignUpAuth_VerifyModel.swift
//  TicketGateway
//
//  Created by Apple  on 19/04/23.
//

import UIKit

import Foundation
// MARK: - SignUpAuth_VerifyModel
struct SignUpAuth_VerifyModel: Codable {
 
  var statusCode: Int?
  var message: String?
  var error: String?
  var data : [EmailListUser]
    
  enum CodingKeys: String, CodingKey {
    case data
    case statusCode = "status_code"
    case message, error
  }
}

struct EmailListUser : Codable {
    var name : String?
    var email : String?
    enum CodingKeys : String,CodingKey{
    case name = "full_name"
    case email = "email"
    }
}










