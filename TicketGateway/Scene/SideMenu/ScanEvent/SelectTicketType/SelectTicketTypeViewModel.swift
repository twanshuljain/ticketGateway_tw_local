//
//  SelectTicketTypeViewModel.swift
//  TicketGateway
//
//  Created by Apple on 30/06/23.
//

import Foundation
class SelectTicketTypeViewModel {
    var isSelectAll: Bool = false
    var arrSelectedTicketTypeList: [String] = []
    var getScanTicketDetails = GetScanTicketDetails()
    var arrTicketTypeList: [String] = []
}
