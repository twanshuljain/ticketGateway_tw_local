//
//  Organizers_Artists_ListCell.swift
//  TicketGateway
//
//  Created by Apple  on 04/05/23.
//

import UIKit

class Organizers_Artists_ListCell: UITableViewCell {
    
//MARK: - Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnfollow: CustomButtonGradiant!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblName: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
    }

    
    func setUi(){
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblFollowers.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblFollowers.textColor = UIColor.setColor(colorType: .Headinglbl)
        self.btnfollow.setTitles(text: "Follow", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
       
    }
    

}
