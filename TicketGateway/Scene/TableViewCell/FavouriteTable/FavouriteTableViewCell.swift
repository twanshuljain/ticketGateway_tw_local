//
//  FavouriteTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 29/05/23.
//

import UIKit
import SDWebImage

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
    var getFavouriteData: GetFavouriteItem? {
        didSet {
            lblTitle.text = getFavouriteData?.eventTitle ?? "-"
            lblAddress.text = getFavouriteData?.location ?? "-"
//            if let startDate = getFavouriteData?.eventStartDate {
//                self.lblTime.text = "\(getWeekDay(strDate: startDate)), \(startDate.getDateFormattedFrom()) • \(getTime(strDate: startDate))"
//            }
            
            if let imageUrl = getFavouriteData?.coverImage?.eventCoverImage {
                if imageUrl.contains(APIHandler.shared.previousBaseURL) {
                    let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    if let url = URL(string: APIHandler.shared.s3URL + imageUrl) {
                        self.imgImages.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    } else {
                        self.imgImages.image = UIImage(named: "homeDas")
                    }
                } else {
                    if let url = URL(string: APIHandler.shared.s3URL + imageUrl) {
                        self.imgImages.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    } else {
                        self.imgImages.image = UIImage(named: "homeDas")
                    }
                }
            } else {
                self.imgImages.image = UIImage(named: "homeDas")
            }
        }
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
    func getTime(strDate: String) -> String {
        let date = strDate.convertStringToDate(date: strDate)
        return date.getOnlyTimeFromDate(date: date)
    }
    func getWeekDay(strDate: String) -> String {
        let date = strDate.convertStringToDate(date: strDate)
        return date.getWeekDay(date: date) ?? "-"
    }
}
