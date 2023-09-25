//
//  Double+Extension.swift
//  TicketGateway
//
//  Created by Apple on 22/09/23.
//

import UIKit

extension Double{
    func convertToTwoDecimalPlaces() -> String? {
        return String(format: "%.2f", self)
    }
}
