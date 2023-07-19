//
//  GetEventListViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 30/05/23.
//

import UIKit

final class HomeDashBoardViewModel {
    
    //MARK: - Variables
    var arrEventDataa : [[GetEventModel]] = [[GetEventModel]]()
    var arrEventData1 : [GetEventModel] = [GetEventModel]()
    var arrEventData = GetEvent()
    var arrEventCategory = [EventCategories]()
    var dispatchGroup1 = DispatchGroup.init()
    var dispatchGroup2 = DispatchGroup.init()
    var dispatchGroup3 = DispatchGroup.init()
    var dispatchGroup4 = DispatchGroup.init()
    var dispatchGroup5 = DispatchGroup.init()
    
    let semaphore = DispatchSemaphore(value: 1)
    var arrOrganizersList : [Organizers]?
    
    var arrDataaWeekend = [GetEventModel]()
    var arrDataaVirtual = [GetEventModel]()
    var arrDataaPopular = [GetEventModel]()
    var arrDataaFree = [GetEventModel]()
    var arrDataaUpcoming = [GetEventModel]()
}

//MARK: - Functions
extension HomeDashBoardViewModel {
    
    func GetEventApi(complition: @escaping (Bool,String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .GetEventList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[GetEventModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {

                    DispatchQueue.main.async {
                        //self.arrEventData = response.data ?? [GetEventModel]()
                        if var data = response.data{
                            //data.unique{$0.event!.id! == $1.event!.id! }
                            //self.arrEventData = data
                           // self.arrEventData.itemsWeekend = items
                            self.arrDataaWeekend = data
                           // self.arrEventDataa.append(data.itemsWeekend!)
                           // self.arrEventData1.append(contentsOf: data.itemsWeekend!)
                          //  print("COUNT>>>",self.arrEventDataa.count)
                        }
                        
                       // print(self.arrEventData)
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
    
    func getOrganizersList(complition: @escaping (Bool,String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .GetOrganizersList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[Organizers]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    if let organizersList = response.data{
                        self.arrOrganizersList = organizersList
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
    
    func getEventApiForWeekendEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let parameters = viewAll == false ? GetEventRequest(eventType: EventType.weekend.rawValue, limit: "3", page: "1") : GetEventRequest(eventType: EventType.weekend.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: parameters, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup1.leave() }
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                            //data.unique{$0.event!.id! == $1.event!.id! }
                            self.arrEventData = data
                            self.arrEventData.itemsWeekend = items
                            self.arrDataaWeekend = items
                            if items.count != 0{
                                self.arrEventCategory.append(.weekend)
                            }
                           // self.arrEventDataa.append(data.itemsWeekend!)
                           // self.arrEventData1.append(contentsOf: data.itemsWeekend!)
                          //  print("COUNT>>>",self.arrEventDataa.count)
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup1.leave() }
                complition(false,"\(error)")
            }
        }
    }
    
    
    func getEventApiForOnlineEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == false ? GetEventRequest(eventType: EventType.virtual.rawValue, limit: "3", page: "1") : GetEventRequest(eventType: EventType.virtual.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup2.leave() }
                if response.status_code == 200 {
                    
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                            self.arrEventData = data
                            self.arrEventData.itemsVirtual = items
                            self.arrDataaVirtual = items
                            if items.count != 0{
                                self.arrEventCategory.append(.online)
                            }
                           // self.arrEventDataa.append(data.itemsVirtual!)
                           // self.arrEventData1.append(contentsOf: data.itemsVirtual!)
                          //  print("COUNT>>>",self.arrEventDataa.count)
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup2.leave() }
                complition(false,"\(error)")
            }
        }
    }
    
    
    func getEventApiForPopularEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == false ? GetEventRequest(eventType: EventType.popular.rawValue, limit: "3", page: "1") : GetEventRequest(eventType: EventType.popular.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    defer { self.dispatchGroup3.leave() }
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                            self.arrEventData = data
                            self.arrEventData.itemsPopular = items
                            self.arrDataaPopular = items
                            if items.count != 0{
                                self.arrEventCategory.append(.popular)
                            }
                           // self.arrEventDataa.append(data.itemsPopular!)
                          //  self.arrEventData1.append(contentsOf: data.itemsPopular!)
                          //  print("COUNT>>>",self.arrEventDataa.count)
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup3.leave() }
                complition(false,"\(error)")
            }
        }
    }
    
    
    func getEventApiForFreeEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == false ? GetEventRequest(eventType: EventType.free.rawValue, limit: "3", page: "1") : GetEventRequest(eventType: EventType.free.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    defer { self.dispatchGroup4.leave() }
                    DispatchQueue.main.async {
                        if var data = response.data, let items = data.items{
                            self.arrEventData = data
                            self.arrEventData.itemsFree = items
                            self.arrDataaFree = items
                            if items.count != 0{
                                self.arrEventCategory.append(.free)
                            }
                            //self.arrEventDataa.append(data.itemsFree!)
                           // self.arrEventData1.append(contentsOf: data.itemsFree!)
                         //   print("COUNT>>>",self.arrEventDataa.count)
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup4.leave() }
                complition(false,"\(error)")
            }
        }
    }
    
    func getEventApiForUpcomingEvents(viewAll:Bool,complition: @escaping (Bool,String) -> Void ) {
        let request =  viewAll == false ? GetEventRequest(eventType: EventType.upcoming.rawValue, limit: "3", page: "1") : GetEventRequest(eventType: EventType.upcoming.rawValue)
        APIHandler.shared.executeRequestWith(apiName: .GetEventListCategoryWise, parameters: request, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    defer { self.dispatchGroup5.leave() }
                    DispatchQueue.main.async {
                        if let data = response.data, let items = data.items{
                            self.arrEventData = data
                            self.arrEventData.itemsUpcoming = items
                            self.arrDataaUpcoming = items
                            if items.count != 0{
                                self.arrEventCategory.append(.upcoming)
                            }
//                            self.arrEventDataa.append(data.itemsUpcoming!)
//                            self.arrEventData1.append(contentsOf: data.itemsUpcoming!)
//                            print("COUNT>>>",self.arrEventDataa.count)
                        }
                        complition(true, response.message ?? "")
                    }
                    complition(true, response.message ?? "")
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup5.leave() }
                complition(false,"\(error)")
            }
        }
    }
    
    
    
}
