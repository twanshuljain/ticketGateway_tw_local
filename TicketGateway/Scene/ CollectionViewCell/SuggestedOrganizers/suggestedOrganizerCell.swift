//
//  suggestedOrganizerCell.swift
//  TicketGateway
//
//  Created by Apple  on 28/04/23.
//

import UIKit

class suggestedOrganizerCell: UICollectionViewCell {
    
    @IBOutlet weak var vwImgProfile: UIView!
    @IBOutlet weak var btnFollerwers: CustomButtonGradiant!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        // Initialization code
    }
    
    func setUi(){
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblFollowers.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblFollowers.textColor = UIColor.setColor(colorType: .Headinglbl)
        self.btnFollerwers.setTitles(text: "Following", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
       
    }
    
    

}
