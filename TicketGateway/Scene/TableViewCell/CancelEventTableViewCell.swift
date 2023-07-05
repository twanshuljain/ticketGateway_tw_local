//
//  CancelEventTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 03/07/23.
//

import UIKit

class CancelEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    func setFont() {
        lblTitle.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
    }
   
}
