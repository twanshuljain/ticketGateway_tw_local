//
//  TransactionsListCell.swift
//  TicketGateway
//
//  Created by Apple  on 08/05/23.
//

import UIKit

class TransactionsListCell: UITableViewCell {

// MARK: - Outlets
    @IBOutlet weak var vwCreditDebit: UIView!
    @IBOutlet weak var btnOpen: UIButton!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var vwBorder: UIView!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setUi() {
        self.lblTittle.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblAmount.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblAmount.textColor = UIColor.setColor(colorType: .tgBlack)
    }
    
}
