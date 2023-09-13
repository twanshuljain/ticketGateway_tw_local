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
    var scanSummaryModel = ScanSummaryModel()
    var getScanSummaryData = GetScanSummaryData()
    // MARK: Custom Functions
    func getScanOverview(completion: @escaping (Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(apiName: .scanOverview, parameters: scanSummaryModel, methodType: .GET) { (result: Result<ResponseModal<GetScanSummaryData>, Error>) in
            switch result {
            case .success(let response):
                print("success my order api")
                if response.status_code == 200 {
                    DispatchQueue.main.async {
                        if let data = response.data {
                            self.getScanSummaryData = data
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
