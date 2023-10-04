//
//  UpcomingTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 15/05/23.
//

import UIKit
import SDWebImage

class UpcomingTableViewCell: UITableViewCell {
    
    // MARK: - OUTLETS
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnSeeTickets: UIButton!
    @IBOutlet weak var blackWhiteView: UIView!
    @IBOutlet weak var blackWhiteImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFonts()
        self.btnSeeTickets.isUserInteractionEnabled = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setData(getTicket: GetMyOrderItem?, isFaded:Bool) {
        self.lblTitle.text = getTicket?.eventTitle ?? ""
        if let startDate = getTicket?.eventStartDate {
            self.lblTime.text = "\(getWeekDay(strDate: startDate)), \(startDate.getDateFormattedFrom()) • \(getTime(strDate: startDate))"
        }
        
        if isFaded{
            self.btnSeeTickets.setTitle("Completed", for: .normal)
        }else {
            self.btnSeeTickets.setTitle("See Tickets", for: .normal)
        }
        
        if let imageUrl = getTicket?.coverImage?.eventCoverImage {
            if imageUrl.contains(APIHandler.shared.previousBaseURL) {
                let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
                    self.imgImage.sd_setImage(with: url) { image, error, cacheType, url in
                        if error == nil{
                            self.imgImage.image = image
                        } else {
                            self.imgImage.image = UIImage(named: "homeDas")
                        }
                        self.imgImage.image = isFaded ? self.imgImage.image?.convertToGrayscale(): self.imgImage.image
                    }
                    //self.imgImage.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    //imgImage.image = isFaded ? imgImage.image?.convertToGrayscale(): imgImage.image
                } else {
                    self.imgImage.image = UIImage(named: "homeDas")
                    imgImage.image = isFaded ? imgImage.image?.convertToGrayscale(): imgImage.image
                }
            } else {
                if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
                    self.imgImage.sd_setImage(with: url) { image, error, cacheType, url in
                        if error == nil{
                            self.imgImage.image = image
                        } else {
                            self.imgImage.image = UIImage(named: "homeDas")
                        }
                        self.imgImage.image = isFaded ? self.imgImage.image?.convertToGrayscale(): self.imgImage.image
                    }
                    
//                    self.imgImage.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
//                    imgImage.image = isFaded ? imgImage.image?.convertToGrayscale(): imgImage.image
                } else {
                    self.imgImage.image = UIImage(named: "homeDas")
                    imgImage.image = isFaded ? imgImage.image?.convertToGrayscale(): imgImage.image
                }
            }
        } else {
            self.imgImage.image = UIImage(named: "homeDas")
            imgImage.image = isFaded ? imgImage.image?.convertToGrayscale(): imgImage.image
        }
    }

    func setFonts() {
        self.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        
        self.lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTime.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.btnSeeTickets.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSeeTickets.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
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
