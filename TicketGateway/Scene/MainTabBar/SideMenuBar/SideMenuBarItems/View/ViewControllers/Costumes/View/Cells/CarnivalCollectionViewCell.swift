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
        setFont()
    }
    
    func setFont() {
        lblCarnival.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblCarnival.textColor = UIColor.setColor(colorType: .Headinglbl)
    }
}
