//
//  SoldOutTicketTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 03/07/23.
//

import UIKit

class SoldOutTicketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblGeneralAdmission: UILabel!
    @IBOutlet weak var lblTotalTicket: UILabel!
    @IBOutlet weak var btnRight: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }
    
    func setFont() {
        self.lblGeneralAdmission.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblGeneralAdmission.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblTotalTicket.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTotalTicket.textColor = UIColor.setColor(colorType: .lblTextPara)
        
    }

   
    
}
