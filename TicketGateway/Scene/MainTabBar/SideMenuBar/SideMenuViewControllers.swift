//
//  SideMenuVC.swift
//  TicketGateway
//
//  Created by Apple  on 02/05/23.
//

import UIKit



class SideMenuViewControllers: UIViewController{
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblProfileview : UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tblList: SideMenuList!
   

    var menu =  [SideMenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUi()
        self.tblList.configure()
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
            
            
        }
        self.tblList.reloadData()
        self.funcSetProfile()
      
    }
    
    func setUi(){
        self.lblName.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblProfileview.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblProfileview.textColor = UIColor.setColor(colorType: .Headinglbl)
    }
    
    func funcSetProfile(){
        self.lblName.text = objAppShareData.userAuth?.fullName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


