//
//  SideMenuCell.swift
//  TicketGateway
//
//  Created by Apple  on 02/05/23.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
// MARK: - OUTLETS
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblDiscripation: UILabel!
    @IBOutlet weak var btnRisArrow: UIButton!
    @IBOutlet weak var imgSideMenuCategory: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        // Initialization code
    }
    func setUi() {
        self.lblTittle.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblTittle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblDiscripation.textColor = UIColor.setColor(colorType: .headinglbl)
  }
}

