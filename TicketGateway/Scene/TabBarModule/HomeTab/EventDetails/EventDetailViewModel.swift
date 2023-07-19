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
    var eventDetail:EventDetail?
    var eventId:Int?
    var suggestedEventCategoryId:Int?
    //MARK: - Variables
    var arrEventData : [GetEventModel] = [GetEventModel]()
    
}


extension EventDetailViewModel{
    func GetEventDetailApi(complition: @escaping (Bool,String) -> Void ) {
        let url = APIName.getEventDetail.rawValue + "\(eventId ?? 0)"  + "/"
        APIHandler.shared.executeRequestWith(apiName: .getEventDetail, parameters: EmptyModel?.none, methodType: .GET, getURL: url, authRequired: true) { (result: Result<ResponseModal<EventDetail>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
                    DispatchQueue.main.async {
                        self.eventDetail = response.data ?? EventDetail()
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
            let url = APIName.getEventSuggestedCategoryList.rawValue + "\(suggestedEventCategoryId)"  + "/"
            APIHandler.shared.executeRequestWith(apiName: .getEventSuggestedCategoryList, parameters: EmptyModel?.none, methodType: .GET, getURL: url,authRequired: true) { (result: Result<ResponseModal<[GetEventModel]>, Error>) in
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
