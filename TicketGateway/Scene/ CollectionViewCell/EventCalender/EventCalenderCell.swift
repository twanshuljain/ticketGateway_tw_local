//
//  EventCalenderCell.swift
//  TicketGateway
//
//  Created by Apple  on 05/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit

class EventCalenderCell: UICollectionViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth_Year: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        // Initialization code
    }

    func setUi() {
        self.lblDate.font = UIFont.setFont(fontType: .medium, fontSize: .twenty)
        self.lblDate.textColor = UIColor.setColor(colorType: .tgBlack)
      
        self.lblDay.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDay.textColor = UIColor.setColor(colorType: .headinglbl)
    }
    
}
