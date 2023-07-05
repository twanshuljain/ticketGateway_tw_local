//
//  ManageOrderTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 23/05/23.
//

import UIKit

class ManageOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblFree: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblOrderNumberFree: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setFont() {
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblDate.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblDate.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblEmail.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblEmail.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblFree.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFree.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblOrderNumber.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblOrderNumber.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblOrderNumberFree.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblOrderNumberFree.textColor = UIColor.setColor(colorType: .lblTextPara)
        
    }
    
}
