//
//  AddOnTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 09/05/23.
//

import UIKit
import iOSDropDown

class AddOnTableViewCell: UITableViewCell {

// MARK: - Variables
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var vwStepper: CustomStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        
        self.lblTitle.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblTitle.textColor = UIColor.setColor(colorType: .lightBlack)
        self.lblPrice.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblPrice.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
    }
    
     
  
}
