//
//  FavouriteTableViewCell.swift
//  TicketGateway
//
//  Created by Dr.Mac on 29/05/23.
//

import UIKit
import SDWebImage

class FavouriteTableViewCell: UITableViewCell {
    
    // MARK: - OUTLETS
    @IBOutlet weak var lblFavoriteDate: UILabel!
    @IBOutlet weak var imgImages: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var numberOfVenueStack: UIStackView!
    @IBOutlet weak var lblNumberOfVenue: UILabel!
    @IBOutlet weak var timeOfVenueStack: UIStackView!
    @IBOutlet weak var timeOfFavoriteEventStack: UIStackView!
    @IBOutlet weak var lblTimeOfVenue: UILabel!
    @IBOutlet weak var lblSeparator: UILabel!
    @IBOutlet weak var likeUnlikeStackViewVenue: UIStackView!
    @IBOutlet weak var likeUnlikeStackViewFavorite: UIStackView!
    @IBOutlet weak var widthLikeUnlikeStackView: NSLayoutConstraint!
    @IBOutlet weak var htLikeUnlikeStackViewFavorite: NSLayoutConstraint!
    @IBOutlet weak var htLblPrice: NSLayoutConstraint!
    
    var likeButtonPressed: (() -> ()) = {}
    var shareButtonPressed: (() -> ()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        
    }
    
    func setDataForFavoritesEvents(getFavouriteData: GetFavouriteItem?) {
        self.setupUI(isFavorites: true)
        
        lblTitle.text = getFavouriteData?.eventTitle ?? "-"
        lblAddress.text = getFavouriteData?.location ?? "-"
        btnLike.setImage(UIImage(named: "favSele_ip"), for: .normal)
//            if let startDate = getFavouriteData?.eventStartDate {
//                self.lblTime.text = "\(getWeekDay(strDate: startDate)), \(startDate.getDateFormattedFrom()) • \(getTime(strDate: startDate))"
//            }
        if let imageUrl = getFavouriteData?.coverImage?.eventCoverImage {
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
    
    func setDataForFavoritesVenue(getVenueData: GetVenueItem?) {
        self.setupUI(isFavorites: false)
        
        lblNumberOfVenue.text = "10+ events"
        lblTitle.text = getVenueData?.venueName ?? "-"
        lblAddress.text = "NA"
        lblDate.text = "NA"
        lblTimeOfVenue.text = "NA"
//            btnLike.setImage(UIImage(named: (getVenueData?.isLiked ?? false) ? "favSele_ip": "favUnSele_ip"), for: .normal)
        if let imageUrl = getVenueData?.image {
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
    
    func setDataForSuggestions(getSuggestionsData: GetEventModel?) {
        self.setupUI(isFavorites: true)
        
        lblTitle.text = getSuggestionsData?.event?.title ?? "-"
        lblAddress.text = getSuggestionsData?.location?.eventAddress ?? "-"
        lblDate.text = "\(getSuggestionsData?.date?.eventStartDate?.getDateFormattedFrom() ?? "")" +  " " + "to" + " " + "\(getSuggestionsData?.date?.eventEndDate?.getDateFormattedFromTo() ?? "")"
        lblTime.text = "\(getSuggestionsData?.date?.eventStartTime?.getFormattedTime() ?? "")" +  " " + "-" + " " + "\(getSuggestionsData?.date?.eventEndTime?.getFormattedTime() ?? "")"
        btnLike.setImage(UIImage(named: (getSuggestionsData?.isLiked ?? false) ? "favSele_ip": "favUnSele_ip"), for: .normal)
        if let imageUrl = getSuggestionsData?.coverImage?.eventCoverImage {
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
    
    func setupUI(isFavorites:Bool) {
        if isFavorites{
            self.numberOfVenueStack.isHidden = true
            self.timeOfVenueStack.isHidden = true
            self.timeOfFavoriteEventStack.isHidden = false
            self.lblSeparator.isHidden = false
            self.lblPrice.isHidden = false
            self.likeUnlikeStackViewVenue.isHidden = true
            self.widthLikeUnlikeStackView.constant = 0
            self.likeUnlikeStackViewFavorite.isHidden = false
            self.htLikeUnlikeStackViewFavorite.constant = 40
            self.htLblPrice.constant = 40
        } else {
            self.numberOfVenueStack.isHidden = false
            self.timeOfVenueStack.isHidden = false
            self.timeOfFavoriteEventStack.isHidden = true
            self.lblSeparator.isHidden = true
            self.lblPrice.isHidden = true
            self.likeUnlikeStackViewVenue.isHidden = false
            self.widthLikeUnlikeStackView.constant = 81
            self.likeUnlikeStackViewFavorite.isHidden = true
            self.htLikeUnlikeStackViewFavorite.constant = 0
            self.htLblPrice.constant = 0
        }
    }
    
    @IBAction private func likeButtonAction(_ sender: UIButton) {
        likeButtonPressed()
    }
    @IBAction private func shareButtonAction(_ sender: UIButton) {
        shareButtonPressed()
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
