//
//  Organizers_Artists_ListCell.swift
//  TicketGateway
//
//  Created by Apple  on 04/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import UIKit

class Organizers_Artists_ListCell: UITableViewCell {
    
//MARK: - Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnfollow: CustomButtonGradiant!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblName: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
    }

    
    func setUi(){
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblFollowers.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblFollowers.textColor = UIColor.setColor(colorType: .headinglbl)
        self.btnfollow.setTitles(text: "Follow", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
       
    }
    

}
