//
//  EventtypesListTableView.swift
//  TicketGateway
//
//  Created by Apple  on 11/05/23.
//

// swiftlint: disable shorthand_operator

import UIKit

class TicketTypeListTableView: UITableView {

// MARK: - VARIABLES
    var tableDidSelectAtIndex: ((Int) -> Void)?
    var updatedPrice: ((Double) -> Void)?
    var lblNumberOfCount = 0
    var isFromDeselected = false
    var arrTicketList:[EventTicket]?
    var selectedArrTicketList = [EventTicket]()
    var isFromAccessCode: Bool = false
    var arrDataAccessCode:[EventTicket]?
//    var maxStepperCount: Int = 10
    var finalPrice = 0.0
    func configure() {
        self.register(UINib(nibName: "TicketTypesCell", bundle: nil), forCellReuseIdentifier: "TicketTypesCell")
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - TableView Delegate
extension TicketTypeListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFromAccessCode {
            return arrDataAccessCode?.count ?? 0
        }
        return arrTicketList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTypesCell") as! TicketTypesCell
        
 // MARK: - ONLINE
        if isFromAccessCode {
            if let arrAccessCode = self.arrDataAccessCode, arrAccessCode.indices.contains(indexPath.row) {
                cell.setData(event: arrAccessCode[indexPath.row])
            }
        } else {
            if let arrTicketList = self.arrTicketList, arrTicketList.indices.contains(indexPath.row) {
                cell.setData(event: arrTicketList[indexPath.row])
            }
        }
        
     
        //IF ERROR COME IN ADD TO CART UNCOMMENT THIS
//        if  self.selectedArrTicketList.indices.contains(indexPath.row) {
//            cell.setSelectedTicketData(selectedTicket: selectedArrTicketList[indexPath.row])
//        }
        
 // MARK: - OFFLINE
//        if indexPath.row == 0 {
//            cell.vwForGroup.isHidden = true
//            cell.vwEtcDiscripation.isHidden = false
//            cell.lblAmount.isHidden = true
//            cell.lblTittle.text = "General Admission"
//
//        } else if indexPath.row == 1 {
//            cell.lblAmount.isHidden = false
//            cell.vwForGroup.isHidden = true
//            cell.vwEtcDiscripation.isHidden = false
//            cell.lblTittle.text = "Early Bird Admission"
//
//        } else if indexPath.row == 2 {
//            cell.lblAmount.isHidden = false
//            cell.vwForGroup.isHidden = false
//            cell.vwEtcDiscripation.isHidden = true
//            cell.lblTittle.text = "Group Admission"
//
//        }
        
      
        cell.vwStepper.btnPlus.tag = indexPath.row
        cell.vwStepper.btnMinus.tag = indexPath.row
        cell.vwStepper.btnPlus.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        cell.vwStepper.btnMinus.addTarget(self, action: #selector(minustButtonPressed), for: .touchUpInside)
        
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
    
    // MARK: - OFFLINE
//    @objc func plusButtonPressed(_ sender: UIButton) {
//       print(sender.tag)
//        let indexPath = IndexPath(row: sender.tag, section: 0)
//        let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
//        let value =  cell.vwStepper.lblCount.text ?? ""
//        self.lblNumberOfCount = Int(value) ?? 0
//        self.lblNumberOfCount = self.lblNumberOfCount + 1
//        cell.vwStepper.lblCount.text = String(lblNumberOfCount)
//    }
//
//    @objc func minustButtonPressed(_ sender: UIButton) {
//         let indexPath = IndexPath(row: sender.tag, section: 0)
//        let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
//        let value =  cell.vwStepper.lblCount.text ?? ""
//        self.lblNumberOfCount = Int(value) ?? 0
//        if self.lblNumberOfCount > 0 {
//            self.lblNumberOfCount = self.lblNumberOfCount - 1
//            cell.vwStepper.lblCount.text = String(lblNumberOfCount)
//        } else {
//            cell.vwStepper.lblCount.text = "0"
//        }
//    }

    // MARK: - ONLINE
    @objc func plusButtonPressed(_ sender: UIButton) {
       print(sender.tag)
        if isFromAccessCode {
               print(sender.tag)
                let data = arrDataAccessCode?[sender.tag]
                let indexPath = IndexPath(row: sender.tag, section: 0)
                let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
                let value =  cell.vwStepper.lblCount.text ?? ""
                self.lblNumberOfCount = Int(value) ?? 0
            self.lblNumberOfCount = self.lblNumberOfCount + 1
                if lblNumberOfCount <= arrDataAccessCode?[sender.tag].ticketQuantity ?? 0 {
                   // self.lblNumberOfCount = self.lblNumberOfCount + 1
                    self.finalPrice += Double(data?.ticketPrice ?? 0)
                    //(lblNumberOfCount * (data?.ticketPrice ?? 0))
                    cell.vwStepper.lblCount.text = String(lblNumberOfCount)
                    arrDataAccessCode?[sender.tag].selectedTicketQuantity = lblNumberOfCount
                    if let data = arrDataAccessCode?[sender.tag]{
                        let contains = self.selectedArrTicketList.contains { ticket in
                            return ticket.ticketID == arrDataAccessCode?[sender.tag].ticketID
                        }
                        if !contains{
                            self.selectedArrTicketList.append(data)
                        }
                        self.updatedPrice?(finalPrice)
                    }
                }
            
        } else {
            let data = arrTicketList?[sender.tag]
            let indexPath = IndexPath(row: sender.tag, section: 0)
            let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
            let value =  cell.vwStepper.lblCount.text ?? ""
            self.lblNumberOfCount = Int(value) ?? 0
            self.lblNumberOfCount = self.lblNumberOfCount + 1
            if lblNumberOfCount <= arrTicketList?[sender.tag].ticketQuantity ?? 0 {
               // self.lblNumberOfCount = self.lblNumberOfCount + 1
                self.finalPrice += Double(data?.ticketPrice ?? 0)
                //(lblNumberOfCount * (data?.ticketPrice ?? 0))
                cell.vwStepper.lblCount.text = String(lblNumberOfCount)
                arrTicketList?[sender.tag].selectedTicketQuantity = lblNumberOfCount
                if let data = arrTicketList?[sender.tag]{
                    let contains = self.selectedArrTicketList.contains { ticket in
                        return ticket.uniqueTicketID == data.uniqueTicketID
                    }
                    if !contains{
                        self.selectedArrTicketList.append(data)
                    } else {
                        let index = selectedArrTicketList.firstIndex { ticket in
                            return ticket.uniqueTicketID == data.uniqueTicketID
                        }
                        
                        if let index = index, selectedArrTicketList.indices.contains(index) {
                            self.selectedArrTicketList[index].selectedTicketQuantity = lblNumberOfCount
                        }
                    }
                    self.updatedPrice?(finalPrice)
                }
            }
        }
    }

    @objc func minustButtonPressed(_ sender: UIButton) {
        if isFromAccessCode {
                let data = arrDataAccessCode?[sender.tag]
                 let indexPath = IndexPath(row: sender.tag, section: 0)
                let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
                let value =  cell.vwStepper.lblCount.text ?? ""
                self.lblNumberOfCount = Int(value) ?? 0
            self.lblNumberOfCount = self.lblNumberOfCount - 1
                if self.lblNumberOfCount > 0 {
                    //self.lblNumberOfCount = self.lblNumberOfCount - 1
                    self.finalPrice -= Double(data?.ticketPrice ?? 0)
                    //(lblNumberOfCount * (data?.ticketPrice ?? 0))
                    cell.vwStepper.lblCount.text = String(lblNumberOfCount)
                    arrDataAccessCode?[sender.tag].selectedTicketQuantity = lblNumberOfCount
                    if self.selectedArrTicketList.indices.contains(sender.tag) {
//                        self.selectedArrTicketList.removeAll { ticket in
//                            return ticket.ticketID == arrDataAccessCode?[sender.tag].ticketID
//                        }
                        self.selectedArrTicketList.remove(at: sender.tag)
                        self.updatedPrice?(finalPrice)
                    }
                } else {
                    cell.vwStepper.lblCount.text = "0"
                    arrDataAccessCode?[sender.tag].selectedTicketQuantity = 0
                   // self.selectedArrTicketList = self.arrDataAccessCode ?? [EventTicket]()
                    if self.selectedArrTicketList.indices.contains(sender.tag) {
                        self.selectedArrTicketList.removeAll { ticket in
                            return ticket.ticketID == arrDataAccessCode?[sender.tag].ticketID
                        }
                    }
                }
            
        } else {
               let data = arrTicketList?[sender.tag]
            let indexPath = IndexPath(row: sender.tag, section: 0)
            let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
            let value =  cell.vwStepper.lblCount.text ?? ""
            self.lblNumberOfCount = Int(value) ?? 0
            self.lblNumberOfCount = self.lblNumberOfCount - 1
            if self.lblNumberOfCount > 0 {
               // self.lblNumberOfCount = self.lblNumberOfCount - 1
                self.finalPrice -= Double(data?.ticketPrice ?? 0)
                //(lblNumberOfCount * (data?.ticketPrice ?? 0))
                cell.vwStepper.lblCount.text = String(lblNumberOfCount)
                arrTicketList?[sender.tag].selectedTicketQuantity = lblNumberOfCount
                
                if let data = arrTicketList?[sender.tag]{
                    let contains = self.selectedArrTicketList.contains { ticket in
                        return ticket.uniqueTicketID == data.uniqueTicketID
                    }
                    
                    if contains{
                        let index = selectedArrTicketList.firstIndex { ticket in
                            return ticket.uniqueTicketID == data.uniqueTicketID
                        }
                        if let index = index, selectedArrTicketList.indices.contains(index) {
                            self.selectedArrTicketList[index].selectedTicketQuantity = lblNumberOfCount
                        }
                    }
                    self.updatedPrice?(finalPrice)
                }
            } else if self.lblNumberOfCount == 0{
                cell.vwStepper.lblCount.text = "0"
                self.finalPrice -= Double(data?.ticketPrice ?? 0)
                arrTicketList?[sender.tag].selectedTicketQuantity = 0
                //self.selectedArrTicketList = self.arrTicketList ?? [EventTicket]()
                    self.selectedArrTicketList.removeAll { ticket in
//                        if ticket.uniqueTicketID == arrTicketList?[sender.tag].uniqueTicketID{
//                            self.finalPrice -= Double(data?.ticketPrice ?? 0)
//                        }
                        return ticket.uniqueTicketID == arrTicketList?[sender.tag].uniqueTicketID
                    }
                self.updatedPrice?(finalPrice)
            } else {
                cell.vwStepper.lblCount.text = "0"
            }
        }
    }
}
