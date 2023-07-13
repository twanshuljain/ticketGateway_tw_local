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
    
    func setData(tagName:String?){
        self.lblName.text = tagName ?? ""
    }
    
    func setUi(){
        self.lblName.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TGBlue)
     }
    

}
