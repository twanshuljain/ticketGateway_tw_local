//
//  AddOnTableViewCell.swift
//  Costumes_TG
//
//  Created by Dr.Mac on 09/05/23.
//

import UIKit
import iOSDropDown

class AddOnTableViewCell: UITableViewCell {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var bgTextView: UIView!
    @IBOutlet weak var txtSelect: DropDown!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFont() {
        lblTitle.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        lblTitle.textColor = UIColor.setColor(colorType: .lightBlack)
        lblPrice.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblPrice.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        toggle.onTintColor = UIColor.setColor(colorType: .TGBlue)

    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        if sender.isOn {
            
            bgTextView.isHidden = false
        } else {
            bgTextView.isHidden = true
        }
    }
}
