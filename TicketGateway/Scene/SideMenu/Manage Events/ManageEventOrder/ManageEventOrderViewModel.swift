//
//  ManageEventOrderViewModel.swift
//  TicketGateway
//
//  Created by Apple on 22/06/23.

import Foundation
import UIKit

final class ManageEventOrderViewModel{

    // MARK: - Variables
    var isRefundRequest = false
    let orderTableData = ["David Taylor", "David Taylor", "David Taylor"]
    var arrData = [
        ExpandableName(isExpanded: false),
        ExpandableName(isExpanded: false),
        ExpandableName(isExpanded: false),
        ExpandableName(isExpanded: false),
        ExpandableName(isExpanded: false),
        ExpandableName(isExpanded: false),
        ExpandableName(isExpanded: false),
        ExpandableName(isExpanded: false)
    ]
}
