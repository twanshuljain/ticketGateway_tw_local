//
//  OrganizersArtistsListCell.swift
//  TicketGateway
//
//  Created by Apple  on 04/05/23.

import UIKit
import SDWebImage

class OrganizersArtistsListCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnfollow: CustomButtonGradiant!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblName: UILabel!
    var followButtonDidTap: ((_ sender: UIButton) -> Void) = { sender in }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
    }
    var suggestedOrganizerData: GetSuggestedOrganizerItemModel? {
        didSet {
            lblName.text = suggestedOrganizerData?.name ?? "-"
            lblFollowers.text = "\(suggestedOrganizerData?.follower?.first ?? 0) followers"
            btnfollow.setTitle((suggestedOrganizerData?.isFollow ?? false) ? "Following": "Follow", for: .normal)
            if let imageUrl = suggestedOrganizerData?.profileImage {
                if imageUrl.contains(APIHandler.shared.previousBaseURL) {
                    let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    if let url = (APIHandler.shared.baseURL + imageUrl).getCleanedURL() {
                        self.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    } else {
                        self.imgProfile.image = UIImage(named: "homeDas")
                    }
                } else {
                    if let url = (APIHandler.shared.baseURL + imageUrl).getCleanedURL() {
                        self.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                    } else {
                        self.imgProfile.image = UIImage(named: "homeDas")
                    }
                }
            } else {
                self.imgProfile.image = UIImage(named: "homeDas")
            }
        }
    }
    @IBAction private func followButtonAction(_ sender: UIButton) {
        followButtonDidTap(sender)
    }
    func setUi() {
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblFollowers.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblFollowers.textColor = UIColor.setColor(colorType: .headinglbl)
        self.btnfollow.setTitles(text: "Follow", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
    }
}
