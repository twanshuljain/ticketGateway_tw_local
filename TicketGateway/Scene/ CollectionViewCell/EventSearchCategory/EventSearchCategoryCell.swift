//
//  EventSearchCategoryCell.swift
//  TicketGateway
//
//  Created by Apple  on 22/05/23.
//

import UIKit

class EventSearchCategoryCell: UICollectionViewCell {

    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblTittle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgArrow.isHidden = true
    }
    
    
   
}
