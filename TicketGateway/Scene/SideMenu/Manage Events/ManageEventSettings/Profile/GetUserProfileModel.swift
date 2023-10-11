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
    var createdBy : String?
    var gender : String?
    var country : String?
    var isAdminUser : Bool?
    var updatedBy : String?
    var dob : String?
    var isVerify : Bool?
    var isAdminTourCompleted : Bool?
    var title : String?
    var homePhone : String?
    var role : String?
    var image : String?
    var fullName : String?
    var cellPhone : String?
    var username : String?
    var suffix : String?
    var status : String?
    var signature : String?
    var id : Int?
    var password : String?
    var allowToCreateCostume : Bool?
    var adminType : String?
    var createdAt : String?
    var email : String?
    var allowToReserveSittings : Bool?
    var allowSuperPromoterLogin : String?
    var updatedAt : String?
    var allowAllTypeOfCards : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case createdBy = "created_by"
        case gender = "gender"
        case country = "country"
        case isAdminUser = "is_admin_user"
        case updatedBy = "updated_by"
        case dob = "dob"
        case isVerify = "is_verify"
        case isAdminTourCompleted = "is_admin_tour_completed"
        case title = "title"
        case homePhone = "home_phone"
        case role = "role"
        case image = "image"
        case fullName = "full_name"
        case cellPhone = "cell_phone"
        case username = "username"
        case suffix = "suffix"
        case status = "status"
        case signature = "signature"
        case id = "id"
        case password = "password"
        case allowToCreateCostume = "allow_to_create_costume"
        case adminType = "admin_type"
        case createdAt = "created_at"
        case email = "email"
        case allowToReserveSittings = "allow_to_reserve_sittings"
        case allowSuperPromoterLogin = "allow_super_promoter_login"
        case updatedAt = "updated_at"
        case allowAllTypeOfCards = "allow_all_type_of_cards"
    }
}
struct UpdateUserModel {
    var image: UIImage = UIImage()
    var name = ""
}
