//
//  CostumeTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 03/05/23.
//

import UIKit
import SwiftUI

class CostumeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblFrontLine: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgCostumeImage: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
   
    @IBOutlet weak var lblFlexiblePayment: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var vwLikeShare: UIView!
    
    @IBOutlet weak var vwGradientView: GradientView!
    @IBOutlet weak var lblDescription: UILabel!
   
    @IBOutlet weak var btnLike: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setFont() {
        lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblFrontLine.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblFrontLine.textColor = UIColor.setColor(colorType: .Headinglbl)
        lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblTime.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblPrice.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        lblFlexiblePayment.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblFlexiblePayment.textColor = UIColor.setColor(colorType: .TGBlack)
        btnRegister.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnRegister.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        lblDescription.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
        btnLike.addTarget(self, action: #selector(btnImage(sender:)), for:  .touchUpInside)
       
    }
    
    @objc func btnImage(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            btnLike.setImage(UIImage(named: "Like_ip"), for: .selected)

        } else {
            btnLike.setImage(UIImage(named: "favUnSele_ip"), for: .normal)

        }
    }
}
