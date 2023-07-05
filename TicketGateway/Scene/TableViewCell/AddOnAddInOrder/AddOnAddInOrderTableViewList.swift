//
//  AddOnAddInOrderTableViewList.swift
//  TicketGateway
//
//  Created by Apple  on 16/05/23.
//

import UIKit

class AddOnAddInOrderTableViewList: UITableView {
    
    var tableDidSelectAtIndex: ((Int) -> Void)?
    var lblNumberOfCount = 0
    var isFromDeselected = false
    func configure() {
        self.register(UINib(nibName: "AddOnAddInOrderCell", bundle: nil), forCellReuseIdentifier: "AddOnAddInOrderCell")
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - TableView Delegate
extension AddOnAddInOrderTableViewList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddOnAddInOrderCell") as! AddOnAddInOrderCell
        if indexPath.row == 3-1
        {
            cell.vwDottedLine.isHidden = false
        } else {
            cell.vwDottedLine.isHidden = true
        }
          return cell
        
        
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTypesCell") as! TicketTypesCell
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
        let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.lblNumberOfCount = Int(value) ?? 0
        self.lblNumberOfCount = self.lblNumberOfCount + 1
        cell.vwStepper.lblCount.text = String(lblNumberOfCount)
    }
    
    @objc func MinustButtonPressed(_ sender: UIButton) {
         let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
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
