//
//  ManageEventSettingTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 05/07/23.
//

import UIKit

class ManageEventSettingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitleDescription: UILabel!
    @IBOutlet weak var swSwitch: UISwitch!
    @IBOutlet weak var vwTopBorder: UIView!
    @IBOutlet weak var vwBottomBorder: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    func setFont() {
        lblTitle.font = UIFont.setFont(fontType: .medium, fontSize:  .fourteen)
        lblTitleDescription.font = UIFont.setFont(fontType: .regular, fontSize:  .twelve)
        lblTitleDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
}
