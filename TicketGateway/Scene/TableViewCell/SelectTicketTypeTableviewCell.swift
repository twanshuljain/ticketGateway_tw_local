//
//  SelectTicketTypeTableviewCell.swift
//  TicketGateway
//
//  Created by Apple on 16/06/23.
//

import UIKit

class SelectTicketTypeTableviewCell: UITableViewCell {
    
//MARK: - Outlets
    @IBOutlet weak var lblTicketType: UILabel!
    @IBOutlet weak var swTicketTypeSwitch: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    func setFont() {
        self.lblTicketType.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.swTicketTypeSwitch.onTintColor = UIColor.setColor(colorType: .TGBlue)
    }

}
