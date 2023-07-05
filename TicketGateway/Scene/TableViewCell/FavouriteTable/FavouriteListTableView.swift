//
//  EventsOrganizesListTableView.swift
//  TicketGateway
//
//  Created by Apple  on 28/04/23.
//

import UIKit

class FavouriteListTableView: UITableView {
    
    var tableDidSelectAtIndex: ((Int) -> Void)?
//    var blutoothDevices = [DisplayPeripheral]()
//    var heartMonitor = HeartRateMonitor()
    var selectedDevice = ""
    var isFromDeselected = false
    var isFromVenue = String()
    func configure() {
        self.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteTableViewCell")
        self.separatorColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
}

// MARK: - TableView Delegate
extension FavouriteListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell") as! FavouriteTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath) as! FavouriteTableViewCell
        if isFromVenue == "Venue" {
        cell.lblFavoriteDate.isHidden = true
        }
        return cell
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell") as! FavouriteTableViewCell
         self.tableDidSelectAtIndex?(indexPath.row)
         self.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("in \(indexPath.row)")
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
    }
    
}
