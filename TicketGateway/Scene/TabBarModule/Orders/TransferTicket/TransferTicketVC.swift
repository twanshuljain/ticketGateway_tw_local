//
//  TransferTicketVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 31/05/23.

import UIKit
class ExpandableTicketCell {
    var isExpanded: Bool
    init(isExpanded: Bool) {
        self.isExpanded = isExpanded
    }
}

class TransferTicketVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var tblTransferTicketTableView: UITableView!
    // MARK: - Variables
    var viewModel = TransferTicketViewModel()
    var transferViewModel = ContinueToTransferViewModel()
    //var arrData = [ExpandableTicketCell(isExpanded: false), ExpandableTicketCell(isExpanded: false), ExpandableTicketCell(isExpanded: false), ExpandableTicketCell(isExpanded: false)]
   // let tblData = ["334566", "565656", "56656456", "5645645" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setNavigationView()
    }
}
// MARK: - Functions
extension  TransferTicketVC {
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = TRANSFER_TICKETS
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.vwNavigationView.lblDiscripation.isHidden = false
        self.vwNavigationView.lblDiscripation.text = NUMBERS
        self.vwNavigationView.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.vwNavigationView.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    func setTableView() {
        self.tblTransferTicketTableView.separatorColor = .clear
        self.tblTransferTicketTableView.delegate = self
        self.tblTransferTicketTableView.dataSource = self
        self.tblTransferTicketTableView.register(UINib(nibName: "TransferTicketTableViewCell", bundle: nil), forCellReuseIdentifier: "TransferTicketTableViewCell")
        self.tblTransferTicketTableView.register(UINib(nibName: "TransferTicketHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "TransferTicketHeaderView")
    }

    func resendTicket(transferId: Int?) {
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            self.view.showLoading(centreToView: self.view)
            transferViewModel.reSendTransferTicket(transferId: transferId, complition: { isTrue, messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: "\(Ticket_Resend_Success + " " + (self.transferViewModel.ticketTransfer?.transferredTo ?? ""))")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }

    @objc func navigateButton(_ sender: UIButton) {
        if let data = self.viewModel.myTicket?.items?[sender.tag]{
            if data.isTransfer ?? false{
                self.resendTicket(transferId: data.transferredID ?? 0)
            } else {
                if let continueToTransferVC = createView(storyboard: .order, storyboardID: .ContinueToTransferVC) as? ContinueToTransferVC{
                    continueToTransferVC.viewModel.ticketDetails = self.viewModel.ticketDetails
                    continueToTransferVC.viewModel.eventDetail = self.viewModel.eventDetail
                    continueToTransferVC.viewModel.myTicket = self.viewModel.myTicket?.items?[sender.tag]
                    self.navigationController?.pushViewController(continueToTransferVC, animated: true)
                }
            }
        }
    }
}
// MARK: - Actions
extension  TransferTicketVC {
    @objc func buttonPressed(_ sender: UIButton) {
        if self.viewModel.myTicket?.items?[sender.tag].isExpanded == false {
            self.viewModel.myTicket?.items?[sender.tag].isExpanded = true
        } else {
            self.viewModel.myTicket?.items?[sender.tag].isExpanded = false
        }
        self.tblTransferTicketTableView.reloadData()
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension TransferTicketVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.myTicket?.items?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.myTicket?.items?[section].isExpanded == true {
            return 1
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TransferTicketTableViewCell", for: indexPath) as? TransferTicketTableViewCell{
            if self.viewModel.myTicket?.items?.indices.contains(indexPath.section) ?? false{
                if let data = self.viewModel.myTicket?.items?[indexPath.section]{
                    cell.btnContinueToTransfer.tag = indexPath.section
                    cell.setData(data: data)
                    cell.btnContinueToTransfer.addTarget(self, action: #selector(navigateButton(_:)), for: .touchUpInside)
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TransferTicketHeaderView") as? TransferTicketHeaderView{
            headerview.btnUp.tag = section
            headerview.btnUp.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            if self.viewModel.myTicket?.items?.indices.contains(section) ?? false{
                if let obj = self.viewModel.myTicket?.items?[section]{
                    headerview.setData(data: obj)
                    if obj.isExpanded == true {
                        headerview.btnUp.setImage(UIImage(named: CIRCLE_CHEVRON_UP_ICON), for: .normal)
                        headerview.headerBottomLine.isHidden = true
                    } else {
                        headerview.btnUp.setImage(UIImage(named: CIRCLE_CHEVRON_DOWN_ICON), for: .normal)
                        headerview.headerBottomLine.isHidden = false
                    }
                    return headerview
                }
            }
        }
        return nil

    }
}
// MARK: - NavigationBarViewDelegate
extension TransferTicketVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
}
