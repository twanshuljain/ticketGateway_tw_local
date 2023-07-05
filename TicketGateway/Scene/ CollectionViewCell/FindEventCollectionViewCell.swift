//
//  FindEventCollectionViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 29/05/23.
//

import UIKit

class FindEventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib(){
    super.awakeFromNib()
        self.setFont()
        
    }
    
    func setFont() {
        self.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
    }
}
