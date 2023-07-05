//
//  ManageMyEventListTableView.swift
//  TicketGateway
//
//  Created by Apple  on 10/05/23.
//

import UIKit

class ManageMyEventListTableView: UITableView {
       var tableDidSelectAtIndex: ((Int) -> Void)?
         var selectedDevice = ""
        var isFromDeselected = false
        func configure() {
            self.register(UINib(nibName: "ManageMyEventCell", bundle: nil), forCellReuseIdentifier: "ManageMyEventCell")
            self.delegate = self
            self.dataSource = self
        }
    }

    // MARK: - TableView Delegate
    extension ManageMyEventListTableView: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManageMyEventCell") as! ManageMyEventCell
            cell.btnManage.tag = indexPath.row
            cell.btnManage.addTarget(self, action: #selector(BtnMangeAction), for: .touchUpInside)
            cell.btnMenuMore.tag = indexPath.row
            cell.btnMenuMore.addTarget(self, action: #selector(btnMenuMore), for: .touchUpInside)
            
            cell.btnEdit.tag = indexPath.row
            cell.btnEdit.addTarget(self, action: #selector(btnEditAction), for: .touchUpInside)
            
            cell.btnView.tag = indexPath.row
            cell.btnView.addTarget(self, action: #selector(btnViewAction), for: .touchUpInside)
            
            cell.btnCopy.tag = indexPath.row
            cell.btnCopy.addTarget(self, action: #selector(btnCopyAction), for: .touchUpInside)
            
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(btnDeleteAction), for: .touchUpInside)
            cell.collVwPeople.configure()
           
            cell.collVwPeople.configure()
            cell.progressBar.progress = 1
            cell.progressBar.setProgress(0.5, animated: true)
             return cell
        }

         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             let cell = tableView.dequeueReusableCell(withIdentifier: "ManageMyEventCell") as! ManageMyEventCell
             self.tableDidSelectAtIndex?(indexPath.row)
             self.reloadData()
        }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            print("in \(indexPath.row)")
        }
        
        @objc func btnMenuMore(_ sender: UIButton) {
            let indexPath = IndexPath(row: sender.tag, section: 0)
           let cell = self.cellForRow(at: indexPath) as! ManageMyEventCell
            cell.vwPopUp.isHidden = false
            
        }
        
        @objc func btnEditAction(_ sender: UIButton) {
            let indexPath = IndexPath(row: sender.tag, section: 0)
           let cell = self.cellForRow(at: indexPath) as! ManageMyEventCell
            cell.vwPopUp.isHidden = true
            
        }
        
        @objc func btnViewAction(_ sender: UIButton) {
            let indexPath = IndexPath(row: sender.tag, section: 0)
           let cell = self.cellForRow(at: indexPath) as! ManageMyEventCell
            cell.vwPopUp.isHidden = true
            
        }
        
        @objc func btnCopyAction(_ sender: UIButton) {
            let indexPath = IndexPath(row: sender.tag, section: 0)
           let cell = self.cellForRow(at: indexPath) as! ManageMyEventCell
            cell.vwPopUp.isHidden = true
            
        }
        
        @objc func btnDeleteAction(_ sender: UIButton) {
            let indexPath = IndexPath(row: sender.tag, section: 0)
           let cell = self.cellForRow(at: indexPath) as! ManageMyEventCell
            cell.vwPopUp.isHidden = true
            
        }
        
        @objc func BtnMangeAction(sender: UIButton){
            self.tableDidSelectAtIndex?(sender.tag)
        }
        
    }
