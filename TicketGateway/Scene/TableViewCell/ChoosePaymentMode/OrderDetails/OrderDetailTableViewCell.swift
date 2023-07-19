//
//  OrderDetailTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 08/05/23.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {
 
//MARK: - Outlets
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblOrderDetails: UILabel!
    @IBOutlet weak var lblItemsAdd: UILabel!
    @IBOutlet weak var lblTitleCostumePrice: UILabel!
    @IBOutlet weak var lblCostumePrice: UILabel!
    @IBOutlet weak var lblTitleDiscounted: UILabel!
    @IBOutlet weak var lblDiscounted: UILabel!
    @IBOutlet weak var lblTitleServiceCharge: UILabel!
    @IBOutlet weak var lblServiceCharge: UILabel!
    
    @IBOutlet weak var dottedLineServiceCharge: UIView!
    @IBOutlet weak var dottedDiscounted: UIView!
    @IBOutlet weak var lblTitleTotalAmount: UILabel!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblCA109: UILabel!
    @IBOutlet weak var lblCA800: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setFont() {
        self.lblDescription.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblOrderDetails.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblOrderDetails.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        
        self.lblItemsAdd.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblItemsAdd.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        
        self.lblTitleCostumePrice.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTitleCostumePrice.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblCostumePrice.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblCostumePrice.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        
        self.lblTitleDiscounted.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTitleDiscounted.textColor = UIColor.setColor(colorType: .tgGreen)
        self.lblDiscounted.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDiscounted.textColor = UIColor.setColor(colorType: .tgGreen )
        
        self.lblTitleServiceCharge.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTitleServiceCharge.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblServiceCharge.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblServiceCharge.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        
        self.lblTitleTotalAmount.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblTitleTotalAmount.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblTotalAmount.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblTotalAmount.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        
        self.lblCA109.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblCA109.textColor = UIColor.setColor(colorType: .lightBlack)
        
        self.lblCA800.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblCA800.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnContinue.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnContinue.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
        self.dottedDiscounted.createDottedLine(width: 1, color: UIColor.setColor(colorType: .borderLineColour).cgColor, dashPattern: [3,5])
        self.dottedLineServiceCharge.createDottedLine(width: 1, color: UIColor.setColor(colorType: .borderLineColour).cgColor, dashPattern: [3,5])
        
        
    }
    
    
}
