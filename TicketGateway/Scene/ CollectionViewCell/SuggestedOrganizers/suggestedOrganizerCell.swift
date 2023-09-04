//
//  suggestedOrganizerCell.swift
//  TicketGateway
//
//  Created by Apple  on 28/04/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import UIKit
import SDWebImage

protocol SuggestedOrganizerCellProtocol:class {
    func followUnfollowAction(tag:Int)
}

class suggestedOrganizerCell: UICollectionViewCell {
    
//MARK: - Outlets
    @IBOutlet weak var vwImgProfile: UIView!
    @IBOutlet weak var btnFollerwers: CustomButtonGradiant!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblName: UILabel!
    var isFromOrganizationSection: Bool = false
    weak var delegate:SuggestedOrganizerCellProtocol?
    var followButtonDidTap: ((_ sender: UIButton) -> Void) = {sender in }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUi()
        // Initialization code
    }
    
    func setData(organizerDetail: Organizers){
        self.lblName.text = organizerDetail.name ?? ""
        self.lblFollowers.text = "\(organizerDetail.followers ?? 0) followers "
        if organizerDetail.isFollow == true {
            self.btnFollerwers.setTitle("Following", for: .normal)
        } else {
            self.btnFollerwers.setTitle("Follow", for: .normal)
        }
        
        if let imageUrl = organizerDetail.profileImage{
            if imageUrl.contains(APIHandler.shared.previousBaseURL){
                let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if let url = (APIHandler.shared.baseURL + imageUrl).getCleanedURL() {
                    self.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                }else{
                    self.imgProfile.image = UIImage(named: "homeDas")
                }
            }else{
                if let url = (APIHandler.shared.baseURL + imageUrl).getCleanedURL() {
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
        self.lblName.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblFollowers.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblFollowers.textColor = UIColor.setColor(colorType: .headinglbl)
        self.btnFollerwers.setTitles(text: "Following", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
       
    }
    
    @IBAction func btnFollowUnfollowAction(_ sender:UIButton){
        if isFromOrganizationSection {
            followButtonDidTap(sender)
        }
        self.delegate?.followUnfollowAction(tag: sender.tag)
    }

}
