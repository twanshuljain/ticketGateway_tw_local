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
    var myOrdersModel = MyOrdersModel()
    var totalCount: Int = 0
    var isFromUpcoming: Bool = false
    var upcomingCount: Int = 0
    var pastCount: Int = 0 
    // MARK: Custom Functions
    func myOrdersApiCall(myOrdersModel: MyOrdersModel,
                         isFromSearch: Bool = false,
                         completion: @escaping (Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(apiName: .myOrders, parameters: myOrdersModel, methodType: .GET) { (result: Result<ResponseModal<GetMyOrderData>, Error>) in
            switch result {
            case .success(let response):
                print("success my order api")
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data {
                            if isFromSearch {
                                self.arrMyOrder.removeAll()
                                self.arrMyOrder = data.items ?? []
                            } else {
                                self.arrMyOrder.append(contentsOf: data.items ?? [])
                            }
                            self.totalCount = data.total ?? 0
                            completion(true, response.message ?? "")
                        }
                    }
                }
            case .failure(let error):
                print("myorder api error:-", error)
                completion(false, error as? String ?? "")
            }
        }
    }
}
