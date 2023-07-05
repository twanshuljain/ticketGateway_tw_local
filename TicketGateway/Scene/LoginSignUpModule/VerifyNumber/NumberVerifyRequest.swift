//
//  NumberVerifyRequest.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
//

import Foundation

struct NumberVerifyRequest: Codable {
  let otp: String
    let cell_phone : String
}
