//
//  DescriptionTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 29/06/23.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDescription:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }

    func setUpUI() {
        self.lblDescription.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDescription.textColor = UIColor.setColor(colorType: .AppleDarkGrey)
        self.backgroundColor = UIColor.setColor(colorType: .BgPurpleColor)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
