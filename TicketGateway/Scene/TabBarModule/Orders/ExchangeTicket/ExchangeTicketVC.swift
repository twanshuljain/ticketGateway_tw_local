//
//  ExchangeTicketVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit

class ExchangeTicketVC: UIViewController, UITextFieldDelegate {

    //MARK: - IBOutlets
    @IBOutlet weak var tblExchangeTbleView: UITableView!
    @IBOutlet weak var btnExchange: CustomButtonGradiant!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    //MARK: - Variables
    let tblData = ["YoungGold", "VIP", "VIP", "Early Birds Advance"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setFont()
        self.setNavigationView()

    }
}

//MARK: - Functions
extension ExchangeTicketVC{
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = EXCHANGE_FOR
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.vwNavigationView.lblDiscripation.isHidden = false
        self.vwNavigationView.lblDiscripation.text = NUMBERS
        self.vwNavigationView.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.vwNavigationView.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
    func setTableView() {
        tblExchangeTbleView.delegate = self
        tblExchangeTbleView.dataSource = self
        tblExchangeTbleView.register(UINib(nibName: "ExchangeTableViewCell", bundle: nil), forCellReuseIdentifier: "ExchangeTableViewCell")
    }
    
    func setFont() {
        btnExchange.addTarget(self, action: #selector(navigate(_:)), for: .touchUpInside)
        btnExchange.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnExchange.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        btnExchange.addRightIcon(image: UIImage(named: CHANGE_ICON))
        
    }
}

//MARK: - Actions
extension ExchangeTicketVC{
    @objc func navigate(_ sender: UIButton) {
      //  self.showAlert(title: "Exchange ticket", message: "You need to pay CAD$9.90 to exchange your ticket. Do you want to continue?")
//        let alert = UIAlertController(title: "Exchange ticket", message: "You need to pay CAD$9.90 to exchange your ticket. Do you want to continue?", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
//          print("Handle Ok logic here")
//          }))
//
//        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
//          print("Handle Cancel Logic here")
//            let vc = self.createView(storyboard: .order, storyboardID: .OrderSummaryVC)
//            self.navigationController?.pushViewController(vc, animated: true)
//          }))
//        present(alert, animated: true, completion: nil)
        
        self.showAlert(title: EXCHANGE_TICKETS, message: "You need to pay CAD$9.90 to exchange your ticket. Do you want to continue?", complition: {_ in
            let vc = self.createView(storyboard: .order, storyboardID: .OrderSummaryVC)
            self.navigationController?.pushViewController(vc, animated: true)
        })

        
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension ExchangeTicketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeTableViewCell", for: indexPath) as! ExchangeTableViewCell
        let data = tblData[indexPath.row]
        cell.lblYoungGold.text = data
        cell.swSwitch.tag = indexPath.row
//        cell.swSwitch.addTarget(self, action: #selector(switchPressed(sender:)), for: .touchUpInside)
        cell.btnDropDown.tag = indexPath.row
        cell.btnDropDown.addTarget(self, action: #selector(dropDownBtn(sender:)), for: .touchUpInside)
        cell.txtField.delegate = self
        cell.txtField.optionArray = ["Small", "Large", "Medium"]
        cell.txtField.optionIds = [1,23,54]
        cell.txtField.didSelect{(selectedText , index ,id) in
            cell.txtField.text = "\(selectedText)"
        }
        return cell
    }
    
    @objc func dropDownBtn(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
//        let cell = addOnTableView.cellForRow(at: indexPath) as! AddOnTableViewCell
        let cell = tblExchangeTbleView.cellForRow(at: indexPath) as!
        ExchangeTableViewCell
        cell.txtField.showList()
    } 
}
//MARK: - NavigationBarViewDelegate
extension ExchangeTicketVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
  
}
