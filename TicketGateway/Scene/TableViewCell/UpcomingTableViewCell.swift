//
//  UpcomingTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 15/05/23.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgImage: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
  
    @IBOutlet weak var btnSeeTickets: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFonts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFonts() {
        self.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTime.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.btnSeeTickets.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSeeTickets.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlack)
    }
    
}
