//
//  ValidationConstantStrings.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
//

import UIKit

class ValidationConstantStrings: NSObject {
         // MARK: - Validation Alert messages
        static let emptyEmail = Bundle.main.localizedString(forKey: "Please enter your email address", value: "", table: nil)
        static let emptyNumber = "Please enter number"
       static let invalidNumber = "Please enter valid number"
        static let emptyName = "Please enter full name"
        static let invalidName = "Please enter valid full name"
        static let invalidEmail = "The user email must be a valid email address"
        static let emailNotMatched = "Email and confirm email will be same"
        static let passwordNotMatch = "Password and confirm password are not same"
        static let emptyOtp = "OTP is required"
        static let invalidOtp = "Please enter a valid OTP"
        
        static let emptyPassword = "Please enter password"
        static let emptyNewPassword = "New password is required"
        static let invalidPassword = "Please enter valid password"
        static let invalidNewPassword = "Please enter valid new password"
        static let emptyCurrentPassword = "Current password is required"
        static let emptyConfirmPassword = "Confirm password is required"
        static let invalidCurrentPassword = "Please enter valid current password"
        static let invalidConfirmPassword = "Please enter valid confirm password"
        static let invalidCurrentPasswordMatch = "Current password and new password are not same"
         static let networkLost = "Check Network Availibilty"
    }
