//
//  ManageEventProfile.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.
//

import UIKit

class ManageEventMoreVC: UIViewController {
    
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblProfileview : UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tblList: SideMenuList!
    
    var menu =  [SideMenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUi()
        self.tblList.isFromManageEventProfile = true
        self.tblList.configure()
        self.tblList.tableDidSelectAtIndex = { obj in
            if  obj.title == "All Events" {
                objSceneDelegate.showTabBar()
            } else if obj.title == "Organizers" {
                let view = self.createView(storyboard: .sidemenu, storyboardID: .Organizers_Artists_ListVC) as! Organizers_Artists_ListVC
                view.isFrom = "Organizers"
                self.navigationController?.pushViewController(view, animated: true)
            }
        }
        self.lblName.text = objAppShareData.userAuth?.fullName
        self.tblList.reloadData()
    }
    
    func setUi(){
        self.lblName.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblProfileview.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblProfileview.textColor = UIColor.setColor(colorType: .Headinglbl)
        self.navigationView.btnBack.isHidden = true
        self.navigationView.imgBack.isHidden = true
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = "Sunburn reload NYE - toronto"
        self.navigationView.lblDiscripation.text = "Wed, Dec 7, 2023  at 05:00 PM"
        self.navigationView.vwBorder.isHidden = false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnArrow(_ sender: Any) {
        let view = self.createView(storyboard: .profile, storyboardID: .ManageEventProfileVC) as? ManageEventProfileVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
}


extension ManageEventMoreVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
