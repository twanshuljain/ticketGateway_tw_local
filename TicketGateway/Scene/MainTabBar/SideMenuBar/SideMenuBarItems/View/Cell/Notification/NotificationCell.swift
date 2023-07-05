//
//  NotificationCell.swift
//  TicketGateway
//
//  Created by Apple  on 02/06/23.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
   @IBOutlet weak var lblTIttle: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        self.setUi()
        super.awakeFromNib()
        // Initialization code
    }
    func setUi(){
        
        [self.lblDay,self.lblTime,].forEach {
            $0.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
            $0.textColor = UIColor.setColor(colorType: .lblTextPara)
            
        }
        lblTIttle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        lblTIttle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
