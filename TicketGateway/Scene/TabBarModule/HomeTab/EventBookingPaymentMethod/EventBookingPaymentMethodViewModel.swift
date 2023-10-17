//
//  EventBookingPaymentMethodViewModel.swift
//  TicketGateway
//
//  Created by Apple on 28/07/23.
//

import UIKit
import Stripe


enum SelectedPaymentMode {
    case wallet
    case applePay
    case savedCards
    case debitCreditCard
    case none
}

final class EventBookingPaymentMethodViewModel{
    // MARK: - Variables
    var previousTextFieldContent: String?
    var previousSelection: UITextRange?
    var MONTH = 0
    var YEAR = 1
    var selectedMonthName = ""
    var selectedyearName = ""
    var months = [Any]()
    var years = [Any]()
    var minYear: Int = 0
    var maxYear: Int = 0
    var rowHeight: Int = 0
    var strMonth = ""
    var strYear = ""
    let colorTop =  UIColor(red: 146.0/255.0, green: 254.0/255.0, blue: 157.0/255.0, alpha: 0.2).cgColor
    let colorBottom = UIColor(red: 0/255.0, green: 201.0/255.0, blue: 255.0/255.0, alpha: 0.2).cgColor
    let gradientLayer = CAGradientLayer()
    var selectedCurrencyType = ""
    var eventId:Int?
    var selectedArrTicketList = [EventTicket]()
    var eventDetail:EventDetail?
    var feeStructure :FeeStructure?
    var totalTicketPrice = ""
    var selectedAddOnList = [EventTicketAddOnResponseModel]()
    var createCharge:CreateCharge?
    var isCardSave = true //var isCardSave = false  ---For SavedCard
    var saveCardList:[CardList]?
    var paymentModeSelected:SelectedPaymentMode = .none
    
    var stripeUser:StripeCreateUser?
    var addCard:AddCard?
    var selectedMonth : String?
    var selectedYear : String?
    var checkoutId:String?
    var name:String?
    var cardNumber:String?
    var cvv:String?
    var dispatchGroup = DispatchGroup.init()
    
}

extension EventBookingPaymentMethodViewModel{
//    func checkout(vc:UIViewController){
//        let cardParams = STPCardParams()
//        cardParams.number = "4242424242424242"
//        cardParams.expMonth = 12
//        cardParams.expYear = 25
//        cardParams.cvc = "123"
//
//        StripeClasses().createStripeSourceToken(name: "Saurabh", cardNumber: "4242424242424242", expMonth: 12, expYear: 25, cvv: "123", controller: vc) { response, taskError in
//            print(response)
//        }
//    }
    
    
    func checkValidations(vc:EventBookingPaymentMethodVC) -> Bool{
        let validate = self.validateCreditCard(vc.txtCardName.text ?? "", vc.txtCardNumber.text ?? "", vc.txtExpiryDate.text ?? "", vc.txtCVV.text ?? "", vc)
        
        if validate{
            return true
            
        }
        return false
    }
    
    func createCustomer(vc:EventBookingPaymentMethodVC){
        DispatchQueue.main.async {
            vc.parentView.showLoading(centreToView: vc.view)
        }
        self.dispatchGroup.enter()
        StripeClasses().stripeCreateCustomer(controller: vc) { createUserResponse, isTrue, message in
            defer { self.dispatchGroup.leave() }
            if isTrue == true  && createUserResponse != nil{
                DispatchQueue.main.async {
                    vc.parentView.stopLoading()
                    self.stripeUser = createUserResponse
                    if let name = vc.txtCardName.text, let cardNumber = vc.txtCardNumber.text, let expDetail = vc.txtExpiryDate.text, let cvv = vc.txtCVV.text{
                        self.name = name
                        self.cardNumber = cardNumber
                        self.cvv = cvv
                    }
                }
            }else{
                DispatchQueue.main.async {
                    vc.parentView.stopLoading()
                    vc.showAlertController(message: message)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.addCardForUser(vc: vc)
        }
    }

    
    func addCardForUser(vc:EventBookingPaymentMethodVC){
        if isCardSave{
            if let name = self.name, let cardNumber = self.cardNumber,let cvv = self.cvv, let expMonth = Int(strMonth), let expYear = Int(strYear){
                DispatchQueue.main.async {
                    vc.parentView.showLoading(centreToView: vc.view)
                }
                StripeClasses().addCardForUser(name: name, cardNumber: cardNumber, expMonth: expMonth, expYear: expYear, cvv: cvv, isSave: self.isCardSave, controller: vc) { addCardResponse, isTrue, message in
                    if isTrue == true  && addCardResponse != nil{
                        DispatchQueue.main.async {
                            vc.parentView.stopLoading()
                        }
                        self.addCard = addCardResponse
                        self.createCheckout(vc: vc)
                    }else{
                        DispatchQueue.main.async {
                            vc.parentView.stopLoading()
                            vc.showAlertController(message: message)
                        }
                    }
                }
            }
        }else{
            self.createCheckout(vc: vc)
        }
    }
    
    func createCheckout(vc:EventBookingPaymentMethodVC){
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
                vc.parentView.showLoading(centreToView: vc.view)
            }
            StripeClasses.sharedInstance.createCheckout(eventId: eventId, orderType: "ticket", totalUserLoyaltyPoint: "123", totalUserSpentAmount: "1234", ticketIDs: ticketIDs, addOnList: addOnList, controller: vc, complition: { response, isTrue, message in
                if isTrue == true  && response != nil{
                    DispatchQueue.main.async {
                        vc.parentView.stopLoading()
                    }
                    self.checkoutId = response?.checkoutID ?? ""
                    //self.otpVerify(vc: vc)  //OLD FLOW
                    self.createCharge(vc: vc)  //NEW FLOW
                }else{
                    DispatchQueue.main.async {
                        vc.parentView.stopLoading()
                        vc.showAlertController(message: message)
                    }
                }
            })
        }
    }
    
