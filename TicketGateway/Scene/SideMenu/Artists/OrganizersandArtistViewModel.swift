//
//  OrganizersandArtistViewModel.swift
//  TicketGateway
//
//  Created by Apple on 28/07/23.
//

import Foundation
class OrganizersandArtistViewModel {
    // MARK: All Properties
    var arrSuggestedIssFollow: [Int] = []
    var arrIssFollow: [Int] = []
    var arrOrganizersListSideMenu: [Organizers]?
    var arrSuggestedOrganizers: [GetSuggestedOrganizerItemModel] = []
    func getOrganizersList(complition: @escaping (Bool,String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .getOrganizersList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[Organizers]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    if let organizersList = response.data{
                        self.arrOrganizersListSideMenu = organizersList
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                complition(false,"\(error)")
            }
        }
    }
    func getOrganizersSuggestedList(complition: @escaping (Bool, String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .organizerSuggestedList, parameters: EmptyModel?.none, methodType: .GET, authRequired: true) { (result: Result<ResponseModal<GetSuggestedOrganizerDataModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    if let suggestedOrganizersList = response.data {
                        self.arrSuggestedOrganizers = suggestedOrganizersList.items ?? []
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                complition(false,"\(error)")
            }
        }
    }
}
