//
//  GetEventListViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 30/05/23.
//

import UIKit

final class HomeDashBoardViewModel {
    
    //MARK: - Variables
    var arrEventData : [GetEventModel] = [GetEventModel]()
    
}

//MARK: - Functions
extension HomeDashBoardViewModel {
    
    func GetEventApi(complition: @escaping (Bool,String) -> Void ) {
        
        APIHandler.shared.executeRequestWith(apiName: .GetEventList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[GetEventModel]>, Error>) in
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
