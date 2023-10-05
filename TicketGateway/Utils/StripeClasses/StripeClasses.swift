//
//  StripeClasses.swift
//  TicketGateway
//
//  Created by Apple on 07/08/23.
//

import UIKit
import Stripe

class StripeClasses: NSObject {
    static let sharedInstance = StripeClasses()
    private var jsonStrings:String?

    func createStripeSourceToken(name:String,cardNumber:String,expMonth:UInt,expYear:UInt,cvv:String,controller:UIViewController?,callback:@escaping (_ response:String?,_ taskError:Error?)->Void) {

        if !Reachability.isConnectedToNetwork() {
            //controller?.view.showLoading(centreToView: (controller?.view)!)
            controller?.view.stopLoading()
            controller?.showAlertController(message: "The Internet connection appears to be offline.")
            return
        }
        let stripCard = STPCardParams()

        stripCard.number = cardNumber
        stripCard.cvc = cvv
        stripCard.expMonth = UInt(expMonth )
        stripCard.expYear = UInt(expYear)
        stripCard.name = name

        STPAPIClient.shared.createToken(withCard: stripCard) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                // Present error to user...
                controller?.showAlertController(message: "Your card details are not valid")
                callback(nil, error)
                return
            }
            // self.dictPayData["stripe_token"] = token.tokenId
            let stripeToken = token.tokenId
            callback(stripeToken, nil)
        }
    }

    func stripeCreateCustomer(controller:UIViewController?, complition: @escaping (StripeCreateUser?,Bool,String) -> Void ) {
        APIHandler.shared.executeRequestWith(apiName: .createStripeCustomer, parameters: EmptyModel?.none, methodType: .POST,authRequired: true) { (result: Result<ResponseModal<StripeCreateUser>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    complition(response.data, true, response.message ?? "")
                } else {
                    complition(response.data, false,response.message ?? "error message")
                }
            case .failure(let error):
                complition(nil, false,"\(error)")
            }
        }
    }

    func addCardForUser(name:String,cardNumber:String,expMonth:Int,expYear:Int,cvv:String,controller:UIViewController?,complition: @escaping (AddCard?,Bool,String) -> Void ) {
        let req = AddCardRequest.init(cardNumber: cardNumber, expMonth: expMonth, expYear: expYear, cvc: cvv , name: name)
        APIHandler.shared.executeRequestWith(apiName: .addCardForUser, parameters: req, methodType: .POST,authRequired: true) { (result: Result<ResponseModal<AddCard>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    complition(response.data, true, response.message ?? "")
                } else {
                    complition(response.data, false,response.message ?? "error message")
                }
            case .failure(let error):
                complition(nil, false,"\(error)")
            }
        }
    }
    func createCheckout(
        eventId: Int?, orderType:String?,
        totalUserLoyaltyPoint: String?, totalUserSpentAmount:String?,
        ticketIDs: [CheckoutTicketID]?, addOnList: [CheckoutAddonList]?,
        controller:UIViewController?, complition: @escaping (CheckoutId?,Bool,String) -> Void
    ) {
        let req = CreateCheckoutReq.init(eventID: eventId, orderType: orderType, ticketIDS: ticketIDs, addonList: addOnList, totalUserLoyaltyPoint: totalUserLoyaltyPoint, totalUserSpentAmount: totalUserSpentAmount)
        APIHandler.shared.executeRequestWith(apiName: .createCheckout, parameters: req, methodType: .POST,authRequired: true) { (result: Result<ResponseModal<CheckoutId>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    complition(response.data, true, response.message ?? "")
                } else {
                    complition(response.data, false,response.message ?? "error message")
                }
            case .failure(let error):
                complition(nil, false,"\(error)")
            }
        }
    }

    func createCharge(amount:Double,cardId:Int,checkoutId:String,controller:UIViewController?,currency:String,complition: @escaping (CreateCharge?,Bool,String) -> Void ) {
        let req = CreateChargeRequest.init(amount: amount, cardId: cardId, checkoutId: checkoutId, currency: currency)
        APIHandler.shared.executeRequestWith(apiName: .createCharge, parameters: req, methodType: .POST,authRequired: true) { (result: Result<ResponseModal<CreateCharge>, Error>) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    complition(response.data, true, response.message ?? "")
                } else {
                    complition(response.data, false,response.message ?? "error message")
                }
            case .failure(let error):
                complition(nil, false,"\(error)")
            }
        }
    }
}
