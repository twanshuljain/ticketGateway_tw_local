//
//  CardListViewModel.swift
//  TicketGateway
//
//  Created by apple on 10/17/23.
//

import Foundation
class CardListViewModel {
    var arrCardList:[CardList]?
    var selectedCard:CardList?
    var checkoutId:String?
    var stripeUser:StripeCreateUser?
    var createCharge:CreateCharge?
    var dispatchGroup = DispatchGroup.init()
    
    
    var totalTicketPrice = ""
    var selectedCurrencyType = ""
    var eventId:Int?
    var selectedArrTicketList = [EventTicket]()
    var selectedAddOnList = [EventTicketAddOnResponseModel]()
    
    
    

}

extension CardListViewModel{
    func checkValidations(vc:CardListVC) -> Bool{
        if self.selectedCard == nil{
            vc.showAlertController(message: "Please select card")
            return false
        }else{
            return true
        }
    }
    
    func createCustomer(vc:CardListVC){
        DispatchQueue.main.async {
            vc.view.showLoading(centreToView: vc.view)
        }
        self.dispatchGroup.enter()
        StripeClasses().stripeCreateCustomer(controller: vc) { createUserResponse, isTrue, message in
            defer { self.dispatchGroup.leave() }
            if isTrue == true  && createUserResponse != nil{
                DispatchQueue.main.async {
                    vc.view.stopLoading()
                    self.stripeUser = createUserResponse
                }
            }else{
                DispatchQueue.main.async {
                    vc.view.stopLoading()
                    vc.showAlertController(message: message)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.createCheckout(vc: vc)
        }
    }
    
    func createCheckout(vc:CardListVC){
        var ticketIDs = [CheckoutTicketID]()
        var addOnList = [CheckoutAddonList]()
        self.selectedArrTicketList.forEach { ticket in
            let data = CheckoutTicketID.init(ticketTypeId: ticket.ticketTypeId,ticketType: ticket.ticketType ?? "", ticketName: ticket.ticketName ?? "", baseTicketID: ticket.ticketID ?? 0, quantity: ticket.selectedTicketQuantity ?? 0, ticketPrice: ticket.ticketPrice ?? 0, ticketCurrency: ticket.ticketCurrencyType ?? "")
            ticketIDs.append(data)
        }
        
        self.selectedAddOnList.forEach { addOnData in
            let data = CheckoutAddonList.init(addonID: addOnData.id ?? 0, quantity: addOnData.selectedTicketQuantity ?? 0)
            addOnList.append(data)
        }
        
        
        if let eventId = self.eventId{
            DispatchQueue.main.async {
                vc.view.showLoading(centreToView: vc.view)
            }
            StripeClasses.sharedInstance.createCheckout(eventId: eventId, orderType: "ticket", totalUserLoyaltyPoint: "123", totalUserSpentAmount: "1234", ticketIDs: ticketIDs, addOnList: addOnList, controller: vc, complition: { response, isTrue, message in
                if isTrue == true  && response != nil{
                    DispatchQueue.main.async {
                        vc.view.stopLoading()
                    }
                    self.checkoutId = response?.checkoutID ?? ""
                    self.createCharge(vc: vc)  //NEW FLOW
                }else{
                    DispatchQueue.main.async {
                        vc.view.stopLoading()
                        vc.showAlertController(message: message)
                    }
                }
            })
        }
    }
    
    func createCharge(vc:CardListVC){
        let cardId = self.selectedCard?.id ?? 0
        let amount = (self.totalTicketPrice as NSString).integerValue
        if let checkOutId = self.checkoutId, let currency = self.selectedArrTicketList.compactMap({ $0.ticketCurrencyType ?? "" }).first{
            var saveCardData:AddCardRequest?
            saveCardData = nil
            DispatchQueue.main.async {
                vc.view.showLoading(centreToView: vc.view)
            }
            StripeClasses().createCharge(saveCardData: saveCardData,amount: amount, cardId: Int(cardId) , checkoutId: checkOutId, controller: vc, currency: currency, isSave: true) { response, isTrue, message in
                if isTrue == true  && response != nil{
                    DispatchQueue.main.async {
                        vc.view.stopLoading()
                        self.createCharge = response
                        self.navigateToPaymentSuccess(success: true, vc: vc)
                    }
                }else{
                    DispatchQueue.main.async {
                        vc.view.stopLoading()
                        self.navigateToPaymentSuccess(success: false, vc: vc)
                        // vc.showAlertController(message: message)
                    }
                }
            }
        }
        
    }
    
    func navigateToPaymentSuccess(success:Bool,vc:CardListVC){
        if let view = vc.createView(storyboard: .home, storyboardID: .PaymentSuccessFullVC) as? PaymentSuccessFullVC{
            view.createCharge = self.createCharge
            view.totalTicketPrice = self.totalTicketPrice
            view.isTransactionFailed = success == true ? false : true
            view.selectedCurrencyType = self.selectedCurrencyType
            vc.navigationController?.pushViewController(view, animated: true)
        }
    }
}

