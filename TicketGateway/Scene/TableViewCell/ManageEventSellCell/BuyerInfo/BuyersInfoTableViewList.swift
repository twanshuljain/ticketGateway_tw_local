//
//  BuyersInfoTableViewList.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
//

import UIKit

class BuyersInfoTableViewList: UITableView {
    let nameFormatter = PersonNameComponentsFormatter()
    var tableDidSelectAtIndex: ((Int) -> Void)?
    var tableDidSelectAtIndexEdit: ((Int) -> Void)?
   
      var selectedDevice = ""
     var isFromDeselected = false
     func configure() {
         self.register(UINib(nibName: "BuyersInfoCell", bundle: nil), forCellReuseIdentifier: "BuyersInfoCell")
         self.delegate = self
         self.dataSource = self
     }
 }

 // MARK: - TableView Delegate
 extension BuyersInfoTableViewList: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 4
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "BuyersInfoCell") as! BuyersInfoCell
         cell.btnMenuMore.tag = indexPath.row
         cell.btnMenuMore.addTarget(self, action: #selector(btnMenuMore), for: .touchUpInside)
         cell.btnDelete.tag = indexPath.row
         cell.btnDelete.addTarget(self, action: #selector(btnDeleteAction), for: .touchUpInside)
         cell.btnEdit.tag = indexPath.row
         cell.btnEdit.addTarget(self, action: #selector(btnEditAction), for: .touchUpInside)
         cell.lblFristAndLastName.text = funcpersonNameComponents(strValue: cell.lblName.text ?? "")
          return cell
     }

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          _ = tableView.dequeueReusableCell(withIdentifier: "BuyersInfoCell") as! BuyersInfoCell
          self.tableDidSelectAtIndex?(indexPath.row)
          self.reloadData()
     }
     
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         print("in \(indexPath.row)")
     }
     
     @objc func buttonPressed(_ sender: UIButton) {
         
     }
     
     @objc func btnEditAction(_ sender: UIButton) {
         
         let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! BuyersInfoCell
         self.tableDidSelectAtIndexEdit?(sender.tag)
         
     }
     
     @objc func btnDeleteAction(_ sender: UIButton) {
         let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! BuyersInfoCell
         cell.vwPopUp.isHidden = true
         self.deleteRows(at: [indexPath], with: .automatic)
         
     }
     @objc func btnMenuMore(_ sender: UIButton) {
         let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! BuyersInfoCell
         
         if cell.vwPopUp.isHidden == false {
             cell.vwPopUp.isHidden = true
         } else {
             cell.vwPopUp.isHidden = false
         }
         
     }
     
     func funcpersonNameComponents(strValue: String) -> String
     {
         var  fristName = ""
         var  lastNames = ""
         if let nameComps  = nameFormatter.personNameComponents(from: strValue) {
             if let  firstLetter = nameComps.givenName?.first {
                 fristName = String(firstLetter)
             }
             
             if let lastName = nameComps.familyName?.first {
                 lastNames = String(lastName)
             }
            return "\(fristName)\(lastNames)".uppercased()
         }
         return "\(fristName)\(lastNames)".uppercased()
     }
 }
