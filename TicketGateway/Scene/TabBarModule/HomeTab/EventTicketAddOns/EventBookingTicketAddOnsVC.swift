//
//  EventBookingTicketAddOnsVC.swift
//  TicketGateway
//
//  Created by Apple  on 15/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit
import iOSDropDown
class EventBookingTicketAddOnsVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblAddOn: UITableView!
    @IBOutlet weak var lblTotalTicketPrice :DropDown!
    
    
    // MARK: - Variables
    var addOnTableData = ["Tshirt_ip", "Tshirt_ip", "Tshirt_ip", "Tshirt_ip"]
    var totalTicketPrice = ""
    var feeStructure:FeeStructure?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setup()
    }
}
// MARK: - Functions
extension EventBookingTicketAddOnsVC{
    func setTableView() {
        tblAddOn.delegate = self
        tblAddOn.dataSource = self
        tblAddOn.register(UINib(nibName: "AddOnTableViewCell", bundle: nil), forCellReuseIdentifier: "AddOnTableViewCell")
    }
    
    
    private func setup() {
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = ADD_ONS
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.btnSkip.isHidden = false
        self.navigationView.btnSkip.setTitle(SKIP, for: .normal)
        self.navigationView.vwSkip.isHidden = false
        self.navigationView.btnBack.isHidden = false
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        [self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.setData()
    }
    
    func setData(){
        self.lblTotalTicketPrice.text = self.totalTicketPrice
    }
}

//MARK: - Actions
extension EventBookingTicketAddOnsVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
            
        default:
            break
        }
    }
    func btnContinueAction() {
        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingOrderSummaryVC) as? EventBookingOrderSummaryVC{
            view.viewModel.feeStructure = self.feeStructure
            self.navigationController?.pushViewController(view, animated: true)
        }
        
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension EventBookingTicketAddOnsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addOnTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddOnTableViewCell", for: indexPath) as! AddOnTableViewCell
        let data = addOnTableData[indexPath.row]
        cell.imgImage.image = UIImage(named: data)
        cell.btnDropDown.tag = indexPath.row
        cell.btnDropDown.addTarget(self, action: #selector(dropDownBtn), for: .touchUpInside)
        cell.toggle.tag = indexPath.row
        cell.toggle.addTarget(self, action: #selector(dropDownBtn23), for: .touchUpInside)
        cell.lblTitle.text = T_SHIRT
        cell.lblPrice.text = DOLLAR_PRICE
        cell.txtSelect.optionArray = ["Xl", "Large", "Medium", "Small"]
        cell.txtSelect.optionIds = [1,23,54,22]
        cell.txtSelect.didSelect{(selectedText , index ,id) in
            cell.txtSelect.text = "\(selectedText)"
        }
        return cell
        
    }
    @objc func dropDownBtn(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tblAddOn.cellForRow(at: indexPath) as! AddOnTableViewCell
        cell.txtSelect.showList()
    }
    
    @objc func dropDownBtn23(sender: UISwitch){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tblAddOn.cellForRow(at: indexPath) as! AddOnTableViewCell
        if sender.isOn {
            cell.bgTextView.isHidden = false
            
            let view = self.createView(storyboard: .main, storyboardID: .VerifyPopupVC) as! VerifyPopupVC
            view.strMsgForlbl = PEPSI
            view.img = POP_ICON
            view.strMessage = POP_DESCRIPTION
            view.strMsgBtn = OKAY
            view.closerForBack = { istrue in
                if istrue ==  true
                {
                    print("cancel")
                }
            }
            view.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            self.present(view, animated: true)
        } else {
            cell.bgTextView.isHidden = true
        }
    }
}

//MARK: - NavigationBarViewDelegate
extension EventBookingTicketAddOnsVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
