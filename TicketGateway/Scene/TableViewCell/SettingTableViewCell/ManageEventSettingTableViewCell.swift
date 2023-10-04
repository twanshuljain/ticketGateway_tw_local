//
//  ManageEventSettingTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 05/07/23.
//

import UIKit

class ManageEventSettingTableViewCell: UITableViewCell {

// MARK: - Outlets
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
        self.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize:  .fourteen)
        self.lblTitleDescription.font = UIFont.setFont(fontType: .regular, fontSize:  .twelve)
        self.lblTitleDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
    }

}
