//
//  LoginNmberWithEmailViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 25/04/23.
//

import UIKit
import Foundation

final class LoginNmberWithEmailViewModel {
    // MARK: - Variable
    var countryCode: String = ""
    var Image: String = ""
    var number : String = ""
    var strSelectedEmail : String = ""
    var arrMail : [EmailListUser] = [EmailListUser]()
    var objUserModel: SignInAuthModel?
    let nameFormatter = PersonNameComponentsFormatter()
    var vc:LoginNmberWithEmailVC?
    
    init() {
    }
    init(vc:LoginNmberWithEmailVC) {
        self.vc = vc
    }
}
// MARK: - Functions
extension LoginNmberWithEmailViewModel{
    
    func funcpersonNameComponents(strValue: String) -> String
    {
        var  fristName = ""
        var  lastNames = ""
        if let nameComps  = self.nameFormatter.personNameComponents(from: strValue) {
            if let  firstLetter = nameComps.givenName?.first {
                fristName = String(firstLetter)
            }
            
            if let lastName = nameComps.familyName?.first {
                lastNames = String(lastName)
            }
            return "\(fristName)\(lastNames)".uppercased()
        }
        return "\(fristName)\(lastNames)".uppercased()
    }
    
    func signInAPI(complition: @escaping (Bool,String) -> Void ) {
        let paramForEmail = SignInNumberWithEmailRequest(email: strSelectedEmail)
          APIHandler.shared.executeRequestWith(apiName: .signInUserByNumber_Email, parameters: paramForEmail, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        DispatchQueue.main.async {
                           
                                self.objUserModel = response.data
                            
                            
                                UserDefaultManager.share.storeModelToUserDefault(userData: self.objUserModel, key: .userAuthData)
                           
                        }
                        complition(true, response.message ?? "")
                    }else{
                        complition(false,response.message ?? "error message")
                    }
                case .failure(let error):
                    complition(false,"\(error)")
                }
            }
        }
    }
