//
//  ManageEventProfileVC.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.
//

import UIKit

class ManageEventProfileVC: UIViewController {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view.
    }
    
 private func setUp()
    {
        self.viewTotalProgress.setProgress(16)
        self.navigationView.btnBack.isHidden = false
        self.navigationView.imgBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = "Profile"
        self.navigationView.vwBorder.isHidden = false
        self.lblName.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFive)
        self.lblName.textColor = UIColor.setColor(colorType: .lightBlack)
        self.lblEmail.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblEmail.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblAddress.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAddress.textColor = UIColor.setColor(colorType: .ExtraLightBlack)
        self.lblProfileType.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblProfileType.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblCompleteProfile.font = UIFont.setFont(fontType: .medium, fontSize: .fifteen)
        self.lblCompleteProfile.textColor = UIColor.setColor(colorType: .lightBlack)
        self.lblYourCompleteProfile.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblYourCompleteProfile.textColor = UIColor.setColor(colorType: .ExtraLightBlack)
        self.lblAboutSince.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
        self.lblAboutSince.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblAboutSinceDate.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblAboutSinceDate.textColor = UIColor.setColor(colorType: .lightBlack)
        self.btnEditProfile.setTitles(text: "Edit profile", font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .lightBlack), textColour: UIColor.setColor(colorType: .lightBlack))
        self.btnEditProfile.addLeftIcon(image: UIImage(named: "edit-2"))
        [self.btnEditProfile,self.btnSelectProfile].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.funcSetProfile()
    }
    
    func funcSetProfile(){
        self.lblName.text = objAppShareData.userAuth?.fullName
        self.lblEmail.text = objAppShareData.userAuth?.email
        self.lblAddress.text = objAppShareData.userAuth?.accessToken
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
            self.imgProfile.image = image
            }
    }
}

extension ManageEventProfileVC : NavigationBarViewDelegate {
    func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}
