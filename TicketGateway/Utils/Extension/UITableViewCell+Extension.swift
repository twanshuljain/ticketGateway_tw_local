//
//  UITableViewCell+Extension.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
//

import Foundation
import UIKit

extension UITableViewCell {
    func timeStampToDateTimeString(timeStamp: Double) -> String {
           let date = NSDate(timeIntervalSince1970: timeStamp / 1000)
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss a"
           dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
           let dateString = dateFormatter.string(from: date as Date)
           return dateString
       }
  public func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    public func convertTimeFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    public func convertOnlyMinutesFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "mm"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
}
