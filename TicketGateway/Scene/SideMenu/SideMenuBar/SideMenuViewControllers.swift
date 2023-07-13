//
//  SideMenuVC.swift
//  TicketGateway
//
//  Created by Apple  on 02/05/23.
//

import UIKit

class SideMenuViewControllers: UIViewController{
    
    //MARK: - IBOutlets
    @IBOutlet weak var btnChangeProfile: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblProfileview : UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tblList: SideMenuList!
   
    //MARK: - Variables
    var menu =  [SideMenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUi()
        self.tblList.configure()
        self.setUpTableView()
     //   self.funcSetProfile()
        self.addTapGesture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - Functions
extension SideMenuViewControllers{
    func setUi(){
        if UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin) {
            lblName.text = "Guest"
            lblProfileview.text = "Login"
            btnChangeProfile.setImage(UIImage(named: "chevron-right_ip"), for: .normal)
           
        } else {
            lblName.text = "fnghgg"
            lblProfileview.text = "Profile View"
        }
        self.lblName.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblProfileview.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblProfileview.textColor = UIColor.setColor(colorType: .Headinglbl)
    }
    
    func addTapGesture(){
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(navigateToProfile(_ :)))
        self.lblProfileview.addGestureRecognizer(gesture)
      }
      @objc func navigateToProfile(_ sender: UITapGestureRecognizer) {
          // handling code
           if let vc = self.createView(storyboard: .profile, storyboardID: .ManageEventProfileVC) as? ManageEventProfileVC{
             vc.isComingFromOranizer = true
             self.navigationController?.pushViewController(vc, animated: false)
           }
         }
    
    func setUpTableView(){
        self.tblList.isFromManageEvent = false
        self.btnChangeProfile.setTitle("CHANGE INTO ORGANISER", for: .normal)
        self.tblList.tableDidSelectAtIndex = { obj in
            if  obj.title == "All Events" {
                objSceneDelegate.showTabBar()
                
            } else if obj.title == "Organizers" {
                let view = self.createView(storyboard: .sidemenu, storyboardID: .Organizers_Artists_ListVC) as! Organizers_Artists_ListVC
                view.isFrom = "Organizers"
                
                self.navigationController?.pushViewController(view, animated: true)
                
            } else if obj.title == "Artists" {
                let view = self.createView(storyboard: .sidemenu, storyboardID: .Organizers_Artists_ListVC) as? Organizers_Artists_ListVC
                view?.isFrom = "Artists"
                self.navigationController?.pushViewController(view!, animated: true)
                
            } else if obj.title == "Venue" {
                let view = self.createView(storyboard: .sidemenu, storyboardID: .VenueVC) as? VenueVC
                self.navigationController?.pushViewController(view!, animated: true)
                
            }
            else if obj.title == "My Wallet" {
                let view = self.createView(storyboard: .wallet, storyboardID: .MyWalletVC) as? MyWalletVC
                self.navigationController?.pushViewController(view!, animated: true)
                
            }
            else if obj.title == "My Refunds" {
                let view = self.createView(storyboard: .sidemenu, storyboardID: .MyRefundVC) as? MyRefundVC
                self.navigationController?.pushViewController(view!, animated: true)
                
            }
            else if obj.title == "Costumes" {
                let view = self.createView(storyboard: .costumes, storyboardID: .CostumeViewController) as? CostumeViewController
                self.navigationController?.pushViewController(view!, animated: true)
                
            }
            else if obj.title == "Manage Events" {
                let view = self.createView(storyboard: .manageevent, storyboardID: .ManageEventVC) as? ManageEventVC
                self.navigationController?.pushViewController(view!, animated: true)
                
            }
            else if obj.title == "Log Out" {
                objSceneDelegate.showLogin_Signup()
                UserDefaultManager.share.clearAllUserDataAndModel()
            }
            
            else if obj.title == "Manage Events" {
                let view = self.createView(storyboard: .manageevent, storyboardID: .ManageEventVC) as? ManageEventVC
                self.navigationController?.pushViewController(view!, animated: true)
                
            }
            else if obj.title == "Scan Events" {
                let view = self.createView(storyboard: .scanevent, storyboardID: .ScanEventVC) as? ScanEventVC
                self.navigationController?.pushViewController(view!, animated: true)
            }
            
            else if obj.title == "Scan Events" {
                // let view = self.createView(storyboard: .scanevent, storyboardID: .ScanEventVC) as? ScanEventVC
                // self.navigationController?.pushViewController(view!, animated: true)
                
            }
            else if obj.title == "Log Out" {
                objSceneDelegate.showLogin_Signup()
                UserDefaultManager.share.clearAllUserDataAndModel()
            }
            else if obj.title == "Notifications" {
                let view = self.createView(storyboard: .sidemenu, storyboardID: .NotificationVC) as? NotificationVC
                self.navigationController?.pushViewController(view!, animated: true)
                
            }
            else if obj.title == "Device Settings" {
                let view = self.createView(storyboard: .sidemenu, storyboardID: .DeviceSettingVC) as? DeviceSettingVC
                self.navigationController?.pushViewController(view!, animated: true)
            }
            else if obj.title == "Rewords & Loyality Points" {
                let view = self.createView(storyboard: .sidemenu, storyboardID: .Reward_LoyaltyPointsVC) as? Reward_LoyaltyPointsVC
                self.navigationController?.pushViewController(view!, animated: true)
            }
            else if obj.title == "My Followers" {
                let view = self.createView(storyboard: .sidemenu, storyboardID: .MyFollowersVC) as? MyFollowersVC
                self.navigationController?.pushViewController(view!, animated: true)
            }
            
            
            else if obj.title == "Orders" {
                let vc = self.createView(storyboard: .order, storyboardID: .MyOrderViewController)
                self.navigationController?.pushViewController(vc, animated: false)
            }
            else if obj.title == "My Favorites" {
                let vc = self.createView(storyboard: .favourites, storyboardID: .FavouriteVC)
                self.navigationController?.pushViewController(vc, animated: false)
            }
            else if obj.title == "FAQs" {
                let vc = self.createView(storyboard: .sidemenu, storyboardID: .FAQVC) as! FAQVC
                self.navigationController?.pushViewController(vc, animated: false)
            }else if obj.title == "Venue" {
                let vc = self.createView(storyboard: .sidemenu, storyboardID: .VenueVC) as! VenueVC
                self.navigationController?.pushViewController(vc, animated: false)
            }else if obj.title == "Feedback"{
                let vc = self.createView(storyboard: .sidemenu, storyboardID: .FeedbackViewController) as! FeedbackViewController
                self.navigationController?.pushViewController(vc, animated: false)
            }
            
        }
        self.tblList.reloadData()
    }
    
    func funcSetProfile(){
        self.lblName.text = objAppShareData.userAuth?.fullName
    }
}

//MARK: - Actions
extension SideMenuViewControllers{
    @IBAction func changeProfile(_ sender: Any) {
       if self.tblList.isFromManageEvent == false
        {
           self.btnChangeProfile.setTitle("CHANGE INTO USER", for: .normal)
           self.tblList.isFromManageEvent = true
           self.tblList.isFromManageEventProfile = false
           self.tblList.configure()
           self.tblList.reloadData()
       } else {
           self.btnChangeProfile.setTitle("CHANGE INTO ORGANISER", for: .normal)
           self.tblList.isFromManageEvent = false
           self.tblList.isFromManageEventProfile = false
           self.tblList.configure()
           self.tblList.reloadData()
       }
    }
}
