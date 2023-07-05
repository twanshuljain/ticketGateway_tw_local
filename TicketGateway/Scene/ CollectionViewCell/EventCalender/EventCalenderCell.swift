//
//  EventCalenderCell.swift
//  TicketGateway
//
//  Created by Apple  on 05/05/23.
//

import UIKit

class EventCalenderCell: UICollectionViewCell {

    @IBOutlet weak var lblDay: UILabel!
   
    @IBOutlet weak var lblMonth_Year: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        // Initialization code
    }

    func setUi(){
        self.lblDate.font = UIFont.setFont(fontType: .medium, fontSize: .twenty)
        self.lblDate.textColor = UIColor.setColor(colorType: .TGBlack)
      
        self.lblDay.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDay.textColor = UIColor.setColor(colorType: .Headinglbl)
    }
    
}
