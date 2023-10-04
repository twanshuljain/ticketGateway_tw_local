//
//  PeopleCollectionCell.swift
//  TicketGateway
//
//  Created by Apple  on 10/05/23.
//

import UIKit

class PeopleCollectionCell: UICollectionViewCell {
    
    
    // MARK: - Outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgPeople: UIImageView!
    @IBOutlet weak var btnClick: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  self.vwContainer.setCollectionProfileView(vwOuter: self.vwContainer, img: self.imgPeople , radius : 20)
        //self.vwContainer.setViewShadow()
    }
    
}
