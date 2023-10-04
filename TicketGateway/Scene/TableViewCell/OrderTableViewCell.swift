//
//  OrderTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 22/05/23.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

//MARK: - OUTLETS
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblJouverRepublic: UILabel!
    @IBOutlet weak var btnSeeCostumes: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        self.lblJouverRepublic.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblJouverRepublic.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnSeeCostumes.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSeeCostumes.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
    }
    
}
