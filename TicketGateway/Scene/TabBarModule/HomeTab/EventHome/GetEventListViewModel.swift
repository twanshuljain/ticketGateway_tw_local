//
//  GetEventListViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 30/05/23.
//

import UIKit

final class HomeDashBoardViewModel {

    // MARK: - Variables
    var arrSearchCategoryData = [GetEventModel]()
    var arrEventData = GetEvent()
    var arrEventCategory = [EventCategories]()
    var isLiked: Bool = false
    var dispatchGroup = DispatchGroup.init()
    var dispatchGroup1 = DispatchGroup.init()
    var dispatchGroup2 = DispatchGroup.init()
    var dispatchGroup3 = DispatchGroup.init()
    var dispatchGroup4 = DispatchGroup.init()
    var dispatchGroup5 = DispatchGroup.init()
    var dispatchGroup6 = DispatchGroup.init()

    let semaphore = DispatchSemaphore(value: 1)
    var arrOrganizersList: [Organizers]?

    var arrDataaWeekend = [GetEventModel]()
    var arrDataaVirtual = [GetEventModel]()
    var arrDataaPopular = [GetEventModel]()
    var arrDataaFree = [GetEventModel]()
    var arrDataaUpcoming = [GetEventModel]()
    var eventId: Int?
    var eventDetail: EventDetail?
    var followUnfollow: EventDetail?
    var country: CountryInfo?
    var selectedCountryName: String?
    var currentRegionCountry = Locale.current.localizedString(forRegionCode: Locale.current.regionCode ?? "") ?? "Toronto"
}

// MARK: - Functions
extension HomeDashBoardViewModel {

    func getEventApi(complition: @escaping (Bool,String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .getEventList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[GetEventModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {

                    DispatchQueue.main.async {
                        //self.arrEventData = response.data ?? [GetEventModel]()
                        if var data = response.data{
                           // print(response.data)
                            //data.unique{$0.event!.id! == $1.event!.id! }
                            //self.arrEventData = data
                           // self.arrEventData.itemsWeekend = items
                            self.arrDataaWeekend = data
                        }

                       // print(self.arrEventData)
                        complition(true, response.message ?? "")
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

    func getOrganizersList(complition: @escaping (Bool,String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .getOrganizersList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[Organizers]>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    if let organizersList = response.data{
                        self.arrOrganizersList = organizersList
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

    func getEventAsPerLocation(category: String? = "", countryName: String? = "", sortBy: SortBy? = .noneValue, complition: @escaping (Bool,String) -> Void ) {
       // sortBy = ['POPULAR', 'RECENT', 'PRICE_LOW_TO_HIGH', 'PRICE_HIGH_TO_LOW']
        let parameters =  GetEventSearchByCategoryRequest(countryName: countryName, limit: "3", page: "1")
        APIHandler.shared.executeRequestWith(apiName: .getEventSearchByCategory, parameters: parameters, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {

            case .success(let response):
                defer { self.dispatchGroup.leave() }
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                            //data.unique{$0.event!.id! == $1.event!.id! }
                            self.arrEventData = data
                            self.arrEventData.itemsLocation = items
                            self.arrSearchCategoryData = items
                            if !items.isEmpty {
                                self.arrEventCategory.append(.nearByLocation)
                            } else {
                                self.arrEventCategory.append(.noLocationData)
                            }
                        }
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
    func getEventApiForWeekendEvents(viewAll: Bool,complition: @escaping (Bool,String) -> Void ) {
        let parameters = viewAll == false ? GetEventRequest(eventType: EventType.weekend.rawValue, limit: "3", page: "1"): GetEventRequest(eventType: EventType.weekend.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .getEventListCategoryWise, parameters: parameters, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup1.leave() }
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                            //data.unique{$0.event!.id! == $1.event!.id! }
                            self.arrEventData = data
                            self.arrEventData.itemsWeekend = items
                            self.arrDataaWeekend = items
                            if !items.isEmpty {
                                self.arrEventCategory.append(.weekend)
                            }
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup1.leave() }
                complition(false,"\(error)")
            }
        }
    }

    func getEventApiForOnlineEvents(viewAll: Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == false ? GetEventRequest(eventType: EventType.virtual.rawValue, limit: "3", page: "1"): GetEventRequest(eventType: EventType.virtual.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .getEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup2.leave() }
                if response.statusCode == 200 {

                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                            self.arrEventData = data
                            self.arrEventData.itemsVirtual = items
                            self.arrDataaVirtual = items
                            if !items.isEmpty {
                                self.arrEventCategory.append(.online)
                            }
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup2.leave() }
                complition(false,"\(error)")
            }
        }
    }

    func getEventApiForPopularEvents(viewAll: Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == false ? GetEventRequest(eventType: EventType.popular.rawValue, limit: "3", page: "1"): GetEventRequest(eventType: EventType.popular.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .getEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    defer { self.dispatchGroup3.leave() }
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                            self.arrEventData = data
                            self.arrEventData.itemsPopular = items
                            self.arrDataaPopular = items
                            if !items.isEmpty {
                                self.arrEventCategory.append(.popular)
                            }
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup3.leave() }
                complition(false,"\(error)")
            }
        }
    }

    func getEventApiForFreeEvents(viewAll: Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == false ? GetEventRequest(eventType: EventType.free.rawValue, limit: "3", page: "1"): GetEventRequest(eventType: EventType.free.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .getEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    defer { self.dispatchGroup4.leave() }
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                            self.arrEventData = data
                            self.arrEventData.itemsFree = items
                            self.arrDataaFree = items
                            if !items.isEmpty {
                                self.arrEventCategory.append(.free)
                            }
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup4.leave() }
                complition(false,"\(error)")
            }
        }
    }

    func getEventApiForUpcomingEvents(viewAll: Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == false ? GetEventRequest(eventType: EventType.upcoming.rawValue, limit: "3", page: "1"): GetEventRequest(eventType: EventType.upcoming.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .getEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    defer { self.dispatchGroup5.leave() }
                    DispatchQueue.main.async {
                        if let data = response.data, let items = data.items{
                            self.arrEventData = data
                            self.arrEventData.itemsUpcoming = items
                            self.arrDataaUpcoming = items
                            if !items.isEmpty {
                                self.arrEventCategory.append(.upcoming)
                            }
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup5.leave() }
                complition(false,"\(error)")
            }
        }
    }
    func getEventDetailApi(eventId: Int, complition: @escaping (Bool,String) -> Void ) {
        let url = APIName.getEventDetail.rawValue + "\(eventId)"  + "/"
        APIHandler.shared.executeRequestWith(apiName: .getEventDetail, parameters: EmptyModel?.none, methodType: .GET, getURL: url, authRequired: true) { (result: Result<ResponseModal<EventDetail>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    defer { self.dispatchGroup6.leave() }
                    print("response....",response)
                    DispatchQueue.main.async {
                        self.eventDetail = response.data ?? EventDetail()
                        print("--------------------",self.eventDetail)
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                } else {
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup6.leave() }
                complition(false,"\(error)")
            }
        }
    }
}
