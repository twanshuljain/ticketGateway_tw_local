////
////  SideMenuList.swift
////  TicketGateway
////
////  Created by Apple  on 02/05/23.
////
//

import UIKit

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
        if isFromManageEventProfile == true {
            menu  = [
                SideMenuModel(icon: UIImage(named: "list") ?? UIImage(), title: "Guest List", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "settings") ?? UIImage(), title: "Event Setting", titleDis: "")
            ]
        } else {
            menu  = [
                SideMenuModel(icon: UIImage(named: "allevent") ?? UIImage(), title: "All Events", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "ticket") ?? UIImage(), title: "Tickets", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "heart") ?? UIImage(), title: "Favorites", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "wallet") ?? UIImage(), title: "My Wallet", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "wallet") ?? UIImage(), title: "My Refunds", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "notification") ?? UIImage(), title: "Notifications", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "percent") ?? UIImage(),
                              title: "Rewords & Loyality Points", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "event") ?? UIImage(), title: "Manage Events", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "costume") ?? UIImage(), title: "Costumes", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "location") ?? UIImage(), title: "Venue", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music") ?? UIImage(), title: "Artists", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music") ?? UIImage(), title: "Organizers", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music") ?? UIImage(), title: "Device Settings", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music") ?? UIImage(), title: "Feedback", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music") ?? UIImage(), title: "FAQs", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "log-out") ?? UIImage(),
                              title: "Log Out", titleDis: "Log Out from TicketGateway")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as? SideMenuCell ?? UITableViewCell()
        cell.imgSideMenuCategory.image = self.menu[indexPath.row].icon
        cell.lblTittle.text = self.menu[indexPath.row].title
        if menu.count-1 == indexPath.row {
            cell.lblDiscripation.isHidden = false
            cell.lblDiscripation.text = menu[indexPath.row].titleDis
        } else {
            cell.lblDiscripation.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as? SideMenuCell ?? UITableViewCell()
        self.tableDidSelectAtIndex?(menu[indexPath.row])
    }
}
