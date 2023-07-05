//
//  ReqRefundHeaderView.swift
//  TicketGateway
//
//  Created by Dr.Mac on 05/06/23.
//

import UIKit

class ReqRefundHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var headerBottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }
    
    func setFont() {
        self.lblNumber.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblNumber.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblPrice.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblPrice.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
    }
}
