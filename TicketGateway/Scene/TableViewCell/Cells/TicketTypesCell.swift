//
//  TicketTypesCell.swift
//  TicketGateway
//
//  Created by Apple  on 11/05/23.
//

import UIKit

class TicketTypesCell: UITableViewCell {

    @IBOutlet weak var vwDotted: UIView!
    @IBOutlet weak var vwStepper: CustomStepper!
    @IBOutlet weak var vwEtcDiscripation: UIView!
    @IBOutlet weak var vwForGroup: UIView!
    @IBOutlet weak var vwTittle: UIView!
    @IBOutlet weak var lblDiscripation: UILabel!
    @IBOutlet weak var lblAmountWithAdditionCharge: UILabel!
    @IBOutlet weak var lblSecAmount: UILabel!
    @IBOutlet weak var lblNoOfInGroup: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUi(){
        self.lblTittle.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.lblAmount.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAmount.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.lblNoOfInGroup.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblNoOfInGroup.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        
        self.lblSecAmount.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        self.lblSecAmount.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.lblAmountWithAdditionCharge.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAmountWithAdditionCharge.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
        vwDotted.createDottedLine(width: 1.5, color: UIColor.lightGray.cgColor, dashPattern: [1,4])
    }
    
}
