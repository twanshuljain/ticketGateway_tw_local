//
//  ReviewRefundTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 07/06/23.
//

import UIKit

class ReviewRefundTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAtTheDoor: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblGeneralAdmission: UILabel!
    
    @IBOutlet weak var lblBarCodd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        self.lblAtTheDoor.font = UIFont.setFont(fontType: .medium, fontSize:    .fourteen)
        self.lblAtTheDoor.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblPrice.font = UIFont.setFont(fontType: .medium, fontSize:    .fourteen)
        self.lblPrice.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblGeneralAdmission.font = UIFont.setFont(fontType: .regular, fontSize:    .twelve)
        self.lblGeneralAdmission.textColor = UIColor.setColor(colorType: .TGGrey)
        
        self.lblBarCodd.font = UIFont.setFont(fontType: .regular, fontSize:    .twelve)
        self.lblBarCodd.textColor = UIColor.setColor(colorType: .TGGrey)
        
    }
    
}
