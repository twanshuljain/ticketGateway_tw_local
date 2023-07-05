//
//  CostumeTypeCollectionViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
//

import UIKit

class CostumeTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCostumeType: UILabel!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setFont()
    }
    
    func setFont(){
        lblCostumeType.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
    }

}
