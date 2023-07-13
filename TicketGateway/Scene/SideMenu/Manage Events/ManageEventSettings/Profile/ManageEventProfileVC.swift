//
//  ManageEventProfileVC.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.
//

import UIKit

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
    
    var isComingFromOranizer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
}

// MARK: - Functions
extension ManageEventProfileVC {
    private func setUp()
    {
        self.viewTotalProgress.setProgress(16)
        if isComingFromOranizer{
            self.navigationView.btnBack.isHidden = false
            self.navigationView.imgBack.isHidden = false
        }else{
            self.navigationView.btnBack.isHidden = true
            self.navigationView.imgBack.isHidden = true
        }
        
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = PROFILE
        self.navigationView.vwBorder.isHidden = false
        
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .twentyFive)
        self.lblName.textColor = UIColor.setColor(colorType: .TGBlack)
       
        self.lblEmail.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblEmail.textColor = UIColor.setColor(colorType: .lightGrey)
       
        self.lblAddress.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAddress.textColor = UIColor.setColor(colorType: .ExtraLightBlack)
      
        self.lblProfileType.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblProfileType.textColor = UIColor.setColor(colorType: .lightGrey)
       
        self.lblCompleteProfile.font = UIFont.setFont(fontType: .medium, fontSize: .fifteen)
       
        self.lblYourCompleteProfile.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblYourCompleteProfile.textColor = UIColor.setColor(colorType: .lblTextPara)
       
        self.lblAboutSince.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
        self.lblAboutSince.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblAboutSinceDate.font = UIFont.setFont(fontType: .medium, fontSize: .fifteen)
        self.lblAboutSinceDate.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
       
        self.btnEditProfile.setTitles(text: EDIT_PROFILE, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .lightBlack), textColour: UIColor.setColor(colorType: .lightBlack))
        self.btnEditProfile.addLeftIcon(image: UIImage(named: EDIT_2_ICON))
        [self.btnEditProfile,self.btnSelectProfile].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
      //  self.funcSetProfile()
    }
    
    func funcSetProfile(){
        self.lblName.text = objAppShareData.userAuth?.fullName
        self.lblEmail.text = objAppShareData.userAuth?.email
        self.lblAddress.text = objAppShareData.userAuth?.accessToken
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
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
    func btnSelectAction() {
        ImagePickerManager().pickImage(self){ image in
          let zoomParcelVc = self.createView(storyboard: .profile, storyboardID: .ZoomViewController) as? ZoomViewController
          zoomParcelVc?.imgProfile = image
          if let zoomParcelVc = zoomParcelVc {
            self.navigationController?.pushViewController(zoomParcelVc, animated: true)
          }
          // self.imgProfile.image = image
          }
      }
}

// MARK: - NavigationBarViewDelegate
extension ManageEventProfileVC : NavigationBarViewDelegate {
    func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}
