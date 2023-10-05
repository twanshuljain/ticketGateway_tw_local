//
//  FavouriteViewModel.swift
//  TicketGateway
//
//  Created by apple on 8/25/23.
//

import Foundation
class FavouriteViewModel {
    // MARK: All Properties
    var favouriteModel: FavouriteModel = FavouriteModel()
    var venueModel: VenueModel = VenueModel()
    var arrFavouriteList: [GetFavouriteItem] = []
    var arrVenueList: [GetVenueItem] = []
    var totalPageEvent: Int = 0
    var totalPageVenue: Int = 0
    var isForVenue: Bool = false
    var eventDetail: EventDetail?
    var dispatchGroup = DispatchGroup.init()
    var arrSuggestionsList: [GetEventModel] = [GetEventModel]()
    var eventScrollToValue = 0
    var venueScrollToValue = 0
    var eventDetailViewModel = EventDetailViewModel()
    // MARK: Custom Functions
    func getFavouriteList(favouriteModel: FavouriteModel,
                          completion: @escaping (Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(
            apiName: .myFavourite,
            parameters: favouriteModel,
            methodType: .GET
        ) { (result: Result<ResponseModal<GetFavouriteData>, Error>) in
            switch result {
            case .success(let response):
                print("success my favourite api")
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data {
                            self.arrFavouriteList.append(contentsOf: data.items ?? [])
                            self.totalPageEvent = data.total ?? 0
                            completion(true, response.message ?? "")
                        }
                    }
                }
            case .failure(let error):
                print("error", error)
                print("failure my favourite api ")
                completion(false, error as? String ?? "")
            }
        }
    }
    func getVenueList(venueModel: VenueModel,
                      completion: @escaping (Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(
            apiName: .myVenue,
            parameters: venueModel,
            methodType: .GET
        ) { (result: Result<ResponseModal<GetVenueData>, Error>) in
            switch result {
            case .success(let response):
                print("success my Venue api")
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data {
                            self.arrVenueList.append(contentsOf: data.items ?? [])
                            self.totalPageVenue = data.total ?? 0
                            completion(true, response.message ?? "")
                        }
                    }
                }
            case .failure(let error):
                print("error", error)
                print("failure my Venue api ")
                completion(false, error as? String ?? "")
            }
        }
    }
    func getEventDetailApi(eventId: Int, complition: @escaping (Bool, String) -> Void ) {
        let url = APIName.getEventDetail.rawValue + "\(eventId)"  + "/"
        APIHandler.shared.executeRequestWith(apiName: .getEventDetail, parameters: EmptyModel?.none, methodType: .GET, getURL: url, authRequired: true) { (result: Result<ResponseModal<EventDetail>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    defer { self.dispatchGroup.leave() }
                    print("response....",response)
                    DispatchQueue.main.async {
                        self.eventDetail = response.data ?? EventDetail()
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup.leave() }
                complition(false,"\(error)")
            }
        }
    }
}
