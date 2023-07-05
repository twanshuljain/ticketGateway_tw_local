//
//  OrderDetailTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 08/05/23.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

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
    setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        lblDescription.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        lblOrderDetails.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        lblOrderDetails.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        lblItemsAdd.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        lblItemsAdd.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        lblTitleCostumePrice.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblTitleCostumePrice.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblCostumePrice.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblCostumePrice.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        lblTitleDiscounted.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
      //  lblTitleDiscounted.textColor = UIColor.setColor(colorType: .txtGreen)
        lblDiscounted.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
     //   lblDiscounted.textColor = UIColor.setColor(colorType: .txtGreen )
        
        lblTitleServiceCharge.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblTitleServiceCharge.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblServiceCharge.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblServiceCharge.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        lblTitleTotalAmount.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        lblTitleTotalAmount.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblTotalAmount.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        lblTotalAmount.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        lblCA109.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        lblCA109.textColor = UIColor.setColor(colorType: .lightBlack)
        
        lblCA800.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblCA800.textColor = UIColor.setColor(colorType: .lblTextPara)
        btnContinue.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnContinue.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
        dottedDiscounted.createDottedLine(width: 1, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [3,5])
        dottedLineServiceCharge.createDottedLine(width: 1, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [3,5])

    }
    
}
