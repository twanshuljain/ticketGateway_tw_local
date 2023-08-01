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

final class ViewMoreEventsViewModel {
    
    //MARK: - Variables
   // var arrData:GetEvent?
    var index = 0
    var arrEventCategory = [EventCategories]()
    var currentPage = 1
    var totalPage = 1
    let refreshControl = UIRefreshControl()
    
    var itemsWeekend = [GetEventModel]()
    var itemsVirtual = [GetEventModel]()
    var itemsPopular = [GetEventModel]()
    var itemsFree = [GetEventModel]()
    var itemsUpcoming = [GetEventModel]()
}

//MARK: - Functions
extension ViewMoreEventsViewModel {
    
    func getEventApiForWeekendEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let parameters = viewAll == true ? GetEventRequest(eventType: EventType.virtual.rawValue, limit: "3", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.weekend.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: parameters, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                        if var data = response.data, let items = data.items{
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
        let request =  viewAll == true ? GetEventRequest(eventType: EventType.virtual.rawValue, limit: "3", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.virtual.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
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
        let request =  viewAll == true ? GetEventRequest(eventType: EventType.virtual.rawValue, limit: "3", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.popular.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                           // self.arrData = data
                         //   self.totalPage = (response.total as! NSString).integerValue
                            self.totalPage = response.data?.total ?? 0
                            self.itemsPopular.append(contentsOf: items)
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
        let request =  viewAll == true ? GetEventRequest(eventType: EventType.virtual.rawValue, limit: "3", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.free.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                          //  self.arrData = data
                            response.data?.total ?? 0
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
        let request =  viewAll == true ? GetEventRequest(eventType: EventType.virtual.rawValue, limit: "3", page: "\(self.currentPage)") : GetEventRequest(eventType: EventType.upcoming.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
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
    
    
    
}
