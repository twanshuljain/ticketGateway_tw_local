

import UIKit

class SideMenuList: UITableView {
    
// MARK: - VARIABLES
    var isFromManageEventProfile = false
    var isFromManageEvent = false
    var menu: [SideMenuModel] = [SideMenuModel]()
    var tableDidSelectAtIndex: ((SideMenuModel) -> Void)?
    var selectedDevice = ""
    var isFromDeselected = false
    var isFromSkip: Bool = false
// MARK: - CONFIGURE
    func configure() {
        self.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        self.delegate = self
        self.dataSource = self
        self.isFromSkip = UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin)
        if isFromSkip {
            menu = [
                
                SideMenuModel(icon: UIImage(named: "scan")!, title: "Scan Events", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "allevent")!, title: "All Events", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "costume")!, title: "Costumes", titleDis: ""),
                
                
                SideMenuModel(icon: UIImage(named: "notification")!, title: "Notifications", titleDis: ""),
                
                SideMenuModel(icon: UIImage(named: "music")!, title: "Artists", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "organizer")!, title: "Organizers", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "venue")!, title: "Venue", titleDis: ""),
                
                
                SideMenuModel(icon: UIImage(named: "devicesetting")!, title: "Device Settings", titleDis: ""),
                
                SideMenuModel(icon: UIImage(named: "faq")!, title: "FAQs", titleDis: "")]
                
            
        } else {
            if isFromManageEvent == true {
            
            if self.isFromManageEventProfile == false
            {
                menu = [
                    SideMenuModel(icon: UIImage(named: "settings")!, title: "Manage Events", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "scan")!, title: "Scan Events", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "allevent")!, title: "All Events", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "costume")!, title: "Costumes", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "heart")!, title: "My Favorites", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "wallet")!, title: "My Wallet", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "refund")!, title: "My Refunds", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "notification")!, title: "Notifications", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "ticket")!, title: "Orders", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "music")!, title: "Artists", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "organizer")!, title: "Organizers", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "venue")!, title: "Venue", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "percent")!, title: "Rewords & Loyality Points", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "organizer")!, title: "My Followers", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "devicesetting")!, title: "Device Settings", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "message-square")!, title: "Feedback", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "faq")!, title: "FAQs", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "log-out")!, title: "Log Out", titleDis: "Log out from TicketGateway")]
                
            }
            //        else {
            //            menu = [
            //                SideMenuModel(icon: UIImage(named: "list")!, title: "Guest List", titleDis: ""),
            //                SideMenuModel(icon: UIImage(named: "settings")!, title: "Event Setting", titleDis: ""),
            //            ]
            //        }
        } else {
            menu = [
                
                SideMenuModel(icon: UIImage(named: "allevent")!, title: "All Events", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "costume")!, title: "Costumes", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "heart")!, title: "My Favorites", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "wallet")!, title: "My Wallet", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "refund")!, title: "My Refunds", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "notification")!, title: "Notifications", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "ticket")!, title: "Orders", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music")!, title: "Artists", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "organizer")!, title: "Organizers", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "venue")!, title: "Venue", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "percent")!, title: "Rewords & Loyality Points", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "devicesetting")!, title: "Device Settings", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "message-square")!, title: "Feedback", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "faq")!, title: "FAQs", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "log-out")!, title: "Log Out", titleDis: "Log out from TicketGateway")]
        }
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
        cell.btnRisArrow.setImage(UIImage(named: "chevron-right_ip"), for: .normal)
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
