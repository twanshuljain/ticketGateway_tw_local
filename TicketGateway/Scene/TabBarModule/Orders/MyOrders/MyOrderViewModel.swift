//
//  MyOrderViewModel.swift
//  TicketGateway
//
//  Created by Apple on 22/08/23.
//

import Foundation
final class MyOrderViewModel {
    // MARK: Custom Functions
    var arrMyOrder: [GetMyOrderItem] = []
    var myOrdersModel: MyOrdersModel?
    var totalPage: Int = 0
    var isFromUpcoming: Bool = false
    var upcomingCount: Int = 0
    var pastCount: Int = 0 
    // MARK: Custom Functions
    func myOrdersApiCall(myOrdersModel: MyOrdersModel,
                         completion: @escaping (Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(apiName: .myOrders, parameters: myOrdersModel, methodType: .GET) { (result: Result<ResponseModal<GetMyOrderData>, Error>) in
            switch result {
            case .success(let response):
                print("success my order api")
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data {
                            self.arrMyOrder.append(contentsOf: data.items!)
                            self.totalPage = data.total ?? 0
                            completion(true, response.message ?? "")
                        }
                    }
                }
            case .failure(let error):
                print("error", error)
                print("failure my order api ")
                completion(false, error as? String ?? "")
            }
        }
    }
}
