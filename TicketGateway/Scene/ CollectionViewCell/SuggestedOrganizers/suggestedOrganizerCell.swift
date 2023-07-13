//
//  suggestedOrganizerCell.swift
//  TicketGateway
//
//  Created by Apple  on 28/04/23.
//

import UIKit
import SDWebImage

class suggestedOrganizerCell: UICollectionViewCell {
    
    @IBOutlet weak var vwImgProfile: UIView!
    @IBOutlet weak var btnFollerwers: CustomButtonGradiant!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        // Initialization code
    }
    
    func setData(organizerDetail:Organizers){
        self.lblName.text = organizerDetail.name ?? ""
        self.lblFollowers.text = "\(organizerDetail.followers ?? 0) followers "
        
        if let imageUrl = organizerDetail.profileImage{
            if imageUrl.contains(APIHandler.shared.baseURL){
                let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.baseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if let url = URL(string: APIHandler.shared.baseURL + imageUrl){
                    self.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                }else{
                    self.imgProfile.image = UIImage(named: "homeDas")
                }
            }else{
                if let url = URL(string: APIHandler.shared.baseURL + imageUrl){
                    self.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                }else{
                    self.imgProfile.image = UIImage(named: "homeDas")
                }
            }
            
        } else {
            self.imgProfile.image = UIImage(named: "homeDas")
        }
    }
    
    func setUi(){
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblFollowers.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblFollowers.textColor = UIColor.setColor(colorType: .Headinglbl)
        self.btnFollerwers.setTitles(text: "Following", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
       
    }
    
    

}
