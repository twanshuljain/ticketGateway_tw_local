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
    //    func downloadTicket(complition: @escaping (Bool,String) -> Void) {
    //        let getURL = APIHandler.shared.baseURL + APIName.downloadTicket.rawValue + "\(paymentSuccessFullModel.userId)/\(paymentSuccessFullModel.eventId)/\(paymentSuccessFullModel.checkoutId)/\(paymentSuccessFullModel.orderId).pdf"
    //        print("pdfUrl:- \(getURL)")
    //        if let pdfURL = URL(string: getURL) {
    //            let task = URLSession.shared.downloadTask(with: pdfURL) { localURL, response, error in
    //                if let localURL = localURL {
    //                    do {
    //                        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    //                        let destinationURL = documentsDirectory.appendingPathComponent(pdfURL.lastPathComponent)
    //
    //                        try FileManager.default.moveItem(at: localURL, to: destinationURL)
    //                        print("destinationURL", destinationURL)
    //                        print("localURL", localURL)
    //                        complition(true, "success")
    //                    } catch {
    //                        print("Error saving PDF: \(error)")
    //                        complition(false, "\(error)")
    //                    }
    //                } else if let error = error {
    //                    print("Download error: \(error)")
    //                    complition(false, "\(error)")
    //                }
    //            }
    //            task.resume()
    //        }
    //    }
    
    
    func downloadPdf(complition: @escaping (Bool,String) -> Void) {
        
        let url = APIHandler.shared.baseURL + APIName.downloadTicket.rawValue + "\(self.paymentSuccessFullModel.userId)/\(self.paymentSuccessFullModel.eventId)/\(self.paymentSuccessFullModel.checkoutId)/\(self.paymentSuccessFullModel.orderId)/?user=\(self.paymentSuccessFullModel.userId).pdf"
        
        
        
        DispatchQueue.main.async {
            //  let url = URL(string: urlString)
            let url = url.getCleanedURL()
            
            if let pdfURL = url {
                let task = URLSession.shared.downloadTask(with: pdfURL) { localURL, response, error in
                    if let localURL = localURL {
                        do {
                            //let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                            //let destinationURL = documentsDirectory.appendingPathComponent(pdfURL.lastPathComponent)
                            
                            var destinationURL1 = self.getFilePath()!
                            
                            destinationURL1 = destinationURL1.appendingPathComponent("\(self.randomString(length: 3)).pdf")
                            
                            try FileManager.default.moveItem(at: localURL, to: destinationURL1)
                            print("destinationURL", destinationURL1)
                            print("localURL", localURL)
                            complition(true, "File saved successfully!!")
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
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    fileprivate func getFilePath() -> URL? {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryURl = documentDirectoryURL.appendingPathComponent("TicketGateway", isDirectory: true)
        
        if FileManager.default.fileExists(atPath: directoryURl.path) {
            return directoryURl
        } else {
            do {
                try FileManager.default.createDirectory(at: directoryURl, withIntermediateDirectories: true, attributes: nil)
                return directoryURl
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
    }
    
}
