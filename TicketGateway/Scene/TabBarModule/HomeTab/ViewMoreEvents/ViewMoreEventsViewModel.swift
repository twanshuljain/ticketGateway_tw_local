//
//  ViewMoreEventsViewModel.swift
//  TicketGateway
//
//  Created by Apple on 13/07/23.
//
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import UIKit

enum IsComingFromForViewMore{
    case Home
    case EventDetail
}

final class ViewMoreEventsViewModel {
    
    //MARK: - Variables
   // var arrData:GetEvent?
    var index = 0
    var arrEventCategory = [EventCategories]()
    var currentPage = 1
    var totalPage = 1
    let refreshControl = UIRefreshControl()
    var isComingFrom = IsComingFromForViewMore.Home
    var categoryId:Int?
    var eventId: Int = 0
    var itemsWeekend = [GetEventModel]()
    var itemsVirtual = [GetEventModel]()
    var itemsPopular = [GetEventModel]()
    var itemsFree = [GetEventModel]()
    var itemsUpcoming = [GetEventModel]()
    var itemsLocation = [GetEventModel]()
    var itemsSuggestedEvents = [GetEventModel]()
    var isLikedAnyEvent: Bool = false
    var countryName = "Toronto"
}

//MARK: - Functions
extension ViewMoreEventsViewModel: FavouriteAction {
    func getEventAsPerLocation(viewAll:Bool, category:String? = "", countryName:String? = "", sortBy:SortBy? = .None, complition: @escaping (Bool,String) -> Void ) {
       // sortBy = ['POPULAR', 'RECENT', 'PRICE_LOW_TO_HIGH', 'PRICE_HIGH_TO_LOW']
        let parameters =  viewAll == true ? GetEventSearchByCategoryRequest(countryName: countryName, limit: "10", page: "\(self.currentPage)") : GetEventSearchByCategoryRequest(countryName: countryName)
        
        APIHandler.shared.executeRequestWith(apiName: .GetEventSearchByCategory, parameters: parameters, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    if let data = response.data, let items = data.items{
                            //self.arrData = data
                            self.totalPage = response.data?.total ?? 0
                            self.itemsLocation.append(contentsOf: items)
                        complition(true, response.message ?? "")
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
    
    func GetEventSuggestedCategory(viewAll:Bool, complition: @escaping (Bool,String) -> Void ) {
        let parameters = GetEventRequest(limit: "10", page: "\(self.currentPage)")
        if let suggestedEventCategoryId = categoryId{
            let url = APIName.GetEventSuggestedCategoryList.rawValue + "\(suggestedEventCategoryId)"  + "/"
            APIHandler.shared.executeRequestWith(apiName: .GetEventSuggestedCategoryList, parameters: parameters, methodType: .GET, getURL: url,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        if let data = response.data, let items = data.items{
                                //self.arrData = data
                                self.totalPage = response.data?.total ?? 0
                                self.itemsSuggestedEvents.append(contentsOf: items)
                            complition(true, response.message ?? "")
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
    
    
    func getEventApiForWeekendEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let parameters = viewAll == true ? GetEventRequest(eventType: EventType.weekend.rawValue, limit: "10", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.weekend.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: parameters, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    if let data = response.data, let items = data.items{
                            //self.arrData = data
                            self.totalPage = response.data?.total ?? 0
                            self.itemsWeekend.append(contentsOf: items)
                        complition(true, response.message ?? "")
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
    
    
    func getEventApiForOnlineEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == true ? GetEventRequest(eventType: EventType.virtual.rawValue, limit: "10", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.virtual.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    
                    DispatchQueue.main.async {
                        if let data = response.data, let items = data.items{
                            //self.arrData = data
                            self.totalPage = response.data?.total ?? 0
                            self.itemsVirtual.append(contentsOf: items)
                        }
                        complition(true, response.message ?? "")
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
    
    
    func getEventApiForPopularEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == true ? GetEventRequest(eventType: EventType.popular.rawValue, limit: "10", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.popular.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data, let items = data.items{
                           // self.arrData = data
                         //   self.totalPage = (response.total as! NSString).integerValue
                            print(self.itemsPopular.count)
                            self.totalPage = response.data?.total ?? 0
                            self.itemsPopular.append(contentsOf: items)
                            print(self.itemsPopular.count)
                        }
                        complition(true, response.message ?? "")
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
    
    
    func getEventApiForFreeEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == true ? GetEventRequest(eventType: EventType.free.rawValue, limit: "10", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.free.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data, let items = data.items{
                          //  self.arrData = data
                            self.totalPage = response.data?.total ?? 0
                            self.itemsFree.append(contentsOf: items)
                        }
                        complition(true, response.message ?? "")
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
    
    func getEventApiForUpcomingEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == true ? GetEventRequest(eventType: EventType.upcoming.rawValue, limit: "10", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.upcoming.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data, let items = data.items{
                           // self.arrData = data
                            //self.totalPage = (response.total as! NSString).integerValue
                            self.totalPage = response.data?.total ?? 0
                            self.itemsUpcoming.append(contentsOf: items)
                        }
                        complition(true, response.message ?? "")
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
    
    func toCallFavouriteaApi(eventDetail: GetEventModel, isForLocation: Bool) {
        isLikedAnyEvent = true
        AppShareData().commanEventLikeApiCall(
            likeStatus: eventDetail.likeCountData?.isLiked ?? false,
            eventId: eventDetail.event?.id ?? 0,
            completion: { _,_ in
            }
        )
    }
}
