//
//  CarnivalCollectionViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
//

import UIKit

class CarnivalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblCarnival: UILabel!
    @IBOutlet weak var imgCarnivalImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    func setFont() {
        self.lblCarnival.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblCarnival.textColor = UIColor.setColor(colorType: .headinglbl)
        self.backgroundColor = UIColor.setColor(colorType: .bgPurpleColor)
    }
}
