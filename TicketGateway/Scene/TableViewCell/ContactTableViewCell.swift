//
//  ContactTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 28/06/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGeneralAdmission: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    func setFont() {
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.lblGeneralAdmission.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblGeneralAdmission.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
}
