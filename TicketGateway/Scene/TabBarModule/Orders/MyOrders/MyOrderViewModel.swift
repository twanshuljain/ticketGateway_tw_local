//
//  MyOrderViewModel.swift
//  TicketGateway
//
//  Created by Apple on 22/08/23.
//

import Foundation
final class MyOrderViewModel {
    // MARK: Custom Functions
    func myOrdersApiCall() {
        let param = MyOrdersModel(pageNumber: 1, pageLimit: 10, filterBy: "upcoming", searchText: "", sortBy: "all")
        APIHandler.shared.executeRequestWith(apiName: .myOrders, parameters: param, methodType: .GET) { (result: Result<ResponseModal<GetMyOrderData>, Error>) in
            switch result {
            case .success(let response):
                print("success my order api")
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data {
                            print("response of my order api****", response)
                        }
                    }
                }
            case .failure(let error):
                print("error", error)
                print("failure like api ")
            }
        }
    }
}
