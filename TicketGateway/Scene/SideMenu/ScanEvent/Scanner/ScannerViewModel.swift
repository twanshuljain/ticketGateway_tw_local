//
//  ScannerViewModel.swift
//  TicketGateway
//
//  Created by Apple on 30/06/23.
//

import Foundation
import AVFoundation

class ScannerViewModel {
    // MARK: - Variables
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var scanDetailModel = ScanDetailModel()
    var getScanDetailData: GetScanDetailData?
    var getScanTicketDetails = GetScanTicketDetails()
    var scanBarCodeModel = ScanBarCodeModel()
    // MARK: Custom Functions
    func getScanDetail(complition: @escaping (Bool, String) -> Void ) {
        let parameters = ScanDetailModel(name: getScanTicketDetails.name, eventId: getScanTicketDetails.eventId)
        APIHandler.shared.executeRequestWith(apiName: .scanDetail, parameters: parameters, methodType: .GET, authRequired: true) { (result: Result<ResponseModal<GetScanDetailData>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
                    if let getScanDetailData = response.data {
                        self.getScanDetailData = getScanDetailData
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
    func scanBarCodeApi(complition: @escaping (Bool, String) -> Void ) {
        print("scanBarCodeModel", scanBarCodeModel)
        APIHandler.shared.executeRequestWith(apiName: .scanBarCode, parameters: scanBarCodeModel, methodType: .POST, authRequired: true) { (result: Result<ResponseModal<GetScanDetailData>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
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
