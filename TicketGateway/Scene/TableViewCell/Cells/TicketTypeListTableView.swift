//
//  EventtypesListTableView.swift
//  TicketGateway
//
//  Created by Apple  on 11/05/23.
//

import UIKit

class TicketTypeListTableView: UITableView {
    
    var tableDidSelectAtIndex: ((Int) -> Void)?
    var lblNumberOfCount = 0
    var isFromDeselected = false
    func configure() {
        self.register(UINib(nibName: "TicketTypesCell", bundle: nil), forCellReuseIdentifier: "TicketTypesCell")
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - TableView Delegate
extension TicketTypeListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTypesCell") as! TicketTypesCell
        if indexPath.row == 0 {
            cell.vwForGroup.isHidden = true
            cell.vwEtcDiscripation.isHidden = false
            cell.lblAmount.isHidden = true
            cell.lblTittle.text = "General Admission"
            
        } else if indexPath.row == 1 {
            cell.lblAmount.isHidden = false
            cell.vwForGroup.isHidden = true
            cell.vwEtcDiscripation.isHidden = false
            cell.lblTittle.text = "Early Bird Admission"
            
        } else if indexPath.row == 2{
            cell.lblAmount.isHidden = false
            cell.vwForGroup.isHidden = false
            cell.vwEtcDiscripation.isHidden = true
            cell.lblTittle.text = "Group Admission"
            
        }
        
      
        cell.vwStepper.btnPlus.tag = indexPath.row
        cell.vwStepper.btnMinus.tag = indexPath.row
        cell.vwStepper.btnPlus.addTarget(self, action: #selector(PlusButtonPressed), for: .touchUpInside)
        cell.vwStepper.btnMinus.addTarget(self, action: #selector(MinustButtonPressed), for: .touchUpInside)
        
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
