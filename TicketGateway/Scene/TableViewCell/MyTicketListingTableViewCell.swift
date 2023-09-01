//
//  MyTicketListingTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 01/09/23.
//

import UIKit

class MyTicketListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTicketName : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(ticketData:MyTicket){
        self.lblTicketName.text = ((ticketData.ticketName ?? "") + " - " + "\(ticketData.date?.getDateFormattedISOFromTo() ?? "")")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
