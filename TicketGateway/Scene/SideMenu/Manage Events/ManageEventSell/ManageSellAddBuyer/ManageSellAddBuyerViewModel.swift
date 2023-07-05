//
//  ManageSellAddBuyerViewModel.swift
//  TicketGateway
//
//  Created by Apple on 22/06/23.
//

import Foundation

final class ManageSellAddBuyerViewModel{
    // MARK: - Variable
    var isFromWelcomeScreen = false
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var countries = [[String: String]]()
    var RScountriesModel = [CountryInfo]()
    var isFromAddInfo = false
    var ToupleBuyerInfoData = (strNameValue:"",strEmailValue:"",strNumberValue:"",strCountryCodeValue:"",strDialCodeValue:"")
    
}
// MARK: - Functions
extension ManageSellAddBuyerViewModel{
    func collectCountries() {
        for country in countries  {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            RScountriesModel.append(CountryInfo(country_code:code,dial_code:dailcode, country_name:name))
        }
    }
}
