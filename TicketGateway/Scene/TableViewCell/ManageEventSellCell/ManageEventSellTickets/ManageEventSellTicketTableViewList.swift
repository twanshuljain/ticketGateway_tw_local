//
//  ManageEventSellTicketTableViewList.swift
//  TicketGateway
//
//  Created by Apple  on 24/05/23.
//

import UIKit

class ManageEventSellTicketTableViewList: UITableView {
    var isFromSellTab = false
    var tableDidSelectAtIndex: ((Int) -> Void)?
    var lblNumberOfCount = 0
    var isFromDeselected = false
    func configure() {
        self.register(UINib(nibName: "ManageEventSellTicketCell", bundle: nil), forCellReuseIdentifier: "ManageEventSellTicketCell")
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - TableView Delegate
extension ManageEventSellTicketTableViewList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageEventSellTicketCell") as! ManageEventSellTicketCell
        cell.vwStepper.btnPlus.tag = indexPath.row
        cell.vwStepper.btnMinus.tag = indexPath.row
        cell.vwStepper.btnPlus.addTarget(self, action: #selector(PlusButtonPressed), for: .touchUpInside)
        cell.vwStepper.btnMinus.addTarget(self, action: #selector(MinustButtonPressed), for: .touchUpInside)
        if self.isFromSellTab == true {
            cell.lblAmountComp.text = "$250"
        } else {
            cell.lblAmountComp.text = "Comp"
        }
          return cell
        
        
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ManageEventSellTicketCell") as! ManageEventSellTicketCell
         self.tableDidSelectAtIndex?(indexPath.row)
         self.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("in \(indexPath.row)")
    }
    
    
    @objc func buttonPressed(_ sender: UIButton) {
        
    }
    


    @objc func PlusButtonPressed(_ sender: UIButton) {
       print(sender.tag)
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! ManageEventSellTicketCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.lblNumberOfCount = Int(value) ?? 0
        self.lblNumberOfCount = self.lblNumberOfCount + 1
        cell.vwStepper.lblCount.text = String(lblNumberOfCount)
    }
    
    @objc func MinustButtonPressed(_ sender: UIButton) {
         let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! ManageEventSellTicketCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.lblNumberOfCount = Int(value) ?? 0
        if self.lblNumberOfCount > 0 {
            self.lblNumberOfCount = self.lblNumberOfCount - 1
            cell.vwStepper.lblCount.text = String(lblNumberOfCount)
        } else {
            cell.vwStepper.lblCount.text = "0"
        }
    }
    
    
    
    
}
