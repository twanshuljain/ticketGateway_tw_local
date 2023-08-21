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
// swiftlint: disable shorthand_operator

import UIKit
import iOSDropDown
import SVProgressHUD
class EventBookingTicketAddOnsVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblAddOn: UITableView!
    @IBOutlet weak var lblTotalTicketPrice :DropDown!
    @IBOutlet weak var parentView:UIView!
    
    // MARK: - Variables
   
    let viewModel = EventTiclketAddOnViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setup()
        self.callAddOnApi()
        
    }
}
// MARK: - Functions
extension EventBookingTicketAddOnsVC {
    func callAddOnApi() {
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getAddOnTicketList(complition: { isTrue, showMessage in
                if isTrue {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.tblAddOn.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: showMessage)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.parentView.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
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
        self.lblTotalTicketPrice.text = "CA$ \(self.viewModel.eventDetail?.event?.eventTicketFinalPrice ?? 0.0)"
    }
}

// MARK: - Actions
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
//        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingOrderSummaryVC) as? EventBookingOrderSummaryVC {
//            view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
//            view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList
//            view.viewModel.eventDetail = self.viewModel.eventDetail
//            view.viewModel.feeStructure = self.viewModel.feeStructure
//            view.viewModel.eventId = self.viewModel.eventId
//            self.navigationController?.pushViewController(view, animated: true)
//        }
        
        if let view = self.createView(storyboard: .home, storyboardID: .EventPromoCodeVC) as? EventPromoCodeVC {
            view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
            view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.feeStructure = self.viewModel.feeStructure
            view.viewModel.eventId = self.viewModel.eventId
            self.navigationController?.pushViewController(view, animated: true)
        }
        
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension EventBookingTicketAddOnsVC: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  addOnTableData.count
        return viewModel.arrAddOnTicketList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddOnTableViewCell", for: indexPath) as! AddOnTableViewCell
        //        let data = addOnTableData[indexPath.row]
        //        cell.imgImage.image = UIImage(named: data)
        let data = viewModel.arrAddOnTicketList?[indexPath.row]
        cell.lblTitle.text = data?.addOnName
        if let ticketPrice = data?.addOnTicketPrice {
            cell.lblPrice.text = "$\(ticketPrice)"
        }
        if let imgString = data?.addOnLogo?.first {
            let urlString = URL(string: imgString)
            cell.imgImage.sd_setImage(with: urlString)
        }
       
        
        
     //   cell.imgImage.image = data?.addOnLogo
        cell.btnInfo.tag = indexPath.row
        cell.btnInfo.addTarget(self, action: #selector(btnInfoAction(sender:)), for: .touchUpInside)
        cell.vwStepper.btnPlus.tag = indexPath.row
        cell.vwStepper.btnMinus.tag = indexPath.row
        cell.vwStepper.btnPlus.addTarget(self, action: #selector(PlusButtonPressed), for: .touchUpInside)
        cell.vwStepper.btnMinus.addTarget(self, action: #selector(MinustButtonPressed), for: .touchUpInside)
        return cell
    }
    
    @objc func PlusButtonPressed(_ sender: UIButton) {
       print(sender.tag)
        let data = viewModel.arrAddOnTicketList?[sender.tag]
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tblAddOn.cellForRow(at: indexPath) as! AddOnTableViewCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.viewModel.lblNumberOfCount = Int(value) ?? 0
        if viewModel.lblNumberOfCount < viewModel.arrAddOnTicketList?[sender.tag].addOnMaximumQuantity ?? 0 {
            self.viewModel.lblNumberOfCount = self.viewModel.lblNumberOfCount + 1
            self.viewModel.eventDetail?.event?.eventTicketFinalPrice += Double(data?.addOnTicketPrice ?? 0)
            //self.finalPrice += data?.ticketPrice ?? 0
            cell.vwStepper.lblCount.text = String(viewModel.lblNumberOfCount)
            self.viewModel.arrAddOnTicketList?[sender.tag].selectedTicketQuantity = viewModel.lblNumberOfCount
            self.viewModel.selectedAddOnList = self.viewModel.arrAddOnTicketList ?? [EventTicketAddOnResponseModel]()
//
            self.setData()
        }
    }
    
    @objc func MinustButtonPressed(_ sender: UIButton) {
        let data = viewModel.arrAddOnTicketList?[sender.tag]
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tblAddOn.cellForRow(at: indexPath) as! AddOnTableViewCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.viewModel.lblNumberOfCount = Int(value) ?? 0
        if self.viewModel.lblNumberOfCount > 0 {
            self.viewModel.lblNumberOfCount = self.viewModel.lblNumberOfCount - 1
         //   self.finalPrice -= data?.ticketPrice ?? 0
            self.viewModel.eventDetail?.event?.eventTicketFinalPrice -= Double(data?.addOnTicketPrice ?? 0)
            cell.vwStepper.lblCount.text = String(viewModel.lblNumberOfCount)
            self.viewModel.arrAddOnTicketList?[sender.tag].selectedTicketQuantity = viewModel.lblNumberOfCount
            self.viewModel.selectedAddOnList = self.viewModel.arrAddOnTicketList ?? [EventTicketAddOnResponseModel]()
            
          self.setData()
        } else {
            cell.vwStepper.lblCount.text = "0"
            self.viewModel.arrAddOnTicketList?[sender.tag].selectedTicketQuantity = 0
            self.viewModel.selectedAddOnList = self.viewModel.arrAddOnTicketList ?? [EventTicketAddOnResponseModel]()
        }
    }
    @objc func btnInfoAction(sender: UIButton){
        let data = viewModel.arrAddOnTicketList?[sender.tag]
        let view = self.createView(storyboard: .main, storyboardID: .VerifyPopupVC) as! VerifyPopupVC
        view.strMsgForlbl = data?.addOnName ?? ""
        view.img = POP_ICON
        view.strMessage = POP_DESCRIPTION
        view.strMsgBtn = OKAY
        view.closerForBack = { istrue in
            if istrue ==  true {
                print("cancel")
            }
        }
        view.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
        self.present(view, animated: true)
    }
    
    
    

  
}
// MARK: - NavigationBarViewDelegate
extension EventBookingTicketAddOnsVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigationRightButtonAction() {
        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingOrderSummaryVC) as? EventBookingOrderSummaryVC {
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.feeStructure = self.viewModel.feeStructure
            view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}
