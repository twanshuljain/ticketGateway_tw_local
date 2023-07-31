//
//  EventBookingPaymentMethodViewModel.swift
//  TicketGateway
//
//  Created by Apple on 28/07/23.
//

import UIKit

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
    
}
