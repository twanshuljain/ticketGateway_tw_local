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
}


extension EventDetailViewModel{
    func GetEventDetailApi(complition: @escaping (Bool,String) -> Void ) {
        let url = APIName.GetEventDetail.rawValue + "\(eventId ?? 0)"  + "/"
        APIHandler.shared.executeRequestWith(apiName: .GetEventDetail, parameters: EmptyModel?.none, methodType: .GET, getURL: url, authRequired: true) { (result: Result<ResponseModal<EventDetail>, Error>) in
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
                }else{
                    complition(false,response.message ?? "error message")
                }
            case .failure(let error):
                complition(false,"\(error)")
            }
        }
    }
    
    func GetEventSuggestedCategory(categoryId:Int?, complition: @escaping (Bool,String) -> Void ) {
        let parameters = GetEventRequest(limit: "3", page: "1")
        if let suggestedEventCategoryId = categoryId{
            let url = APIName.GetEventSuggestedCategoryList.rawValue + "\(suggestedEventCategoryId)"  + "/"
            APIHandler.shared.executeRequestWith(apiName: .GetEventSuggestedCategoryList, parameters: parameters, methodType: .GET, getURL: url,authRequired: true) { (result: Result<ResponseModal<GetEvent>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        print("response....",response)
                            self.arrEventData = response.data?.items ?? [GetEventModel]()
                            print(self.arrEventData)
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
}
