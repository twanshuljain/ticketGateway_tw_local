//
//  Date+Extension.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
//

import Foundation
import UIKit

extension Date {
    var workoutStartTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        return dateFormatter.string(from: self)
    }
    
    var workoutEndTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        return dateFormatter.string(from: self)
    }
}
