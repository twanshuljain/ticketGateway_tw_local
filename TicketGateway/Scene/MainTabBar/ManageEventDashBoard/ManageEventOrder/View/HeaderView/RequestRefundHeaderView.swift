//
//  RequestRefundHeaderView.swift
//  TicketGateway
//
//  Created by Dr.Mac on 23/05/23.
//

import UIKit

class RequestRefundHeaderView: UITableViewHeaderFooterView {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnChevron: UIButton!
    @IBOutlet weak var vwLineView: UIView!
    
    override func awakeFromNib() {
     super.awakeFromNib()
        setFont()
    }
    
    func setFont() {
        lblName.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblPaymentStatus.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblPrice.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        lblPrice.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblPaymentStatus.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
       lblPaymentStatus.textColor = UIColor.setColor(colorType: .TGYellow)
        
        
    }
}
