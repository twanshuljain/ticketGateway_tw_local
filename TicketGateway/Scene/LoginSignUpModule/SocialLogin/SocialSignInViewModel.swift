//
//  SocialSignInViewModel.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
//

import Foundation
import UIKit

final class SocialSignInViewModel {
    // MARK: - Variable
    var vc : SocialSignInVC?
    var strEmail: String = ""
    var strName: String = ""
    var strUserID : String = ""
    var strProfile : String = ""
    var strNumber : String = ""
    var strSocialId : String = ""
    
    init(){
    }
    init(vc:SocialSignInVC) {
        self.vc = vc
    }
    
}
