//
//  EventDetailViewModel.swift
//  TicketGateway
//
//  Created by Apple on 06/07/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import Foundation


final class EventDetailViewModel{
    
    //MARK: - Variables
    var eventDetail: EventDetail?
    var eventId:Int?
    var suggestedEventCategoryId:Int?
    var selectedArrTicketList = [EventTicket]()
    var arrEventData : [GetEventModel] = [GetEventModel]()
    var eventDetailForFavourite: EventDetail?
    var isLiked: Bool = false
    var isLikedAnyEvent: Bool = false
    var isFromPast = false
    var multilocation:[MultiLocation]?
    var recurringList:[RecurringList]?
    var dispatchGroup1 = DispatchGroup()
    var dispatchGroup2 = DispatchGroup()
    var selectedEventLocationId : Int?
    var dateLocationSelected = false
}


extension EventDetailViewModel{
    func getEventDetailApi(complition: @escaping (Bool,String) -> Void ) {
        let url = APIName.getEventDetail.rawValue + "\(eventId ?? 0)"  + "/"
        APIHandler.shared.executeRequestWith(apiName: .getEventDetail, parameters: EmptyModel?.none, methodType: .GET, getURL: url, authRequired: true) { (result: Result<ResponseModal<EventDetail>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
                    DispatchQueue.main.async {
                        self.eventDetail = response.data ?? EventDetail()
                        print("--------------------",self.eventDetail as Any)
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
    
    func getEventSuggestedCategory(categoryId:Int?, complition: @escaping (Bool,String) -> Void ) {
        let parameters = GetEventRequest(limit: "3", page: "1")
        if let suggestedEventCategoryId = categoryId{
            let url = APIName.getEventSuggestedCategoryList.rawValue + "\(suggestedEventCategoryId)"  + "/"
            APIHandler.shared.executeRequestWith(apiName: .getEventSuggestedCategoryList, parameters: parameters, methodType: .GET, getURL: url,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        print("response....",response)
                            self.arrEventData = response.data?.items ?? [GetEventModel]()
                            print(self.arrEventData)
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
    
    func GetMultiLocationList(complition: @escaping (Bool,String) -> Void ) {
        let url = APIName.getMultiLocationList.rawValue + "\(eventId ?? 0)"  + "/"
        APIHandler.shared.executeRequestWith(apiName: .getMultiLocationList, parameters: EmptyModel?.none, methodType: .GET, getURL: url, authRequired: true) { (result: Result<ResponseModal<[MultiLocation]>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup1.leave() }
                if response.status_code == 200 {
                    print("response....",response)
                        self.multilocation = response.data
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
    
    func GetRecurringList(complition: @escaping (Bool,String) -> Void ) {
        let url = APIName.getRecurringList.rawValue + "\(eventId ?? 0)"  + "/"
        APIHandler.shared.executeRequestWith(apiName: .getRecurringList, parameters: EmptyModel?.none, methodType: .GET, getURL: url, authRequired: true) { (result: Result<ResponseModal<[RecurringList]>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup2.leave() }
                if response.status_code == 200 {
                    print("response....",response)
                        self.recurringList = response.data
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
}
