//
//  FavouriteTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 29/05/23.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    
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
        self.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
         self.lblAddress.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblAddress.textColor = UIColor.setColor(colorType: .Headinglbl)
        
        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDate.textColor = UIColor.setColor(colorType: .Headinglbl)
        self.lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTime.textColor = UIColor.setColor(colorType: .Headinglbl)
        self.lblPrice.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblPrice.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblFavoriteDate.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblFavoriteDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
    
    
   
    
    
    

}
