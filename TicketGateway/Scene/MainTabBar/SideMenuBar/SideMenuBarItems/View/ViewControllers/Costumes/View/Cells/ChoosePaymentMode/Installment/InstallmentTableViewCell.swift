//
//  InstallmentTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 08/05/23.
//

import UIKit

class InstallmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDownPayment: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCAD: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        lblDownPayment.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        lblDownPayment.textColor = UIColor.setColor(colorType: .TGBlack)
        lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblTime.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblPrice.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        lblPrice.textColor = UIColor.setColor(colorType: .TGBlack)
        lblCAD.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblCAD.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
}
