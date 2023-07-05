//
//  NotificationTableViewList.swift
//  TicketGateway
//
//  Created by Apple  on 02/06/23.
//

import UIKit

class NotificationTableViewList: UITableView {
    var tableDidSelectAtIndex: ((Int) -> Void)?
      var selectedDevice = ""
     var isFromDeselected = false
     func configure() {
         self.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
         self.delegate = self
         self.dataSource = self
     }
 }

 // MARK: - TableView Delegate
 extension NotificationTableViewList: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 4
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        
          return cell
     }

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
          self.tableDidSelectAtIndex?(indexPath.row)
          self.reloadData()
     }
     
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         print("in \(indexPath.row)")
     }
     
     @objc func buttonPressed(_ sender: UIButton) {
         
     }
     
 }
