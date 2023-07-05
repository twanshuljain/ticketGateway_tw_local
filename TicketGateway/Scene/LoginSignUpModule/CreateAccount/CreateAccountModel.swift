//
//  CreateAccountModel.swift
//  TicketGateway
//
//  Created by Apple  on 19/04/23.
//

import UIKit

// MARK: - DataClass
struct UserAccountModel: Codable {
  var title, homePhone: String?
  var role, fullName, cellPhone: String?
  var username, suffix, status, signature: String?
  var id: Int?
  var password: String?
  var allowToCreateCostume: Bool?
  var adminType: String?
  var createdAt, email: String?
  var allowToReserveSittings: Bool?
  var allowSuperPromoterLogin: String?
  var updatedAt: String?
  var gender: String?
  var allowAllTypeOfCards, isAdminUser: Bool?
  var createdBy, dob, country: String?
  var isAdminTourCompleted: Bool?
  var updatedBy: String?
  var isVerify: Bool?
  enum CodingKeys: String, CodingKey {
    case title
    case homePhone = "home_phone"
    case role
    case fullName = "full_name"
    case cellPhone = "cell_phone"
    case username, suffix, status, signature, id, password
    case allowToCreateCostume = "allow_to_create_costume"
    case adminType = "admin_type"
    case createdAt = "created_at"
    case email
    case allowToReserveSittings = "allow_to_reserve_sittings"
    case allowSuperPromoterLogin = "allow_super_promoter_login"
    case updatedAt = "updated_at"
    case gender
    case allowAllTypeOfCards = "allow_all_type_of_cards"
    case isAdminUser = "is_admin_user"
    case createdBy = "created_by"
    case dob, country
    case isAdminTourCompleted = "is_admin_tour_completed"
    case updatedBy = "updated_by"
    case isVerify = "is_verify"
  }
}



