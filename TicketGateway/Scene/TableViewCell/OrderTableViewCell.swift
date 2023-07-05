//
//  OrderTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 22/05/23.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblPickedUp: UILabel!
    @IBOutlet weak var lblJouverRepublic: UILabel!
    @IBOutlet weak var btnChevron: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        self.lblPickedUp.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblPickedUp.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblJouverRepublic.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblJouverRepublic.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
}
