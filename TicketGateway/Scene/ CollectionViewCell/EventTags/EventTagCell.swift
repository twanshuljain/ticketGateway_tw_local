//
//  EventTagCell.swift
//  TicketGateway
//
//  Created by Apple  on 05/05/23.
//

import UIKit

class EventTagCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        // Initialization code
    }
    
    func setUi(){
        self.lblName.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TGBlue)
     }
    

}
