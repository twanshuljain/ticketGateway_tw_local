//
//  NotificationCell.swift
//  TicketGateway
//
//  Created by Apple  on 02/06/23.
//

import UIKit

class NotificationCell: UITableViewCell {

// MARK: - Oultes
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTIttle: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
    }
    func setUi() {

        [self.lblDay,self.lblTime,].forEach {
            $0.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
            $0.textColor = UIColor.setColor(colorType: .lblTextPara)

        }
        self.lblTIttle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblTIttle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)

    }

}
