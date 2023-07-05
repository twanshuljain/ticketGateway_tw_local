//
//  InstallmentHeaderView.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 08/05/23.
//

import UIKit

class InstallmentHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblInstallment: UILabel!
    @IBOutlet weak var lblAfterDownpayment: UILabel!
    @IBOutlet weak var btnSelected: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont()
       
        
        
    }

    
    func setFont() {
        lblInstallment.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        lblInstallment.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        lblAfterDownpayment.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        lblAfterDownpayment.textColor = UIColor.setColor(colorType: .lblTextPara)
        //btnSelected.addTarget(self, action: #selector(setImage(_:)), for: .touchUpInside)
      //  btnAdd.addTarget(self, action: #selector(setImage(_:)), for: .touchUpInside)
       // btnSelected.setImage(UIImage(named: "Selected_ip"), for: .selected)
       // btnSelected.setImage(UIImage(named: "Unselected_ip"), for: .normal)

    }
    
//    @objc func setImage(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//
//
//    }
    
    
    
   
    
}
