//
//  AuthoriseUserModel.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
//

import Foundation
import UIKit


// MARK: - holdDataModel
class DataHoldOnSignUpProcessModel: Codable {
  var strEmail: String?
  var strNumber: String?
  var strDialCountryCode : String?
  var strCountryCode : String?
  var strStatus: String?
    init(strEmail: String? = nil, strNumber: String? = nil, strStatus: String? = nil,strDialCountryCode: String? = nil,strCountryCode:String? = nil) {
        self.strEmail = strEmail
        self.strNumber = strNumber
        self.strStatus = strStatus
        self.strDialCountryCode = strDialCountryCode
        self.strCountryCode = strCountryCode
    }
}


class DataHoldOnSocialSignUpProcessModel: Codable {
  var strProfile :String?
  var strName : String?
  var strEmail: String?
  var strNumber: String?
  var strDialCountryCode : String?
  var strCountryCode : String?
  var strStatus: String?
  var strSocialID : String?
    init(strEmail: String? = nil, strNumber: String? = nil, strStatus: String? = nil,strDialCountryCode: String? = nil,strCountryCode:String? = nil,strName:String? = nil,strProfile:String? = nil) {
        self.strEmail = strEmail
        self.strNumber = strNumber
        self.strStatus = strStatus
        self.strDialCountryCode = strDialCountryCode
        self.strCountryCode = strCountryCode
        self.strName = strName
        self.strProfile = strProfile
    }
}

// MARK: - EmptyModel
struct EmptyModel: Codable {
}

