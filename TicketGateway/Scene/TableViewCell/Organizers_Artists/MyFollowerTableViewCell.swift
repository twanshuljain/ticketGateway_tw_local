//
//  MyFollowerTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 08/06/23.
//

import UIKit

class MyFollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFonts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFonts(){
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblFollowers.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblFollowers.textColor = UIColor.setColor(colorType: .Headinglbl)
        
    }
    

}
