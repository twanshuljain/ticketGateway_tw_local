//
//  SearchLocationCell.swift
//  TicketGateway
//
//  Created by Apple  on 22/05/23.
//

import UIKit

class SearchLocationCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var lblOnOFF: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var btnCheck: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    func setFont() {
        self.lblTittle.font = UIFont.setFont(fontType: .semiBold, fontSize: .twenty)
        self.lblTittle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblOnOFF.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblOnOFF.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)

    }

}
