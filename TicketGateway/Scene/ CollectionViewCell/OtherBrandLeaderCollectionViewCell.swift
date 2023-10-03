//
//  OtherBrandLeaderCollectionViewCell.swift
//  TicketGateway
//
//  Created by Apple on 29/06/23.
//

import UIKit

class OtherBrandLeaderCollectionViewCell: UICollectionViewCell {
    
//MARK: - Outlets
    @IBOutlet weak var imgBrandLeader:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(imgName:String) {
        self.imgBrandLeader.image = UIImage.init(named: imgName)
    }

}
