//
//  ManageMyEventCell.swift
//  TicketGateway
//
//  Created by Apple  on 10/05/23.
//

import UIKit

class ManageMyEventCell: UITableViewCell {

    @IBOutlet weak var vwDelete: UIView!
    @IBOutlet weak var vwCopyEvent: UIView!
    @IBOutlet weak var vwViewSee: UIView!
    @IBOutlet weak var vwEdit: UIView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblDelete: UILabel!
    @IBOutlet weak var btnCopy: UIButton!
    @IBOutlet weak var lblCopy: UILabel!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var lblView: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblEdit: UILabel!
    @IBOutlet weak var vwPopUp: customSocialLoginView!
    @IBOutlet weak var collVwPeople: PeopleCollectionList!
    @IBOutlet weak var btnManage: CustomButtonNormalWithBorder!
    @IBOutlet weak var btnMenuMore: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgEvent: UIImageView!
    
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblStartValue: UILabel!
    @IBOutlet weak var lblEndValue: UILabel!
    @IBOutlet weak var lblLastUpdate: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    var progressBarValue: Float = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setUi()
        self.collVwPeople.configure()
        self.collVwPeople.reloadData()
    }
    
    
    func setUi(){
        self.vwPopUp.isHidden = true
        self.btnManage.setTitles(text: "Manage", textColour: UIColor.setColor(colorType: .TGBlack), borderColour: UIColor.setColor(colorType: .TGBlack))
        self.lblEventName.font = UIFont.setFont(fontType: .semiBold, fontSize: .eighteen)
        self.lblEventName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblStatus.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblStatus.textColor = UIColor.setColor(colorType: .TGGrey)
        self.lblEnd.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblEnd.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblEndValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblEndValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblStart.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblStart.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblStartValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblStartValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblLastUpdate.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblLastUpdate.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblRating.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblLastUpdate.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        [self.lblEdit,self.lblView,self.lblDelete,self.lblCopy].forEach {
            $0.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
            $0.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
    }
    
}
