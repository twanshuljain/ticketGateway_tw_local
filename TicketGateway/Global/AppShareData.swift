//
//  AppShareData.swift
//  TicketGateway
//
//  Created by Apple  on 20/04/23.
//

import UIKit
import Foundation

let objAppShareData = AppShareData.sharedObject()

class AppShareData {
    //MARK: - Shared object
    private static var sharedManager: AppShareData = {
        let manager = AppShareData()
        //        var strUSERID : String = ""
        return manager
    }()
    // MARK: - Accessors
    class func sharedObject() -> AppShareData {
        return sharedManager
    }
    //NewVariable
   
    var DicToHoldDataOnSignUpModule : DataHoldOnSignUpProcessModel?
    var userAuth = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
    
}
