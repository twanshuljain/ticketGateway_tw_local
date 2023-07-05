//
//  ManageEventSellTicketCell.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.
//

import UIKit

class ManageEventSellTicketCell: UITableViewCell {

    
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblTittleDis: UILabel!
    @IBOutlet weak var lblAmountComp: UILabel!
    @IBOutlet weak var vwStepper: CustomStepper!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTittle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblAmountComp.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblAmountComp.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblOrderStatus.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblOrderStatus.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTittleDis.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblTittleDis.textColor = UIColor.setColor(colorType: .lblTextPara)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
