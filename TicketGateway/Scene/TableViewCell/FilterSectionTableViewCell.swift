//
//  FilterSectionTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 27/06/23.
//

import UIKit

class FilterSectionTableViewCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var lblFilterTitle:UILabel!
    @IBOutlet weak var filterView:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUI()
    }

    func setData(str: String, selectedIndex: Int, index: Int) {
        self.selectionStyle = .none
        self.lblFilterTitle.text = str
       if selectedIndex==index{
            self.lblFilterTitle.textColor = UIColor.setColor(colorType: .white)
            self.filterView.backgroundColor = UIColor.setColor(colorType: .tgBlue)
       } else {
            self.lblFilterTitle.textColor = UIColor.setColor(colorType: .tgBlack)
            self.filterView.backgroundColor = UIColor.setColor(colorType: .white)
        }
    }

    func setUI() {
        self.lblFilterTitle.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFilterTitle.textColor = UIColor.setColor(colorType: .tgBlack)
        self.filterView.backgroundColor = UIColor.setColor(colorType: .white)
    }

}
