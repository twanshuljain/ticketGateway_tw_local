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
        setFont()
       
     
    }
    
    func setFont(){
    lblProduct.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblProduct.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
}
