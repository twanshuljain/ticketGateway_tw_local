//
//  EventDetailViewModel.swift
//  TicketGateway
//
//  Created by Apple on 06/07/23.
//

import Foundation


final class EventDetailViewModel{
    
    //MARK: - Variables
    var eventDetail:EventDetail?
    var eventId:Int?
    var suggestedEventCategoryId:Int?
    var selectedArrTicketList = [EventTicket]()
    var arrEventData : [GetEventModel] = [GetEventModel]()
    
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
                        print("--------------------",self.eventDetail)
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
        if let suggestedEventCategoryId = categoryId{
            let url = APIName.GetEventSuggestedCategoryList.rawValue + "\(suggestedEventCategoryId)"  + "/"
            APIHandler.shared.executeRequestWith(apiName: .GetEventSuggestedCategoryList, parameters: EmptyModel?.none, methodType: .GET, getURL: url,authRequired: true) { (result: Result<ResponseModal<[GetEventModel]>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        print("response....",response)
                        DispatchQueue.main.async {
                            self.arrEventData = response.data ?? [GetEventModel]()
                            print(self.arrEventData)
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
}
