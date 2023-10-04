//
//  EventTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 26/04/23.
//

import UIKit
import SDWebImage

class EventTableViewCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var imgImages: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var viewNoData : UIView!
    @IBOutlet weak var lblNoData : UILabel!
    @IBOutlet weak var imgTime : UIImageView!
    @IBOutlet weak var lblSeperator : UILabel!

    var getEvent:GetEventModel?{
        didSet{
            self.lblSeperator.isHidden = false
            self.imgTime.isHidden = false
            self.viewNoData.isHidden = true
            if getEvent?.likeCountData?.isLiked != nil{
                btnLike.isSelected = getEvent?.likeCountData?.isLiked ?? false
            } else {
                btnLike.isSelected = getEvent?.isLiked ?? false
            }
            self.lblTitle.text = getEvent?.event?.title ?? ""
            self.lblPrice.text = "$ \(getEvent?.ticketOnwards ?? 0) onwards"
            self.lblAddress.text = getEvent?.locationType == VIRTUAL ? VirtualEvent : getEvent?.locationType == MULTIPLE ? MultipleLocation : (getEvent?.location?.eventAddress ?? "-")
            //            self.lblAddress.text = getEvent?.location?.eventAddress ?? "-"

            if getEvent?.locationType == MULTIPLE{
                self.imgTime.isHidden = true
                self.lblSeperator.isHidden = true
                self.lblDate.text = " \(RecurringDates)"
                self.lblTime.text = ""
            } else {
                self.lblDate.text = "  " + "\(getEvent?.date?.eventStartDate?.getDateFormattedFrom() ?? "")" +  " " + "to" + " " + "\(getEvent?.date?.eventEndDate?.getDateFormattedFromTo() ?? "")"
                self.lblTime.text = "  " + "\(getEvent?.date?.eventStartTime?.getFormattedTime() ?? "")" +  " " + "-" + " " + "\(getEvent?.date?.eventEndTime?.getFormattedTime() ?? "")"
            }

            if let imageUrl = getEvent?.coverImage?.eventCoverImage{
                if imageUrl.contains(APIHandler.shared.previousBaseURL) {
                    let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
                        self.imgImages.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    } else {
                        self.imgImages.image = UIImage(named: "homeDas")
                    }
                } else {
                    if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
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

    func setNoDataFound(countryName:String) {
        self.viewNoData.isHidden = false
        lblNoData.text = "No Events Found near \(countryName)"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()

    }

    func setUi() {
        self.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        self.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblAddress.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblAddress.textColor = UIColor.setColor(colorType: .headinglbl)

        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblDate.textColor = UIColor.setColor(colorType: .headinglbl)
        self.lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTime.textColor = UIColor.setColor(colorType: .headinglbl)
        self.lblPrice.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblPrice.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)

    }

    func cellConfiguration() {

    }
//    func getLocation(address) -> String {
//
//    }
}
