//
// ManageEventSettingVC.swift
// TicketGateway
//
// Created by Apple on 24/05/23.

import UIKit

class ManageEventSettingVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblProfileview: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var navitem: UITabBarItem!

    // MARK: - Variables
    let viewModel = ManageEventSettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBar()
        self.setTableView()
        self.setUi()
    }
}
// MARK: - Functions
extension ManageEventSettingVC {
    func setTabBar() {
        if let iscomingfrom = UserDefaults.standard.value(forKey: "isComingFromManageEvent") as? Bool{
            if iscomingfrom{
                self.setUi()
                self.setTableView()
                self.navitem.title = "settings"
                self.navitem.image = UIImage.init(named: "settings")
            } else {
                self.navitem.title = "Profile"
                let vc = self.createView(storyboard: .profile, storyboardID: .ManageEventProfileVC) as! ManageEventProfileVC
                vc.isComingFromOranizer = false
                self.navigationController?.viewControllers = [vc]
                self.navigationController?.pushViewController(vc, animated: false)
            }
        } else {
        }
    }
    func setTableView() {
        tblList.delegate = self
        tblList.dataSource = self
        tblList.register(UINib(nibName: "ManageEventSettingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ManageEventSettingTableViewCell")
    }
    func setUi() {
        self.lblName.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblName.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblProfileview.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblProfileview.textColor = UIColor.setColor(colorType: .headinglbl)
        self.navigationView.btnBack.isHidden = true
        self.navigationView.imgBack.isHidden = true
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = HEADER_TITLE_SUNBURN
        self.navigationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
        self.navigationView.vwBorder.isHidden = false
        //    self.tblList.isFromManageEvent = true
        //    self.tblList.isFromManageEventProfile = true
        //    self.tblList.configure()
        //    self.tblList.tableDidSelectAtIndex = { obj in
        //      if obj.title == "All Events" {
        //        objSceneDelegate.showTabBar()
        //      } else if obj.title == "Organizers" {
        //        let view = self.createView(storyboard: .sidemenu, storyboardID: .OrganizersArtistsListVC) as! OrganizersArtistsListVC
        //        view.isFrom = "Organizers"
        //        self.navigationController?.pushViewController(view, animated: true)
        //      }
        //    }
        //    // self.lblName.text = objAppShareData.userAuth?.fullName
        //    self.tblList.reloadData()
    }
}
// MARK: - Actions
extension ManageEventSettingVC {
    @IBAction private func btnArrow(_ sender: Any) {
        let view = self.createView(storyboard: .profile, storyboardID: .ManageEventProfileVC) as! ManageEventProfileVC
        view.isComingFromOranizer = false
        view.isForSideMenuOrSetting = true
        self.navigationController?.pushViewController(view, animated: true)
    }
}
// MARK: - UITabBarDelegate, UITableViewDataSource
extension ManageEventSettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageEventSettingTableViewCell", for: indexPath) as! ManageEventSettingTableViewCell
        let data = viewModel.arrData[indexPath.row]
        cell.imgImage.image = UIImage(named: data["img"] ?? "")
        cell.lblTitle.text = data["title"]
        if indexPath.row == 2 {
            cell.lblTitleDescription.isHidden = false
            cell.swSwitch.isHidden = false
            cell.lblTitleDescription.text = data["titleDescription"]
            cell.vwTopBorder.isHidden = false
            cell.vwBottomBorder.isHidden = false
        } else {
            cell.lblTitleDescription.isHidden = true
            cell.swSwitch.isHidden = true
            cell.vwTopBorder.isHidden = true
            cell.vwBottomBorder.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = createView(storyboard: .profile, storyboardID: .SoldOutTicketVC)
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = createView(storyboard: .profile, storyboardID: .CancelThisEventVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// MARK: - NavigationBarViewDelegate
extension ManageEventSettingVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
