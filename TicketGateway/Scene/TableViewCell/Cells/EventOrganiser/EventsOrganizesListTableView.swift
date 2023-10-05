//
//  EventsOrganizesListTableView.swift
//  TicketGateway
//
//  Created by Apple  on 28/04/23.


import UIKit

class EventsOrganizesListTableView: UITableView {
    var arrData = [GetEventModel]()
    var tableDidSelectAtIndex: ((Int) -> Void)?
    var selectedDevice = ""
    var isFromDeselected = false
    func configure() {
        self.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - TableView Delegate
extension EventsOrganizesListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if 5 > 3 {
//           return 3
//        }else{
//           return 5
//        }
        self.arrData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
            cell.getEvent = self.arrData[indexPath.row]
            cell.cellConfiguration()
            return cell
        } else {
            return UITableViewCell.init()
        }
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as! EventTableViewCell
         self.tableDidSelectAtIndex?(indexPath.row)
         self.reloadData()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("in \(indexPath.row)")
    }

    @objc func buttonPressed(_ sender: UIButton) {

    }

}
