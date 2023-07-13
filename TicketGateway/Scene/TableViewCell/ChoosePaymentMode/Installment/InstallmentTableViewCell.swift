//
//  InstallmentTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 08/05/23.
//

import UIKit

class InstallmentTableViewCell: UITableViewCell {
    
//MARK: - Outltes
    @IBOutlet weak var lblDownPayment: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCAD: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        self.lblDownPayment.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblDownPayment.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTime.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblPrice.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblPrice.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblCAD.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblCAD.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
}
