//
//  FilterSelectedTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 27/06/23.
//

import UIKit

class FilterSelectedTableViewCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var lblFilter:UILabel!
    @IBOutlet weak var btnSelectedFilter:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUI()
    }

    func setData(str:String, selectedIndex:Int, index:Int) {
        self.selectionStyle = .none
        self.lblFilter.text = str
       if selectedIndex==index{
           self.btnSelectedFilter.setImage(UIImage.init(named: RADIO_SELECTION_ICON), for: .normal)
       } else {
           self.btnSelectedFilter.setImage(UIImage.init(named: FILTER_RADIO_INACTIVE), for: .normal)
        }
    }

    func setUI() {
        self.btnSelectedFilter.titleLabel?.text = ""
        self.btnSelectedFilter.setTitle("", for: .normal)
        self.lblFilter.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFilter.textColor = UIColor.setColor(colorType: .tgBlack)
        self.btnSelectedFilter.setImage(UIImage.init(named: FILTER_RADIO_INACTIVE), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
