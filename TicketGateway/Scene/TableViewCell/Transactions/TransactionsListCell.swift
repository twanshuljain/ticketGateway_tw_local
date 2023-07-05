//
//  TransactionsListCell.swift
//  TicketGateway
//
//  Created by Apple  on 08/05/23.
//

import UIKit

class TransactionsListCell: UITableViewCell {

    @IBOutlet weak var vwCreditDebit: UIView!
    @IBOutlet weak var btnOpen: UIButton!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var vwBorder: UIView!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUi()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUi(){
        self.lblTittle.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblAmount.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblAmount.textColor = UIColor.setColor(colorType: .TGBlack)
    }
    
}
