//
//  EventImageCell.swift
//  TicketGateway
//
//  Created by Apple  on 01/06/23.
//

import UIKit
import SDWebImage

class EventImageCell: UICollectionViewCell {
 
    @IBOutlet weak var imgEvents: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(index:Int, eventDetail:EventDetail?) {
        var images:[String]?
        if eventDetail?.eventCoverImageObj?.eventCoverImage != nil || eventDetail?.eventCoverImageObj?.eventCoverImage != ""{
            images = [eventDetail?.eventCoverImageObj?.eventCoverImage ?? ""]
            if let additionalImages = eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages{
                images?.append(contentsOf: additionalImages)
            }
        } else {
            images = eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages
        }
        if images?.indices.contains(index) ?? false{
            if let imageUrl = images?[index]{
                if let imageUrl = images?[index]{
                    if imageUrl.contains(APIHandler.shared.previousBaseURL) {
                        let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                        if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
                            self.imgEvents.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                        } else {
                            self.imgEvents.image = UIImage(named: "homeDas")
                        }
                    } else {
                        if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
                            self.imgEvents.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                        } else {
                            self.imgEvents.image = UIImage(named: "homeDas")
                        }
                    }
                } else {
                    self.imgEvents.image = UIImage(named: "homeDas")
                }
            } else {
                if let imageUrl = eventDetail?.eventCoverImageObj?.eventCoverImage, let url = (APIHandler.shared.baseURL + imageUrl).getCleanedURL() {
                    self.imgEvents.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                } else {
                    self.imgEvents.image = UIImage(named: "homeDas")
                }
            }
       } else {
           if let imageUrl = eventDetail?.eventCoverImageObj?.eventCoverImage{
               if imageUrl.contains(APIHandler.shared.previousBaseURL) {
                   let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                   if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
                       self.imgEvents.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                   } else {
                       self.imgEvents.image = UIImage(named: "homeDas")
                   }
               } else {
                   if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
                       self.imgEvents.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                   } else {
                       self.imgEvents.image = UIImage(named: "homeDas")
                   }
               }
 
           } else {
               self.imgEvents.image = UIImage(named: "homeDas")
           }
       }
    }
}
