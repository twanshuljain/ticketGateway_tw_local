//
//  FAQTablevIewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 30/05/23.
//

import UIKit

class FAQTableviewCell: UITableViewCell {
    
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setFont()
        
    }
    
    func setFont() {
        self.lblQuestion.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblAnswer.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblAnswer.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
  
}
