//
//  EventPromoCodeViewModel.swift
//  TicketGateway
//
//  Created by Apple on 16/08/23.
//

import UIKit

final class EventPromoCodeViewModel{
    // MARK: - Variables
    var isPromoCodeApplied: Bool = false
    var eventDetail:EventDetail?
    var feeStructure:FeeStructure?
    var selectedArrTicketList = [EventTicket]()
    var eventId:Int?
    var selectedAddOnList = [EventTicketAddOnResponseModel]()
    var finalPrice = 0.0
    var lblNumberOfCount = 0
    var promoCodeData:PromoCode?
    var discountType : DiscountType?
    var selectedCurrencyType = ""
}

extension EventPromoCodeViewModel{
    
    func applyPromoCode(promoCode:String,complition: @escaping (Bool,String) -> Void ) {
        //let prmoCode = "1234"
        let param = EventPromoCodeRequestModel(eventId: eventId, promoCode: promoCode)
        APIHandler.shared.executeRequestWith(apiName: .applyPromoCode, parameters: param, methodType: .POST, getURL: APIName.applyPromoCode.rawValue, authRequired: true) { (result: Result<ResponseModal<PromoCode>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    if let data = response.data{
                        self.promoCodeData = data
                        self.discountType = DiscountType(rawValue: data.discountType ?? "")
                        print("---------------promoCodeData", self.promoCodeData)
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
