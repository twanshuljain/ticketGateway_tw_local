//
//  ManageEventEditProfileViewModel.swift
//  TicketGateway
//
//  Created by Apple on 22/06/23.
//

import Foundation

final class ManageEventEditProfileViewModel{

    // MARK: - Variable
    var isFromWelcomeScreen = false
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var countries = [[String: String]]()
    var RScountriesModel = [CountryInfo]()
    var getUserProfileData = GetUserProfileModel()
    var updateUserModel = UpdateUserModel()
}

// MARK: - Functions
extension ManageEventEditProfileViewModel{
    func collectCountries() {
        for country in countries  {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            self.RScountriesModel.append(CountryInfo(
                countryCode: code, dialCode: dailcode, countryName: name
            ))
        }
    }
    func updateUserProfileData(complition: @escaping (Bool, String) -> Void ) {
        AppShareData.sharedObject().updateUserProfile(methodType: .POST, parameters: updateUserModel) { (result: Result<GetUserProfileModel, Error>) in
            switch result {
            case .success(let response):
                print("response....",response)
                DispatchQueue.main.async {
                    self.getUserProfileData = response
                    complition(true, "success")
                }
            case .failure(let error):
                complition(false,"\(error)")
            }
        }
    }
}
