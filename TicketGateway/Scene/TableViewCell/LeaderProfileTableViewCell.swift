//
//  LeaderProfileTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 29/06/23.
//

import UIKit

class LeaderProfileTableViewCell: UITableViewCell {

    // MARK: - OUTLETS

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblTitleValue:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()

    }

    func setData(indexPath:IndexPath) {
        if indexPath.row == 0{
            self.lblTitle.text = "Name"
            self.lblTitleValue.text = "Karen Jones"
        } else if indexPath.row == 1{
            self.lblTitle.text = "Email"
            self.lblTitleValue.text = "karen.dazzlecarnival@yahoo.com"
        } else if indexPath.row == 2{
            self.lblTitle.text = "Phone"
            self.lblTitleValue.text = "123-456-789"
        } else if indexPath.row == 3{
            self.lblTitle.text = "Location"
            self.lblTitleValue.text = "280 Consumers RD. Unit 344 North York ON M2J1P8"
        } else {
            self.lblTitle.text = "Opening Hours"
            self.lblTitleValue.text = "MON - FRI: 3:00 pm to 9:00 pm" + "\n" + "\n" + "SAT & SUN: 1:00 pm to 9:00 pm"
        }

    }

     func setUpUI() {
        self.lblTitle.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblTitle.textColor = UIColor.setColor(colorType: .tgBlack)

        self.lblTitleValue.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTitleValue.textColor = UIColor.setColor(colorType: .tgBlack)
        self.backgroundColor = UIColor.setColor(colorType: .bgPurpleColor)
    }

}
