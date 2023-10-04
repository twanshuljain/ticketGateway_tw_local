//
//  ManageEventProfileVC.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.
// swiftlint: disable line_length

import UIKit
import SDWebImage

class ManageEventProfileVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblCompleteProfile: UILabel!
    @IBOutlet weak var lblYourCompleteProfile: UILabel!
    @IBOutlet weak var lblAboutSince: UILabel!
    @IBOutlet weak var lblAboutSinceDate: UILabel!
    @IBOutlet weak var btnEditProfile: CustomButtonNormal!
    @IBOutlet weak var lblProfileType: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnSelectProfile: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var viewTotalProgress: FBProgressView!

    // MARK: - Varibale
    var isComingFromOranizer = false
    var isForSideMenuOrSetting = false
    var name: String = ""
    var imageUrl: String?
    var viewModel: ManageEventProfileViewModel = ManageEventProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        if !isComingFromOranizer {
            getUserProfileData()
        }
    }
}
// MARK: - Functions
extension ManageEventProfileVC {
    private func setUp() {
        self.viewTotalProgress.setProgress(16)
        if isComingFromOranizer {
            self.navigationView.btnBack.isHidden = false
            self.navigationView.imgBack.isHidden = false
            self.lblName.text = name
            self.btnEditProfile.isHidden = true
            self.btnSelectProfile.isHidden = true
            self.lblCompleteProfile.isHidden = true
            self.lblYourCompleteProfile.isHidden = true
            self.viewTotalProgress.isHidden = true
            self.lblAboutSince.isHidden = true
            self.lblAboutSinceDate.isHidden = true
            self.imgProfile.sd_setImage(with: (APIHandler.shared.baseURL + (imageUrl ?? "")).getCleanedURL(), placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)

        } else {
            if isForSideMenuOrSetting {
                self.navigationView.btnBack.isHidden = false
                self.navigationView.imgBack.isHidden = false
                self.lblName.text = name
                self.imgProfile.sd_setImage(with: (APIHandler.shared.baseURL + (imageUrl ?? "")).getCleanedURL(), placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
            } else {
                self.navigationView.btnBack.isHidden = true
                self.navigationView.imgBack.isHidden = true
            }
           // self.navigationView.btnBack.isHidden = true
          //  self.navigationView.imgBack.isHidden = true
//            self.lblName.text = objAppShareData.userAuth?.fullName
            self.lblEmail.text = objAppShareData.userAuth?.email
            self.btnEditProfile.isHidden = false
            self.btnSelectProfile.isHidden = false
            self.lblCompleteProfile.isHidden = false
            self.lblYourCompleteProfile.isHidden = false
            self.viewTotalProgress.isHidden = false
            self.lblAboutSince.isHidden = false
            self.lblAboutSinceDate.isHidden = false
        }
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = PROFILE
        self.navigationView.vwBorder.isHidden = false
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .twentyFive)
        self.lblName.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblEmail.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblEmail.textColor = UIColor.setColor(colorType: .lightGrey)
        self.lblAddress.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAddress.textColor = UIColor.setColor(colorType: .extraLightBlack)
        self.lblProfileType.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblProfileType.textColor = UIColor.setColor(colorType: .lightGrey)
        self.lblCompleteProfile.font = UIFont.setFont(fontType: .medium, fontSize: .fifteen)
        self.lblYourCompleteProfile.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblYourCompleteProfile.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblAboutSince.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
        self.lblAboutSince.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblAboutSinceDate.font = UIFont.setFont(fontType: .medium, fontSize: .fifteen)
        self.lblAboutSinceDate.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.btnEditProfile.setTitles(text: EDIT_PROFILE, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .lightBlack), textColour: UIColor.setColor(colorType: .lightBlack))
        self.btnEditProfile.addLeftIcon(image: UIImage(named: EDIT_2_ICON))
        [self.btnEditProfile, self.btnSelectProfile].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
    }
    func funcSetProfile() {
        let userData = viewModel.getUserProfileData.userData
        self.lblName.text = userData?.fullName ?? "-"
        self.lblEmail.text = userData?.email ?? "-"
        self.imageUrl = userData?.image ?? "-"
        self.lblAddress.text = userData?.country ?? "NA"
        self.lblProfileType.text = userData?.role ?? "PROMOTER"
        self.lblAboutSinceDate.text = "\(getTime(strDate: userData?.createdAt ?? ""))"
        self.lblYourCompleteProfile.text = "Your profile is \(viewModel.getUserProfileData.profileCompletePercentage ?? 1)% complete."
        self.imgProfile.sd_setImage(with: (APIHandler.shared.baseURL + (imageUrl ?? "")).getCleanedURL(), placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.highPriority)
        self.viewTotalProgress.setProgress(viewModel.getUserProfileData.profileCompletePercentage ?? 1)
    }
    @objc func getTime(strDate: String) -> String {
        let date = strDate.convertStringToDateForProfile(date: strDate)
        let time = date.getOnlyTimeFromDateForProfile(date: date)
        var dateAndTime: String = ""
        dateAndTime = "\(strDate.changeDateFormate()) | \(time)"
        return dateAndTime
    }
    // Get User Profile API Calling
    func getUserProfileData() {
        if Reachability.isConnectedToNetwork() {
            self.view.showLoading(centreToView: self.view)
            self.viewModel.getUserProfileData(complition: { isTrue, message in
                if isTrue {
                    self.view.stopLoading()
                    self.funcSetProfile()
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: message)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    func updateUserProfileData() {
        if Reachability.isConnectedToNetwork() {
            self.view.showLoading(centreToView: self.view)
            self.viewModel.updateUserProfileData(complition: { isTrue, message in
                if isTrue {
                    self.view.stopLoading()
                    self.getUserProfileData()
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: message)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
}

// MARK: - Actions
extension ManageEventProfileVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnEditProfile:
            self.btnEditAction()
        case btnSelectProfile:
            self.btnSelectAction()
        default:
            break
        }
    }
    func btnEditAction() {
        let view = self.createView(storyboard: .profile, storyboardID: .ManageEventEditProfileVC) as? ManageEventEditProfileVC
        view?.name = viewModel.getUserProfileData.userData?.fullName ?? "-"
        view?.number = viewModel.getUserProfileData.userData?.cellPhone ?? "-"
        view?.email = viewModel.getUserProfileData.userData?.email ?? "-"
        self.navigationController?.pushViewController(view!, animated: true)
    }
    func btnSelectAction() {
        ImagePickerManager().pickImage(self) {image in
            self.viewModel.updateUserModel.image = image
            self.updateUserProfileData()
//            let zoomParcelVc = self.createView(storyboard: .profile, storyboardID: .ZoomViewController) as? ZoomViewController
//            zoomParcelVc?.imgProfile = image
//            if let zoomParcelVc = zoomParcelVc {
//                self.navigationController?.pushViewController(zoomParcelVc, animated: true)
//            }
            // self.imgProfile.image = image
        }
    }
}
// MARK: - NavigationBarViewDelegate
extension ManageEventProfileVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
