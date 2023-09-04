//
//  ContinueTransferRequest.swift
//  TicketGateway
//
//  Created by Apple on 04/09/23.
//

import Foundation

struct ContinueTransferRequest:Codable{
    var cell_phone, email, confirm_email, full_name : String?
}
