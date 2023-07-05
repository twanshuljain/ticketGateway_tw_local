//
//  TransactionDetailCell.swift
//  TicketGateway
//
//  Created by Apple  on 08/05/23.
//

import UIKit

class TransactionDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblTicketID: UILabel!
    @IBOutlet weak var lblTicketName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTicketIDValue: UILabel!
    @IBOutlet weak var lblTicketNameValue: UILabel!
    @IBOutlet weak var lblDateValue: UILabel!
   
    @IBOutlet weak var vwBorder: UIView!
    
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
        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDate.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblTicketID.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTicketID.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblTicketName.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTicketName.textColor = UIColor.setColor(colorType: .TGGrey)
        
        self.lblTicketIDValue.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblTicketIDValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTicketNameValue.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblTicketNameValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblDateValue.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblDateValue.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
}
