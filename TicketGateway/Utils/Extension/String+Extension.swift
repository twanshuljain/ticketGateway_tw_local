//
//  String+Extension.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
//

import Foundation
import UIKit

extension String {
    public func trim() -> String {
       return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func timeStampToString(timeStamp: Double) -> (strdate: String, strtime: String)? {
        let date = NSDate(timeIntervalSince1970: timeStamp / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss a"
        timeFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeString = timeFormatter.string(from: date as Date)
        return (dateString, timeString)
    }
    
    var toDouble: Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0.0
    }
   
    var toInt: Int {
        return NumberFormatter().number(from: self)?.intValue ?? 0
    }
    
    
    func getDateFormattedFrom(_ dateFormate: String = "MMM d") -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if dateFormatter.date(from: self) == nil{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = dateFormate
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }else{
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = dateFormate
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        //?? Date.init()
        
    }
    
    func getDateFormattedFromTo() -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if dateFormatter.date(from: self) == nil{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }else{
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        
    }
    
    
    func getFormattedTime() -> String{
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: self) ?? Date.init()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func getDateFormattedDateFromString() -> Date {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        let mainDate = dateFormatter.date(from: dateString) ?? Date()
        return mainDate
    }
    
   
}
