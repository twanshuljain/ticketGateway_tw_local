//
//  RSCountryTableViewCell.swift
//  TicketGateway
//
//  Created by Apple  on 18/04/23.
//
import UIKit
class RSCountryTableViewCell: UITableViewCell {
    @IBOutlet var imgCountryFlag: UIImageView!
    @IBOutlet var lblCountryName: UILabel!
    @IBOutlet var lblCountryDialCode: UILabel!
    @IBOutlet var imgRadioCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       //imgCountryFlag.setImageCircle()
        imgCountryFlag.layer.cornerRadius = 6.0
        imgCountryFlag.layer.masksToBounds = true
    }
   override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
