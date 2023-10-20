//
//  GetUserProfileModel.swift
//  TicketGateway
//
//  Created by apple on 8/31/23.
//

import Foundation
import UIKit
struct GetUserProfileModel : Codable {
    var userData : UserData?
    var profileCompletePercentage : Int?
    init() {}
    enum CodingKeys: String, CodingKey {
        case userData = "user_data"
        case profileCompletePercentage = "profile_complete_percentage"
    }
}
struct UserData : Codable {
       var updatedAt, email: String?
       var allowAllTypeOfCards: Bool?
       var allowSuperPromoterLogin, createdBy, gender, country: String?
       var isAdminUser: Bool?
       var updatedBy, dob: String?
       var isVerify, isAdminTourCompleted: Bool?
       var title, homePhone: String?
       var role, image, fullName, cellPhone: String?
       var username: String?
       var countryCode: String?
       var suffix: String?
       var status: String?
       var signature: String?
       var id: Int?
       var password: String?
       var allowToCreateCostume: Bool?
       var adminType: String?
       var createdAt: String?
       var allowToReserveSittings: Bool?
       var firstName, lastName: String?
       var accessToken : String?
    
    
    enum CodingKeys: String, CodingKey {
         case updatedAt = "updated_at"
         case email
         case allowAllTypeOfCards = "allow_all_type_of_cards"
         case allowSuperPromoterLogin = "allow_super_promoter_login"
         case createdBy = "created_by"
         case gender, country
         case isAdminUser = "is_admin_user"
         case updatedBy = "updated_by"
         case dob
         case isVerify = "is_verify"
         case isAdminTourCompleted = "is_admin_tour_completed"
         case title
         case homePhone = "home_phone"
         case role, image
         case fullName = "full_name"
         case cellPhone = "cell_phone"
         case username
         case countryCode = "country_code"
         case suffix, status, signature, id, password
         case allowToCreateCostume = "allow_to_create_costume"
         case adminType = "admin_type"
         case createdAt = "created_at"
         case allowToReserveSittings = "allow_to_reserve_sittings"
         case firstName = "first_name"
         case lastName = "last_name"
     }
}
struct UpdateUserModel {
    var image: UIImage = UIImage()
    var name = ""
}
