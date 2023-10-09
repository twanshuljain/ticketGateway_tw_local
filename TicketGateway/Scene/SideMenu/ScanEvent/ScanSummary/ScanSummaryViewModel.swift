//
//  ScanSummaryViewModel.swift
//  TicketGateway
//
//  Created by Apple on 30/06/23.
//

import Foundation

class ScanSummaryViewModel {
    // MARK: - Variables
    var isOnline: Bool = true
    var scanOverviewModel = ScanOverviewModel()
    var scanSummaryModel = ScanSummaryModel()
    var getScanOverviewData = GetScanOverviewData()
    var getScanSummaryItem = [GetScanSummaryItem]()
    var arrOfValueChart: [Int] = []
    // MARK: Custom Functions
    func getScanOverview(completion: @escaping (Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(apiName: .scanOverview, parameters: scanOverviewModel, methodType: .GET) { (result: Result<ResponseModal<GetScanOverviewData>, Error>) in
            switch result {
            case .success(let response):
                print("success scan overview api")
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data {
                            self.getScanOverviewData = data
                            completion(true, response.message ?? "")
                        }
                    }
                }
            case .failure(let error):
                print("error", error)
                print("failure scan overview api ")
                completion(false, error as? String ?? "")
            }
        }
    }
    func getScanSummary(completion: @escaping (Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(apiName: .scanSummary, parameters: scanSummaryModel, methodType: .GET) { (result: Result<ResponseModal<GetScanSummaryData>, Error>) in
            switch result {
            case .success(let response):
                print("success scan summary api")
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data {
                            self.getScanSummaryItem.removeAll()
                            self.getScanSummaryItem = data.items ?? []
                            completion(true, response.message ?? "")
                        }
                    }
                }
            case .failure(let error):
                print("error", error)
                print("failure scan summary api ")
                completion(false, error as? String ?? "")
            }
        }
    }
}
