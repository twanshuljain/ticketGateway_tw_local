//
//  RefundRequestTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 23/05/23.
//

import UIKit

class RefundRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblServiceValue: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblEmailValue: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblPhoneValue: UILabel!
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnApprove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        self.lblService.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblService.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblServiceValue.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblServiceValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblEmail.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblEmail.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblEmailValue.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblEmailValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblPhone.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblPhone.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblPhoneValue.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblPhoneValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.btnDecline.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnDecline.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.btnApprove.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnApprove.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlack)
        
    }
    
}
