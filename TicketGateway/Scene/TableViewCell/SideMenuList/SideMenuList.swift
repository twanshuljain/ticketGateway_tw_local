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
                SideMenuModel(icon: UIImage(named: "scan") ?? UIImage(), title: "Scan Events", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "allevent") ?? UIImage(), title: "All Events", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "costume") ?? UIImage(), title: "Costumes", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "notification") ?? UIImage(), title: "Notifications", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "music") ?? UIImage(), title: "Artists", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "organizer") ?? UIImage(), title: "Organizers", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "venue") ?? UIImage(), title: "Venue", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "devicesetting") ?? UIImage(),
                              title: "Device Settings", titleDis: ""),
                SideMenuModel(icon: UIImage(named: "faq") ?? UIImage(), title: "FAQs", titleDis: "")
            ]
        } else {
            if isFromManageEvent == true {
                if self.isFromManageEventProfile == false {
                    menu = [
                        SideMenuModel(icon: UIImage(named: "settings") ?? UIImage(),
                                      title: "Manage Events", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "scan") ?? UIImage(), title: "Scan Events", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "allevent") ?? UIImage(), title: "All Events", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "costume") ?? UIImage(), title: "Costumes", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "heart") ?? UIImage(), title: "My Favorites", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "wallet") ?? UIImage(), title: "My Wallet", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "refund") ?? UIImage(), title: "My Refunds", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "notification") ?? UIImage(),
                                      title: "Notifications", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "ticket") ?? UIImage(), title: "Orders", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "music") ?? UIImage(), title: "Artists", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "organizer") ?? UIImage(),
                                      title: "Organizers", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "venue") ?? UIImage(), title: "Venue", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "percent") ?? UIImage(),
                                      title: "Rewords & Loyality Points", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "organizer") ?? UIImage(),
                                      title: "My Followers", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "devicesetting") ?? UIImage(),
                                      title: "Device Settings", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "message-square") ?? UIImage(),
                                      title: "Feedback", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "faq") ?? UIImage(), title: "FAQs", titleDis: ""),
                        SideMenuModel(icon: UIImage(named: "log-out") ?? UIImage(),
                                      title: "Log Out", titleDis: "Log out from TicketGateway")
                    ]
                }
            } else {
                menu = [
                    SideMenuModel(icon: UIImage(named: "allevent") ?? UIImage(), title: "All Events", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "costume") ?? UIImage(), title: "Costumes", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "heart") ?? UIImage(), title: "My Favorites", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "wallet") ?? UIImage(), title: "My Wallet", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "refund") ?? UIImage(), title: "My Refunds", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "notification") ?? UIImage(),
                                  title: "Notifications", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "ticket") ?? UIImage(), title: "Orders", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "music") ?? UIImage(), title: "Artists", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "organizer") ?? UIImage(), title: "Organizers", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "venue") ?? UIImage(), title: "Venue", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "percent") ?? UIImage(),
                                  title: "Rewords & Loyality Points", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "devicesetting") ?? UIImage(),
                                  title: "Device Settings", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "message-square") ?? UIImage(),
                                  title: "Feedback", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "faq") ?? UIImage(), title: "FAQs", titleDis: ""),
                    SideMenuModel(icon: UIImage(named: "log-out") ?? UIImage(),
                                  title: "Log Out", titleDis: "Log out from TicketGateway")
                ]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as? SideMenuCell
        cell?.btnRisArrow.setImage(UIImage(named: "chevron-right_ip"), for: .normal)
        cell?.imgSideMenuCategory.image = self.menu[indexPath.row].icon
        cell?.lblTittle.text = self.menu[indexPath.row].title
        if menu.count-1 == indexPath.row {
            cell?.lblDiscripation.isHidden = false
            cell?.lblDiscripation.text = menu[indexPath.row].titleDis
        } else {
            cell?.lblDiscripation.isHidden = true
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as? SideMenuCell ?? UITableViewCell()
        self.tableDidSelectAtIndex?(menu[indexPath.row])
    }
}
