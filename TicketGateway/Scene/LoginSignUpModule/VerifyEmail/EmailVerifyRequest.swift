//
//  VerifyEmailRequest.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
//

import Foundation

struct EmailVerifyRequest: Codable {
  let email: String
  let otp: String
}
