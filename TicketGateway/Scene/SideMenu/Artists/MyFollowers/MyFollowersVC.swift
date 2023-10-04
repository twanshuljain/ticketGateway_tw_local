//
//  MyFollowersVC.swift
//  TicketGateway
//
//  Created by Apple on 08/06/23.


import UIKit
import SideMenu

class MyFollowersVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var tblMyFollowerTableView: UITableView!
    @IBOutlet weak var lblTotalFollowers: UILabel!
    
    // MARK: - Variables
    let arrData = ["profile", "profile", "profile", "profile", "profile", "profile", "profile", "profile", "profile", "profile", "profile", "profile", "profile", "profile"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setNavigationView()
        self.setFont()
    }
}

//MARK: - Functions
extension MyFollowersVC{
    func setNavigationView() {
        self.vwNavigationView.lblTitle.text = MY_FOLLOWERS
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize:   .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.vwNavigationView.imgBack.image = UIImage(named: MENU_ICON)
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.delegateBarAction = self
        // self.vwNavigationView.vwBorder.isHidden = false
    }
    
    func setTableView() {
        self.tblMyFollowerTableView.delegate = self
        self.tblMyFollowerTableView.dataSource = self
    }
    
    func setFont() {
        self.lblTotalFollowers.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTotalFollowers.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension MyFollowersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFollowerTableViewCell", for: indexPath) as! MyFollowerTableViewCell
        return cell
    }
}
//MARK: - NavigationBarViewDelegate
extension MyFollowersVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}

