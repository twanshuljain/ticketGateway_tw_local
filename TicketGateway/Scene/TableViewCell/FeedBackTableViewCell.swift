//
//  FeedBackTableViewCell.swift
//  TicketGateway
//
//  Created by Apple on 30/06/23.
//

import UIKit

class FeedBackTableViewCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var lblFeedback:UILabel!
    @IBOutlet weak var btnThumbsUp:UIButton!
    @IBOutlet weak var btnThumbsDown:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setFont()
    }
    
    func setData(feedback:String?, index:Int) {
        if index == 0{
            self.btnThumbsUp.setImage(UIImage.init(named: THUMBSUP_SELECTED_ICON), for: .normal)
            self.btnThumbsDown.setImage(UIImage.init(named: THUMBSDOWN_UNSELECTED_ICON), for: .normal)
        } else {
            self.btnThumbsUp.setImage(UIImage.init(named: THUMBSUP_UNSELECTED_ICON), for: .normal)
            self.btnThumbsDown.setImage(UIImage.init(named: THUMBSDOWN_UNSELECTED_ICON), for: .normal)
        }
        self.lblFeedback.text = feedback ?? ""
    }
    
    func setFont() {
        lblFeedback.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblFeedback.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
 
}
