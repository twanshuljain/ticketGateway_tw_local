//
//  TicketAddInOrder.swift
//  TicketGateway
//
//  Created by Apple  on 16/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name
// swiftlint: disable cyclomatic_complexity
// swiftlint: disable shorthand_operator
// swiftlint: disable type_name
// swiftlint: disable duplicate_conditions
import UIKit

class TicketAddInOrderTableViewList: UITableView {
    
    //MARK: - VARIABLES
    var selectedArrTicketList = [EventTicket]()
    var tableDidSelectAtIndex: ((Int) -> Void)?
    var lblNumberOfCount = 0
    var isFromDeselected = false
    var selectedCurrencyType = ""
    
    func configure() {
        self.register(UINib(nibName: "TicketAddInOrderCell", bundle: nil), forCellReuseIdentifier: "TicketAddInOrderCell")
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - TableView Delegate
extension TicketAddInOrderTableViewList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArrTicketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TicketAddInOrderCell") as? TicketAddInOrderCell{
            cell.setData(ticketData: selectedArrTicketList[indexPath.row], selectedCurrencyType: self.selectedCurrencyType)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTypesCell") as? TicketTypesCell{
            self.tableDidSelectAtIndex?(indexPath.row)
            self.reloadData()
        }
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
