//
//  TicketAddInOrderCell.swift
//  TicketGateway
//
//  Created by Apple  on 16/05/23.
//

import UIKit

class TicketAddInOrderCell: UITableViewCell {

    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblTittleDis: UILabel!
    @IBOutlet weak var lblAmt: UILabel!
    @IBOutlet weak var lblAmtValue: UILabel!
    
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblDiscountValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUi(){
         [self.lblAmt,lblTittleDis,lblAmtValue].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
            $0?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        }
        self.lblTittle.font = UIFont.setFont(fontType: .semiBold, fontSize: .seventeen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblDiscount.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblDiscount.textColor = UIColor.setColor(colorType: .TGGreen)
        self.lblDiscountValue.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblDiscountValue.textColor = UIColor.setColor(colorType: .TGGreen)
    }
    
}
