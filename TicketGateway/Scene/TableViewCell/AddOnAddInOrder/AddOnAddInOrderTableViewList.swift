//
//  AddOnAddInOrderTableViewList.swift
//  TicketGateway
//
//  Created by Apple  on 16/05/23.
// swiftlint: disable force_cast

import UIKit
class AddOnAddInOrderTableViewList: UITableView {
// MARK: - VARIABLES
    var selectedAddOnList = [EventTicketAddOnResponseModel]()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedAddOnList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20))
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 0, width: headerView.frame.width-16, height: headerView.frame.height)
        label.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        label.textColor = UIColor.setColor(colorType: .placeHolder)
        headerView.addSubview(label)
        label.text = "Add ons"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddOnAddInOrderCell") as? AddOnAddInOrderCell{
            cell.setData(addOnData: self.selectedAddOnList[indexPath.row])
            if indexPath.row == 3-1 {
                cell.vwDottedLine.isHidden = false
            } else {
                cell.vwDottedLine.isHidden = true
            }
            return cell
        }
        return UITableViewCell()
        
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
    @objc func plusButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.lblNumberOfCount = Int(value) ?? 0
        self.lblNumberOfCount += 1
        cell.vwStepper.lblCount.text = String(lblNumberOfCount)
    }
    @objc func minustButtonPressed(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.cellForRow(at: indexPath) as! TicketTypesCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.lblNumberOfCount = Int(value) ?? 0
        if self.lblNumberOfCount > 0 {
            self.lblNumberOfCount -= 1
            cell.vwStepper.lblCount.text = String(lblNumberOfCount)
        } else {
            cell.vwStepper.lblCount.text = "0"
        }
    }
}
