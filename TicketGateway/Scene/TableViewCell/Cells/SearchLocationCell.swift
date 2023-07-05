//
//  SearchLocationCell.swift
//  TicketGateway
//
//  Created by Apple  on 22/05/23.
//

import UIKit

class SearchLocationCell: UITableViewCell {

    @IBOutlet weak var lblOnOFF: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    override func awakeFromNib() {
        self.lblTittle.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        
        self.lblTittle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        
        self.lblOnOFF.font = UIFont.setFont(fontType: .medium, fontSize: .seventeen)
        
        self.lblOnOFF.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
