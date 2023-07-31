//
//  EventtypesListTableView.swift
//  TicketGateway
//
//  Created by Apple  on 11/05/23.
//
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name
// swiftlint: disable shorthand_operator

import UIKit

class TicketTypeListTableView: UITableView {

//MARK: - VARIABLES
    var tableDidSelectAtIndex: ((Int) -> Void)?
    var updatedPrice: ((Int) -> Void)?
    var lblNumberOfCount = 0
    var isFromDeselected = false
    var arrTicketList:[EventTicket]?
    var selectedArrTicketList = [EventTicket]()
//    var maxStepperCount: Int = 10
    var finalPrice = 0
    func configure() {
        self.register(UINib(nibName: "TicketTypesCell", bundle: nil), forCellReuseIdentifier: "TicketTypesCell")
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - TableView Delegate
extension TicketTypeListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTicketList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTypesCell") as! TicketTypesCell
        
 // MARK: - ONLINE
        if let arrTicketList = self.arrTicketList, arrTicketList.indices.contains(indexPath.row){
            cell.setData(event: arrTicketList[indexPath.row])
        }

        if  self.selectedArrTicketList.indices.contains(indexPath.row){
            cell.setSelectedTicketData(selectedTicket: selectedArrTicketList[indexPath.row])
        }
        
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
    
    //MARK: - OFFLINE
//    @objc func PlusButtonPressed(_ sender: UIButton) {
//       print(sender.tag)
//        let indexPath = IndexPath(row: sender.tag, section: 0)
//        let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
//        let value =  cell.vwStepper.lblCount.text ?? ""
//        self.lblNumberOfCount = Int(value) ?? 0
//        self.lblNumberOfCount = self.lblNumberOfCount + 1
//        cell.vwStepper.lblCount.text = String(lblNumberOfCount)
//    }
//
//    @objc func MinustButtonPressed(_ sender: UIButton) {
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
    @objc func PlusButtonPressed(_ sender: UIButton) {
       print(sender.tag)
        let data = arrTicketList?[sender.tag]
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.lblNumberOfCount = Int(value) ?? 0
        if lblNumberOfCount < arrTicketList?[sender.tag].ticketMaximumQuantity ?? 0 {
            self.lblNumberOfCount = self.lblNumberOfCount + 1
            self.finalPrice += data?.ticketPrice ?? 0
            //(lblNumberOfCount * (data?.ticketPrice ?? 0))
            cell.vwStepper.lblCount.text = String(lblNumberOfCount)
            arrTicketList?[sender.tag].selectedTicketQuantity = lblNumberOfCount
            self.selectedArrTicketList = self.arrTicketList ?? [EventTicket]()
            
            self.updatedPrice?(finalPrice)
        }
    }

    @objc func MinustButtonPressed(_ sender: UIButton) {
        let data = arrTicketList?[sender.tag]
         let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.lblNumberOfCount = Int(value) ?? 0
        if self.lblNumberOfCount > 0 {
            self.lblNumberOfCount = self.lblNumberOfCount - 1
            self.finalPrice -= data?.ticketPrice ?? 0
            //(lblNumberOfCount * (data?.ticketPrice ?? 0))
            cell.vwStepper.lblCount.text = String(lblNumberOfCount)
            arrTicketList?[sender.tag].selectedTicketQuantity = lblNumberOfCount
            self.selectedArrTicketList = self.arrTicketList ?? [EventTicket]()
            
            self.updatedPrice?(finalPrice)
        } else {
            cell.vwStepper.lblCount.text = "0"
            arrTicketList?[sender.tag].selectedTicketQuantity = 0
            self.selectedArrTicketList = self.arrTicketList ?? [EventTicket]()
            
            //self.updatedPrice?(0)
        }
    }
}
