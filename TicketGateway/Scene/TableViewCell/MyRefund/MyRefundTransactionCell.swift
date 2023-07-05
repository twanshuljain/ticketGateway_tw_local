//
//  MyRefundTransactionCell.swift
//  TicketGateway
//
//  Created by Apple  on 29/05/23.
//

import UIKit

class MyRefundTransactionCell: UITableViewCell {
    
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblStatusValue: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDateValue: UILabel!
    @IBOutlet weak var lblSpent: UILabel!
    @IBOutlet weak var lblSpentValue: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblPointValue: UILabel!
   
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
        
        [self.lblDate,self.lblStatus,self.lblSpent,self.lblPoint].forEach {
            $0.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0.textColor = UIColor.setColor(colorType: .TGGrey)
            
        }
        
        [self.lblDateValue,self.lblStatusValue,self.lblSpentValue,self.lblPointValue].forEach {
            $0.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0.textColor = UIColor.setColor(colorType: .lightBlack)
            
        }
        
        self.lblStatusValue.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblStatusValue.textColor = UIColor.setColor(colorType: .TGYellow)
        
    }
    
}
