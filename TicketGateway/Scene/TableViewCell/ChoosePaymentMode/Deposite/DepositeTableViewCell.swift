//
//  DepositeTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 08/05/23.
//

import UIKit

class DepositeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDeposit: UILabel!
    @IBOutlet weak var lblFinalBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        lblDeposit.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblDeposit.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblFinalBalance.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        lblFinalBalance.textColor = UIColor.orange
    }
    
}
