//
//  TicketOverAllEstimateBarCell.swift
//  TicketGateway
//
//  Created by Apple  on 19/05/23.
//

import UIKit

class TicketOverAllEstimateBarCell: UITableViewCell {
    
    @IBOutlet weak var lblTotalValue: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lbltittle: UILabel!
    override func awakeFromNib() {
        setUi()
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
    func setUi(){
        
        
        self.lbltittle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lbltittle.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblValue.font = UIFont.setFont(fontType: .medium, fontSize: .fifteen)
        self.lblValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTotalValue.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblTotalValue.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
}
