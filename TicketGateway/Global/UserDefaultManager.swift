//
//  UserDefaultManager.swift
//  TicketGateway
//
//  Created by Apple  on 19/04/23.
//

import UIKit

import Foundation
import SwiftUI

class UserDefaultManager {
    
    static let share = UserDefaultManager()
    
    let defaults = UserDefaults.standard
    
    func storeModelToUserDefault<T>(userData: T, key: UserDefaultModelKeys) where T: Codable {
        defaults.set(try? JSONEncoder().encode(userData), forKey: key.rawValue)
    }
    
    func getModelDataFromUserDefults<T: Codable>(userData: T.Type, key: UserDefaultModelKeys) -> T? {
        print(userData)
        guard let data = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        guard let value = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("unable to decode this data")
        }
        return value
    }
    
    func getDataFromUserDefults(key: UserDefaultModelKeys) {
        
    }
    
    func clearAllUserDataAndModel() {
        removeUserdefultsKey(key: .userAuthData)
        
    }
    
    func removeUserdefultsKey(key: UserDefaultKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func removeUserDefualtsModels(key: UserDefaultModelKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}

extension UserDefaultManager {
    func setUserLoginUserDefaultValue(value: [String: Any], key: UserDefaultKeys) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    func getUserLoginUserDefaultValue(key: UserDefaultKeys) -> [String: Any] {
        return UserDefaults.standard.value(forKey: key.rawValue) as? [String: Any] ?? [:]
    }
    
    func setUserStressLevelValue(value: Date, key: UserDefaultKeys) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    func getUserStressLevelValue(key: UserDefaultKeys) -> Date? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? Date ?? nil
    }
    
    func setUserBoolValue(value: Bool, key: UserDefaultKeys) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    func getUserBoolValue(key: UserDefaultKeys) -> Bool {
        return UserDefaults.standard.value(forKey: key.rawValue) as? Bool ?? false
    }
    
    func setUserStirngValue(value: String, key: UserDefaultKeys) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    func getUserStirngValue(key: UserDefaultKeys) -> String {
        return UserDefaults.standard.value(forKey: key.rawValue) as? String ?? ""
    }
}
