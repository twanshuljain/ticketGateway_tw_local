//
//  ProductDetailCollectionViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
       
     
    }
    
    func setFont(){
        self.lblProduct.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblProduct.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
}
