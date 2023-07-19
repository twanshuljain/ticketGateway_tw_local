//
//  ContactDetailsTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 29/06/23.
//

import UIKit

class ContactDetailsTableViewCell: UITableViewCell {
   
    //MARK: - OUTLETS
    @IBOutlet weak var lblLocation:UILabel!
    @IBOutlet weak var lblContact:UILabel!
    @IBOutlet weak var lblLink:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpUI()
    }
    
    func setUpUI() {
       self.lblLocation.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
       self.lblLocation.textColor = UIColor.setColor(colorType: .btnDarkBlue)
       
       self.lblContact.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
       self.lblContact.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
        self.lblLink.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblLink.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
       self.backgroundColor = UIColor.setColor(colorType: .bgPurpleColor)
   }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
