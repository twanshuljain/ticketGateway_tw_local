//
//  PaymentSuccessFullViewModel.swift
//  TicketGateway
//
//  Created by Jay Prajapat on 10/19/23.
//

import Foundation
class PaymentSuccessFullViewModel {
    
    // MARK: All Properties
    var isTransactionFailed: Bool = false
    var createCharge:CreateCharge?
    var selectedArrTicketList = [EventTicket]()
    var selectedCurrencyType = ""
    var totalTicketPrice = ""
    var paymentSuccessFullModel = PaymentSuccessFullModel()
    
    // MARK: Custom Functions
    func downloadTicket(complition: @escaping (Bool,String) -> Void) {
        let getURL = APIHandler.shared.baseURL + APIName.downloadTicket.rawValue + "\(paymentSuccessFullModel.userId)/\(paymentSuccessFullModel.eventId)/\(paymentSuccessFullModel.checkoutId)/\(paymentSuccessFullModel.orderId).pdf"
        print("pdfUrl:- \(getURL)")
        if let pdfURL = URL(string: getURL) {
            let task = URLSession.shared.downloadTask(with: pdfURL) { localURL, response, error in
                if let localURL = localURL {
                    do {
                        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let destinationURL = documentsDirectory.appendingPathComponent(pdfURL.lastPathComponent)
                        
                        try FileManager.default.moveItem(at: localURL, to: destinationURL)
                        print("destinationURL", destinationURL)
                        print("localURL", localURL)
                        complition(true, "success")
                    } catch {
                        print("Error saving PDF: \(error)")
                        complition(false, "\(error)")
                    }
                } else if let error = error {
                    print("Download error: \(error)")
                    complition(false, "\(error)")
                }
            }
            task.resume()
        }
    }
    
}
