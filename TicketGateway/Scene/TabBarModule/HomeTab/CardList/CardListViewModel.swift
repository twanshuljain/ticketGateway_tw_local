//
//  CardListViewModel.swift
//  TicketGateway
//
//  Created by apple on 10/17/23.
//

import Foundation
class CardListViewModel {
    var isTransactionFailed: Bool = false
    var createCharge:CreateCharge?
    var selectedArrTicketList = [EventTicket]()
    var selectedCurrencyType = ""
    var totalTicketPrice = ""
    var arrCardList:[CardList]?
    
}
