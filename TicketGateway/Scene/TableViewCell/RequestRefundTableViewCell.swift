//
//  RefundTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 05/06/23.
//

import UIKit

class RequestRefundTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTicketId: UILabel!
    @IBOutlet weak var lblTicketIdValue: UILabel!
    @IBOutlet weak var lblTicketName: UILabel!
    @IBOutlet weak var lblTicketNameValue: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        self.lblTicketId.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTicketId.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblTicketIdValue.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblTicketIdValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblTicketName.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTicketName.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblTicketNameValue.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblTicketNameValue.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
}
