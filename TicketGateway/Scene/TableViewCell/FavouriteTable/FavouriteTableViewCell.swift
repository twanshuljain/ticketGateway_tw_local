//
//  FavouriteTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 29/05/23.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblFavoriteDate: UILabel!
    @IBOutlet weak var imgImages: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        
    }
    
    func setUi(){
        self.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        self.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblAddress.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblAddress.textColor = UIColor.setColor(colorType: .headinglbl)
        
        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDate.textColor = UIColor.setColor(colorType: .headinglbl)
        self.lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTime.textColor = UIColor.setColor(colorType: .headinglbl)
        self.lblPrice.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblPrice.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        
        self.lblFavoriteDate.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblFavoriteDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        
    }
   
}
