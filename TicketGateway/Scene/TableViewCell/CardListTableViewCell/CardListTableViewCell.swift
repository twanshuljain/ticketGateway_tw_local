//
//  CardListTableViewCell.swift
//  TicketGateway
//
//  Created by apple on 10/17/23.
//

import UIKit

class CardListTableViewCell: UITableViewCell {
    @IBOutlet var lblCardHolderName: UILabel!
    @IBOutlet var lblCardType: UILabel!
    @IBOutlet var lblCardNumber: UILabel!
    @IBOutlet var imgCardSelect: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
