//
//  PhotosProductCollectionViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 05/05/23.
//

import UIKit

class PhotosProductCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblSunburnReload: UILabel!
    @IBOutlet weak var lblFrontLine: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont()
       
    }
    
    func setFont() {
        lblSunburnReload.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        lblSunburnReload.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblFrontLine.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblFrontLine.textColor = UIColor.setColor(colorType: .Headinglbl)
        lblPrice.font = UIFont.setFont(fontType: .regular, fontSize: .eighteen)
      //  lblPrice.textColor = UIColor.setColor(colorType: UIColor.black.cgColor)
    }

}
