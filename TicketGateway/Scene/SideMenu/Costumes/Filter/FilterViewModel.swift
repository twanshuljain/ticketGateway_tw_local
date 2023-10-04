//
//  FilterViewModel.swift
//  TicketGateway
//
//  Created by Apple on 28/06/23.
//

import Foundation

final class FilterViewModel{

    // MARK: - Variables
    var arrFilterSection = ["By Price","By Gender","By types","Flexipay","Refundable"]
    var arrFilter = ["Last Week","Last Month","Specific Date range"]
    var selectedFilterSectionIndex = 0
    var selectedFilterIndex:Int? = nil
}
