////
////  SideMenuList.swift
////  TicketGateway
////
////  Created by Apple  on 02/05/23.
////
//
//import UIKit

import UIKit
//
class SideMenuList: UITableView {
    var isFromManageEventProfile = false
    var menu: [SideMenuModel]  = [SideMenuModel]()
    
    
   
    var tableDidSelectAtIndex: ((SideMenuModel) -> Void)?
    var selectedDevice = ""
    var isFromDeselected = false
    func configure() {
        self.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        self.delegate = self
        self.dataSource = self
        if isFromManageEventProfile == true{
            menu  = [
                SideMenuModel(icon: UIImage(named: "list")!, title: "Guest List", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "settings")!, title: "Event Setting", titleDis: ""),
           
            ]
            
        } else {
            menu  = [
                SideMenuModel(icon: UIImage(named: "allevent")!, title: "All Events", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "ticket")!, title: "Tickets", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "heart")!, title: "Favorites", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "wallet")!, title: "My Wallet", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "wallet")!, title: "My Refunds", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "notification")!, title: "Notifications", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "percent")!, title: "Rewords & Loyality Points", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "event")!, title: "Manage Events", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "costume")!, title: "Costumes", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "location")!, title: "Venue", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music")!, title: "Artists", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music")!, title: "Organizers", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music")!, title: "Device Settings", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music")!, title: "Feedback", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music")!, title: "FAQs", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "log-out")!, title: "Log Out", titleDis: "Log Out from TicketGateway"),
            ]
        }
    }
}

// MARK: - TableView Delegate
extension SideMenuList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        cell.imgSideMenuCategory.image = self.menu[indexPath.row].icon
        cell.lblTittle.text = self.menu[indexPath.row].title
        
              
        if menu.count-1 == indexPath.row
        {
            cell.lblDiscripation.isHidden = false
            cell.lblDiscripation.text = menu[indexPath.row].titleDis
        } else {
            cell.lblDiscripation.isHidden = true
        }
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        
         
        self.tableDidSelectAtIndex!(menu[indexPath.row])
        }
    

}



