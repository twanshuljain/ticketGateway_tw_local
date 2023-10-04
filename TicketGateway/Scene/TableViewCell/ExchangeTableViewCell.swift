//
//  ExchangeTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
//

import UIKit
import iOSDropDown

class ExchangeTableViewCell: UITableViewCell {

// MARK: - OUTLETS
    @IBOutlet weak var lblYoungGold: UILabel!
    @IBOutlet weak var lblQty: UILabel!

    @IBOutlet weak var vwAlreadyExcahenge: UIView!
    @IBOutlet weak var lblAlreadyExchange: UILabel!

    @IBOutlet weak var swSwitch: UISwitch!

    @IBOutlet weak var vwTxtView: UIView!
    @IBOutlet weak var txtField: DropDown!
    @IBOutlet weak var btnDropDown: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setFont() {
        self.lblYoungGold.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblYoungGold.textColor = UIColor.setColor(colorType: .tgBlack)

        self.lblQty.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblQty.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)

        self.lblAlreadyExchange.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblAlreadyExchange.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.swSwitch.onTintColor = UIColor.setColor(colorType: .tgBlue)

        self.txtField.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.txtField.textColor = UIColor.setColor(colorType: .lblTextPara)

    }

    @IBAction func actionSwitch(_ sender: UISwitch) {

        if sender.isOn {
            self.vwTxtView.isHidden = false
        } else {
            self.vwTxtView.isHidden = true
        }
    }
}