    func otpVerify(vc:EventBookingPaymentMethodVC){
        DispatchQueue.main.async {
            if let view = vc.createView(storyboard: .main, storyboardID: .OtpNumberVC) as? OtpNumberVC{
                let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
                let obj =   DataHoldOnSignUpProcessModel.init(strEmail: userModel?.email ?? "", strNumber: userModel?.number ?? "", strStatus: "", strDialCountryCode: userModel?.strDialCountryCode ?? "", strCountryCode: "")
                objAppShareData.dicToHoldDataOnSignUpModule = obj
                view.isComingFromLogin = false
                view.isComingFrom = .OrderSummary
                let number = "\(userModel?.strDialCountryCode ?? "")" + (userModel?.number ?? "")
                view.viewModel.number = number
                
                view.otpVerified = { verified, message in
                    if verified{
                        self.createCharge(vc: vc)
                    }else{
                        DispatchQueue.main.async {
                            vc.showAlertController(message: message)
                        }
                    }
                }
                vc.navigationController?.pushViewController(view, animated: true)
            }
        }
    }
    
    func createCharge(vc:EventBookingPaymentMethodVC){
        let cardId = self.addCard?.id ?? 0
        let amount = (self.totalTicketPrice as NSString).integerValue
        if let checkOutId = self.checkoutId, let currency = self.selectedArrTicketList.compactMap({ $0.ticketCurrencyType ?? "" }).first{
            var saveCardData:AddCardRequest?
            if self.isCardSave{
                saveCardData = nil
            }else{
                if let name = self.name, let cardNumber = self.cardNumber,let cvv = self.cvv, let expMonth = Int(strMonth), let expYear = Int(strYear){
                    saveCardData = AddCardRequest.init(card_number: cardNumber, exp_month: expMonth, exp_year: expYear, cvc: cvv , name: name)
                    
                }
            }
            DispatchQueue.main.async {
                vc.parentView.showLoading(centreToView: vc.view)
            }
            StripeClasses().createCharge(saveCardData: saveCardData,amount: amount, cardId: Int(cardId) , checkoutId: checkOutId, controller: vc, currency: currency, isSave: isCardSave) { response, isTrue, message in
                if isTrue == true  && response != nil{
                    DispatchQueue.main.async {
                        vc.parentView.stopLoading()
                        self.createCharge = response
                        self.navigateToPaymentSuccess(success: true, vc: vc)
                    }
                }else{
                    DispatchQueue.main.async {
                        vc.parentView.stopLoading()
                        self.navigateToPaymentSuccess(success: false, vc: vc)
                       // vc.showAlertController(message: message)
                    }
                }
            }
        }
        
    }
    
    func getCardList(vc:EventBookingPaymentMethodVC){
        DispatchQueue.main.async {
            vc.parentView.showLoading(centreToView: vc.view)
        }
        self.dispatchGroup.enter()
        StripeClasses().getCardList { cardListResponse, isTrue, message in
            defer { self.dispatchGroup.leave() }
            if isTrue == true  && cardListResponse != nil{
                DispatchQueue.main.async {
                    vc.parentView.stopLoading()
                    self.saveCardList = cardListResponse
                }
            }else{
                DispatchQueue.main.async {
                    vc.parentView.stopLoading()
                    vc.showAlertController(message: message)
                }
            }
        }
    }
    
    func navigateToPaymentSuccess(success:Bool,vc:EventBookingPaymentMethodVC){
        if let view = vc.createView(storyboard: .home, storyboardID: .PaymentSuccessFullVC) as? PaymentSuccessFullVC{
            view.createCharge = self.createCharge
            view.totalTicketPrice = self.totalTicketPrice
            view.isTransactionFailed = success == true ? false : true
            view.selectedCurrencyType = self.selectedCurrencyType
            vc.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    
    //MARK:- func validateCreditCard
    func validateCreditCard(_ cardholderName:String?,_ cardNumber:String?,_ expiryDate:String?,_ cvv:String? ,_ vc:EventBookingPaymentMethodVC)-> Bool{
        if cardNumber == nil || cardNumber?.count == 0 {
            vc.showAlertController(message: PaymentError.cardNumber.value)
            return false
            
        }else if cardholderName == nil || cardholderName?.count == 0 {
            vc.showAlertController(message: PaymentError.cardholderName.value)
            return false
            
        }else if (cardNumber?.count ?? 0) < 16 {
            vc.showAlertController(message: PaymentError.cardNumberLenghtShort.value)
            return false
            
        }else if expiryDate == nil || expiryDate?.count == 0 {
            vc.showAlertController(message: PaymentError.expiryDate.value)
            return false
            
        }else if cvv == nil || cvv?.count == 0 {
            vc.showAlertController(message: PaymentError.cvv.value)
            return false
            
        }else if cvv?.count != 3 {
            vc.showAlertController(message: PaymentError.cvvMin.value)
            return false
            
        } else if (cardNumber?.count ?? 0) > 16 {
            vc.showAlertController(message: PaymentError.cardNumberMaxLength.value)
            return false
        }
        
        return true
    }
}
