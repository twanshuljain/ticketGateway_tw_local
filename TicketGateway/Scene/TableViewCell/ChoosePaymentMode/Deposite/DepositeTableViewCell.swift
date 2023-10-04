//
//  DepositeTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 08/05/23.
//

import UIKit

class DepositeTableViewCell: UITableViewCell {
    
//MARK: - Ouultes
    @IBOutlet weak var lblDeposit: UILabel!
    @IBOutlet weak var lblFinalBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        self.lblDeposit.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblDeposit.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblFinalBalance.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblFinalBalance.textColor = UIColor.orange
    }
    
}
