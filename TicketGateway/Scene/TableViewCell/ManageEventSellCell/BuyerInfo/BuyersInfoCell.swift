//
//  BuyersInfoCell.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
//

import UIKit

class BuyersInfoCell: UITableViewCell {

//MARK: - Outlets
    @IBOutlet weak var vwPopUp: CustomSocialLoginView!
    @IBOutlet weak var lblFristAndLastName: UILabel!
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnMenuMore: UIButton!
    
    override func awakeFromNib() {
    super.awakeFromNib()
        self.setUi()
        //  code
    }
    
    func setUi() {
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblEmail.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblEmail.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblNumber.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblNumber.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.vwPopUp.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
