//
//  TransferTicketHeaderView.swift
//  TicketGateway
//
//  Created by Dr.Mac on 31/05/23.
//

import UIKit

class TransferTicketHeaderView: UITableViewHeaderFooterView {

   
    @IBOutlet weak var lblTicketTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnUp: UIButton!
    
    @IBOutlet weak var headerBottomLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }
   
    func setFont() {
        self.lblTicketTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblTicketTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblPrice.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblPrice.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
    }

}
