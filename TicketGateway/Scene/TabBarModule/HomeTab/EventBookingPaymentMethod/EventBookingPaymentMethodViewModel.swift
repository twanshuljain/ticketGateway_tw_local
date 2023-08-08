//
//  EventBookingPaymentMethodViewModel.swift
//  TicketGateway
//
//  Created by Apple on 28/07/23.
//

import UIKit
import Stripe

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
    
    var stripeUser:StripeCreateUser?
    var addCard:AddCard?
    var selectedMonth : String?
    var selectedYear : String?
    
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
    
    func createCustomer(vc:EventBookingPaymentMethodVC){
        vc.view.showLoading(centreToView: vc.view)
        StripeClasses().stripeCreateCustomer(controller: vc) { createUserResponse, isTrue, message in
            vc.view.stopLoading()
            if isTrue == true  && createUserResponse != nil{
                self.stripeUser = createUserResponse
               
            }else{
                
            }
        }
    }
    
    func checkValidations(vc:EventBookingPaymentMethodVC){
        let validate = self.validateCreditCard(vc.txtCardName.text ?? "", vc.txtCardNumber.text ?? "", vc.txtExpiryDate.text ?? "", vc.txtCVV.text ?? "", vc)
        
        if validate{
            self.addCardForUser(vc: vc)
        }
        
    }
    
    func addCardForUser(vc:EventBookingPaymentMethodVC){
        if let name = vc.txtCardName.text, let cardNumber = vc.txtCardNumber.text, let expDetail = vc.txtExpiryDate.text, let cvv = vc.txtCVV.text{
            vc.view.showLoading(centreToView: vc.view)
            StripeClasses().addCardForUser(name: name, cardNumber: cardNumber, expMonth: 0, expYear: 0, cvv: cvv, controller: vc) { addCardResponse, isTrue, messgage in
                vc.view.stopLoading()
                if isTrue == true  && addCardResponse != nil{
                    self.addCard = addCardResponse
                }else{
                    
                }
            }
        }
        
    }
    
    //MARK:- func validateCreditCard
    func validateCreditCard(_ cardholderName:String?,_ cardNumber:String?,_ expiryDate:String?,_ cvv:String? ,_ vc:EventBookingPaymentMethodVC)-> Bool{
        if cardholderName == nil || cardholderName?.count == 0 {
            vc.showAlertController(message: PaymentError.cardholderName.value)
            return false
            
        }else if cardNumber == nil || cardNumber?.count == 0 {
            vc.showAlertController(message: PaymentError.cardNumber.value)
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
            
        }
        
        return true
    }
}
