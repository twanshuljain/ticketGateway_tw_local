//
//  WelComeCell.swift
//  TicketGateway
//
//  Created by Apple  on 13/04/23.
//

import UIKit

class WelComeCell: UICollectionViewCell {
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imgAdvertisement: UIImageView!
    @IBOutlet var imgPageControl: UIImageView!
    
    @IBOutlet weak var imgBg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       imgBg.translatesAutoresizingMaskIntoConstraints = false
       imgBg.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imgBg.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
       imgBg.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
       imgBg.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
       
    }
}
