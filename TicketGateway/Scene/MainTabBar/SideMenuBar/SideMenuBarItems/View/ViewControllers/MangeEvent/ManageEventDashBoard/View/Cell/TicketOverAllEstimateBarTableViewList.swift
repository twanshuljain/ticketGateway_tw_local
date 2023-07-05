//
//  TicketOverAllEstimateBarTableViewList.swift
//  TicketGateway
//
//  Created by Apple  on 19/05/23.
//

import UIKit

class TicketOverAllEstimateBarTableViewList: UITableView {
    var tableDidSelectAtIndex: ((Int) -> Void)?
      var selectedDevice = ""
     var isFromDeselected = false
     func configure() {
         self.register(UINib(nibName: "TicketOverAllEstimateBarCell", bundle: nil), forCellReuseIdentifier: "TicketOverAllEstimateBarCell")
         self.delegate = self
         self.dataSource = self
     }
 }

 // MARK: - TableView Delegate
 extension TicketOverAllEstimateBarTableViewList: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 4
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TicketOverAllEstimateBarCell") as! TicketOverAllEstimateBarCell
        
          return cell
     }

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let cell = tableView.dequeueReusableCell(withIdentifier: "TicketOverAllEstimateBarCell") as! TicketOverAllEstimateBarCell
          self.tableDidSelectAtIndex?(indexPath.row)
          self.reloadData()
     }
     
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         print("in \(indexPath.row)")
     }
     
     @objc func buttonPressed(_ sender: UIButton) {
         
     }
     
 }
