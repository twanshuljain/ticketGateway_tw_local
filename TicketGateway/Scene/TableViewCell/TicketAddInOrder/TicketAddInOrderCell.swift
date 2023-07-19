//
//  TicketAddInOrderCell.swift
//  TicketGateway
//
//  Created by Apple  on 16/05/23.
//

import UIKit

class TicketAddInOrderCell: UITableViewCell {
    
//MARK: - OUTLETS
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblTittleDis: UILabel!
    @IBOutlet weak var lblAmt: UILabel!
    @IBOutlet weak var lblAmtValue: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblDiscountValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
    }

   
    
    func setUi(){
         [self.lblAmt,lblTittleDis,lblAmtValue].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        self.lblTittle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        
        self.lblDiscount.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblDiscount.textColor = UIColor.setColor(colorType: .tgGreen)
        self.lblDiscountValue.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblDiscountValue.textColor = UIColor.setColor(colorType: .tgGreen)
    }
    
}
