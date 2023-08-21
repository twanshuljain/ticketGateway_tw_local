//
//  EventPromoCodeVC.swift
//  TicketGateway
//
//  Created by Apple on 26/07/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name
import UIKit
class EventPromoCodeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var vwApplyPromoCode: UIView!
    @IBOutlet weak var lblPromoCode: UILabel!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var lblApplyPromoCode: UILabel!
    @IBOutlet weak var txtPromoCode: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var promoCodeTableView: UITableView!
    @IBOutlet weak var vwPromoCodeAppliedView: UIView!
    @IBOutlet weak var lblPromoCodeApplied: UILabel!
    @IBOutlet weak var lblPromoCodeAppliedDescription: UILabel!
    // MARK: - Variables
    var viewModel = EventPromoCodeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setUI()
        self.setUpTableView()
    }
}
// MARK: - FUNCTIONS
extension EventPromoCodeVC {
    func setUpTableView() {
//        self.promoCodeTableView.register(UINib(nibName: "TicketTypesCell", bundle: nil), forCellReuseIdentifier: "TicketTypesCell")
//        self.promoCodeTableView.delegate = self
//        self.promoCodeTableView.dataSource = self
//        self.promoCodeTableView.reloadData()
    }
    
    func setFont() {
        if viewModel.isPromoCodeApplied {
            vwPromoCodeAppliedView.isHidden = false
            vwApplyPromoCode.isHidden = true
            btnSkip.isHidden = true
        } else  {
            vwPromoCodeAppliedView.isHidden = true
            vwApplyPromoCode.isHidden = false
        }
        
        self.lblPromoCode.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblPromoCode.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblApplyPromoCode.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblApplyPromoCode.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnApply.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnApply.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        self.btnSkip.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSkip.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        self.btnContinue.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .seventeen)
        self.btnContinue.titleLabel?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        self.lblPromoCodeApplied.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFour)
        self.lblPromoCodeApplied.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblPromoCodeAppliedDescription.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblPromoCodeAppliedDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
}

// MARK: - Instance Method
extension EventPromoCodeVC {
    func setUI() {
        [self.btnDismiss, self.btnApply, self.btnSkip, self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnDismiss:
            self.btnDismissAction()
        case btnApply:
            self.btnApplyAction()
        case btnSkip:
            self.btnSkipAction()
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
    func btnDismissAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func btnApplyAction() {
    }
    func btnSkipAction() {
        //        let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketAddOnsVC) as? EventBookingTicketAddOnsVC
        //        view?.viewModel.eventDetail = self.viewModel.eventDetail
        //        view?.viewModel.feeStructure = self.viewModel.feeStructure
        //        view?.viewModel.selectedArrTicketList = viewModel.selectedArrTicketList
        //        view?.viewModel.eventId = self.viewModel.eventId
        //        self.navigationController?.pushViewController(view!, animated: true)
        
        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingOrderSummaryVC) as? EventBookingOrderSummaryVC {
            view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
            view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.feeStructure = self.viewModel.feeStructure
            view.viewModel.eventId = self.viewModel.eventId
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    func btnContinueAction() {
        //        let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketAddOnsVC) as? EventBookingTicketAddOnsVC
        //        view?.viewModel.eventDetail = self.viewModel.eventDetail
        //        view?.viewModel.feeStructure = self.viewModel.feeStructure
        //        view?.viewModel.selectedArrTicketList = viewModel.selectedArrTicketList
        //        view?.viewModel.eventId = self.viewModel.eventId
        //        self.navigationController?.pushViewController(view!, animated: true)
        
        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingOrderSummaryVC) as? EventBookingOrderSummaryVC {
            view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
            view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.feeStructure = self.viewModel.feeStructure
            view.viewModel.eventId = self.viewModel.eventId
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}
// MARK: - TableView Delegate
extension EventPromoCodeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.selectedArrTicketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTypesCell") as! TicketTypesCell
        cell.selectionStyle = .none
        if viewModel.selectedArrTicketList.indices.contains(indexPath.row){
            cell.setData(event: viewModel.selectedArrTicketList[indexPath.row])
        }
        
        
        
        //        if  self.selectedArrTicketList.indices.contains(indexPath.row){
        //            cell.setSelectedTicketData(selectedTicket: selectedArrTicketList[indexPath.row])
        //        }
        
        cell.vwStepper.btnPlus.tag = indexPath.row
        cell.vwStepper.btnMinus.tag = indexPath.row
        cell.vwStepper.btnPlus.addTarget(self, action: #selector(PlusButtonPressed), for: .touchUpInside)
        cell.vwStepper.btnMinus.addTarget(self, action: #selector(MinustButtonPressed), for: .touchUpInside)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTypesCell") as! TicketTypesCell
        //         self.tableDidSelectAtIndex?(indexPath.row)
        //         self.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("in \(indexPath.row)")
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
    }
    
    // MARK: - ONLINE
    @objc func PlusButtonPressed(_ sender: UIButton) {
        let data = viewModel.selectedArrTicketList[sender.tag]
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.promoCodeTableView.cellForRow(at: indexPath) as! TicketTypesCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.viewModel.lblNumberOfCount = Int(value) ?? 0
        if viewModel.lblNumberOfCount < viewModel.selectedArrTicketList[sender.tag].ticketMaximumQuantity ?? 0 {
            self.viewModel.lblNumberOfCount = self.viewModel.lblNumberOfCount + 1
            self.viewModel.finalPrice += Double(data.ticketPrice ?? 0)
            cell.vwStepper.lblCount.text = String(viewModel.lblNumberOfCount)
            viewModel.selectedArrTicketList[sender.tag].selectedTicketQuantity = viewModel.lblNumberOfCount
            self.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
            
            //self.updatedPrice?(viewModel.finalPrice)
            
            print("FINAL_PRICE:-",viewModel.finalPrice)
        }
        
    }
    
    @objc func MinustButtonPressed(_ sender: UIButton) {
        let data = viewModel.selectedArrTicketList[sender.tag]
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.promoCodeTableView.cellForRow(at: indexPath) as! TicketTypesCell
        let value =  cell.vwStepper.lblCount.text ?? ""
        self.viewModel.lblNumberOfCount = Int(value) ?? 0
        if self.viewModel.lblNumberOfCount > 0 {
            self.viewModel.lblNumberOfCount = self.viewModel.lblNumberOfCount - 1
            self.viewModel.finalPrice -= Double(data.ticketPrice ?? 0)
            cell.vwStepper.lblCount.text = String(viewModel.lblNumberOfCount)
            viewModel.selectedArrTicketList[sender.tag].selectedTicketQuantity = viewModel.lblNumberOfCount
            self.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
//            self.updatedPrice?(viewModel.finalPrice)
            print("FINAL_PRICE:-",viewModel.finalPrice)
        } else {
            cell.vwStepper.lblCount.text = "0"
            viewModel.selectedArrTicketList[sender.tag].selectedTicketQuantity = 0
            self.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
            print("FINAL_PRICE:-",viewModel.finalPrice)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
