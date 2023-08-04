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
    
    func setData(index:Int, eventDetail: EventDetail?){
        if let images = eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages,
            !images.isEmpty {
             let imageUrl = images[index]
                if imageUrl.contains(APIHandler.shared.baseURL) {
                    let imagekUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.baseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    if let url = URL(string: APIHandler.shared.baseURL + imageUrl) {
                        self.imgEvents.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    } else {
                        self.imgEvents.image = UIImage(named: "homeDas")
                    }
                } else {
                    if let url = URL(string: APIHandler.shared.baseURL + imageUrl) {
                        self.imgEvents.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    } else {
                        self.imgEvents.image = UIImage(named: "homeDas")
                    }
                }
        } else {
            if let imageUrl = eventDetail?.eventCoverImageObj?.eventCoverImage, let url = URL(string: APIHandler.shared.baseURL + imageUrl) {
                self.imgEvents.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
            } else {
                self.imgEvents.image = UIImage(named: "homeDas")
            }
        }
        
    }
}
