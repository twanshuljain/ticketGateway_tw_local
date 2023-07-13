//
//  EventTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 26/04/23.
//

import UIKit
import SDWebImage

class EventTableViewCell: UITableViewCell {
   
    @IBOutlet weak var imgImages: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    var getEvent:GetEventModel?{
        didSet{
            self.lblTitle.text = getEvent?.event?.title ?? ""
            self.lblAddress.text = getEvent?.location?.eventAddress ?? ""
            self.lblDate.text = "\(getEvent?.date?.eventStartDate?.getDateFormattedFrom() ?? "")" +  " " + "to" + " " + "\(getEvent?.date?.eventEndDate?.getDateFormattedFromTo() ?? "")"
            self.lblTime.text = "\(getEvent?.date?.eventStartTime?.getFormattedTime() ?? "")" +  " " + "-" + " " + "\(getEvent?.date?.eventEndTime?.getFormattedTime() ?? "")"
            if let imageUrl = getEvent?.coverImage?.eventCoverImage{
                if imageUrl.contains(APIHandler.shared.baseURL){
                    let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.baseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    if let url = URL(string: APIHandler.shared.baseURL + imageUrl){
                        self.imgImages.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    }else{
                        self.imgImages.image = UIImage(named: "homeDas")
                    }
                }else{
                    if let url = URL(string: APIHandler.shared.baseURL + imageUrl){
                        self.imgImages.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    }else{
                        self.imgImages.image = UIImage(named: "homeDas")
                    }
                }
  
            } else {
                self.imgImages.image = UIImage(named: "homeDas")
            }
        }
    }
    
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
        
        
    }
    
    func cellConfiguration() {
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
    
    
   
    
    
    

}
