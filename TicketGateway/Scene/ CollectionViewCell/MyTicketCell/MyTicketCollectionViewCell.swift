//
//  MyTicketCollectionViewCell.swift
//  TicketGateway
//
//  Created by Apple on 06/09/23.
//

import UIKit
import SDWebImage

class MyTicketCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnSeeFullTicket: CustomButtonNormal!
    @IBOutlet weak var btnSaveTicketAsImage: CustomButtonNormal!
    @IBOutlet weak var vwDashedLine: UIView!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var lblTicket: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setFont()
        self.setProfile()
    }
    
    func setProfile() {
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        self.imgProfile.sd_setImage(with: (APIHandler.shared.baseURL + (userModel?.image ?? "")).getCleanedURL(), placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
        self.imgProfile.cornerRadius = self.imgProfile.frame.width/2
    }
    
    func setData(myTicket:MyTicket?) {
        if let base64String = myTicket?.qrcodeBase64Data{
            self.imgQRCode.image = UIImage.decodeBase64(toImage: base64String)
        }
    }
    
    
    func setFont() {
        self.vwDashedLine.createDottedLine(width: 2, color: UIColor.setColor(colorType: .borderLineColour).cgColor, dashPattern: [6, 6])
        self.btnSeeFullTicket.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSeeFullTicket.titleLabel?.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnSeeFullTicket.addRightIcon(image: UIImage(named: CHEVRON_DOWN))
        self.btnSaveTicketAsImage.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSaveTicketAsImage.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnSaveTicketAsImage.addLeftIcon(image: UIImage(named: DOWNLOAD_ICON_ORDER))
    }
}
