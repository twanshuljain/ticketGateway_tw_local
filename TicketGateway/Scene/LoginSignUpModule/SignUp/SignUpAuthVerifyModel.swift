//
//  SignUpAuth_VerifyModel.swift
//  TicketGateway
//
//  Created by Apple  on 19/04/23.

import UIKit
import Foundation

// MARK: - SignUpAuth_VerifyModel
struct EmailListUser: Codable {
    var name: String?
    var email: String?
    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case email = "email"
    }
}
