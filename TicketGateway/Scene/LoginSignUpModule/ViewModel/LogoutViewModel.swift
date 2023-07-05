//
//  LogoutViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 20/04/23.
//

import UIKit
import Foundation


struct LogoutRequestModel : Codable{
    var email : String?
}

class LogoutViewModel {
    func LogoutAPI(complition: @escaping (Bool, String) -> Void) {
      let param = LogoutRequestModel(email: "email")
      APIHandler.shared.executeRequestWith(apiName: .logoutUser, parameters: param, methodType: .POST) { (result: Result<ResponseModal<EmptyModel>, Error>) in
        switch result {
        case .success(let response):
          if response.status_code == 200 {
              complition(true, response.message ?? "")
          }else{
              complition(false, response.message ?? "Error Message")
          }
        case .failure(let error):
          complition(false, "\(error)")
        }
      }
    }
  }
