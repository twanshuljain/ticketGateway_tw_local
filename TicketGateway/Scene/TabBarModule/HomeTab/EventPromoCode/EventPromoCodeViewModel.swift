//
//  EventPromoCodeViewModel.swift
//  TicketGateway
//
//  Created by Apple on 16/08/23.
//

import UIKit

final class EventPromoCodeViewModel{
    // MARK: - Variables
    let isPromoCodeApplied: Bool = false
    var eventDetail:EventDetail?
    var feeStructure:FeeStructure?
    var selectedArrTicketList = [EventTicket]()
    var eventId:Int?
    var selectedAddOnList = [EventTicketAddOnResponseModel]()
    var finalPrice = 0.0
    var lblNumberOfCount = 0
}

extension EventPromoCodeViewModel{
    
}
