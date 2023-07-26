//
//  EventBookingTicketAddOnsVC.swift
//  TicketGateway
//
//  Created by Apple  on 15/05/23.
//

import UIKit
import iOSDropDown
import SVProgressHUD

class EventBookingTicketAddOnsVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblAddOn: UITableView!
    
    //MARK: - Variables
    var viewModel = EventTiclketAddOnViewModel()
    var addOnTableData = ["Tshirt_ip", "Tshirt_ip", "Tshirt_ip", "Tshirt_ip"]
    var dataForAddOn = [EventTicketAddOnResponseModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setup()
        self.addOnApiCall()
        
    }
    
    func addOnApiCall() {
        
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.getAddOnTicketList(complition: { isTrue, errMsg in
                if isTrue {
                    SVProgressHUD.dismiss()
                    DispatchQueue.main.async {
                        self.dataForAddOn = self.viewModel.arrAddOnTicketList ?? []
                        print("--------------", self.dataForAddOn)
                        self.tblAddOn.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: errMsg)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    
}

//MARK: - Functions
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
        let view = self.createView(storyboard: .home, storyboardID: .EventBookingOrderSummaryVC) as? EventBookingOrderSummaryVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension EventBookingTicketAddOnsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataForAddOn.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddOnTableViewCell", for: indexPath) as! AddOnTableViewCell
        let data = dataForAddOn[indexPath.row]
        cell.lblTitle.text = data.addOnName
        if let ticketPrice = data.addOnTicketPrice {
            cell.lblPrice.text = "$ \(ticketPrice)"
        }
        cell.btnInfo.tag = indexPath.row
        cell.btnInfo.addTarget(self, action: #selector(btnInfo(sender:)), for: .touchUpInside)
        
        
        cell.btnDropDown.tag = indexPath.row
        cell.btnDropDown.addTarget(self, action: #selector(dropDownBtn), for: .touchUpInside)
        cell.toggle.tag = indexPath.row
        cell.toggle.addTarget(self, action: #selector(dropDownBtn23), for: .touchUpInside)
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
            
//            let view = self.createView(storyboard: .main, storyboardID: .VerifyPopupVC) as! VerifyPopupVC
//            view.strMsgForlbl = PEPSI
//            view.img = POP_ICON
//            view.strMessage = POP_DESCRIPTION
//            view.strMsgBtn = OKAY
//            view.closerForBack = { istrue in
//                if istrue ==  true
//                {
//                    print("cancel")
//                }
//            }
//            view.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
//            self.present(view, animated: true)
        } else {
            cell.bgTextView.isHidden = true
        }
    }
    
    @objc func btnInfo(sender: UIButton) {
        let view = self.createView(storyboard: .main, storyboardID: .VerifyPopupVC) as! VerifyPopupVC
        let data = dataForAddOn[sender.tag]
        if let name = data.addOnName {
            view.strMsgForlbl = name
        }
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
    }
 }

//MARK: - NavigationBarViewDelegate
extension EventBookingTicketAddOnsVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
