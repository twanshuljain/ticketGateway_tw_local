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
}

// MARK: - Functions
extension ManageEventEditProfileViewModel{
    func collectCountries() {
        for country in countries  {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            self.RScountriesModel.append(CountryInfo(country_code:code,dial_code:dailcode, country_name:name))
        }
    }
}
