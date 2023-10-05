//
//  CancelThisEventVC.swift
//  TicketGateway
//
//  Created by Apple on 03/07/23.

import UIKit

class CancelThisEventVC: UIViewController {

// MARK: - Outlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var lblCancelThisevent: UILabel!
    @IBOutlet weak var cancelEventTableViewCell: UITableView!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!

// MARK: - Variables
    let viewModel = CancelThisEventViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setTableView()
        self.setFont()
        self.setUI()

    }

}

// MARK: - FUNCTIONS
extension CancelThisEventVC {

    func setNavigationBar() {
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.imgBack.isHidden = false
        self.vwNavigationView.lblDiscripation.isHidden = false
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.lblTitle.text = HEADER_TITLE_SUNBURN
        self.vwNavigationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
        self.vwNavigationView.vwBorder.isHidden = false

    }

    func setTableView() {
        cancelEventTableViewCell.separatorColor = UIColor.clear
        cancelEventTableViewCell.delegate = self
        cancelEventTableViewCell.dataSource = self
        cancelEventTableViewCell.register(UINib(nibName: "CancelEventTableViewCell", bundle: nil), forCellReuseIdentifier:  "CancelEventTableViewCell")
    }

    func setFont() {
        lblCancelThisevent.font = UIFont.setFont(fontType: .semiBold, fontSize: .eighteen)
        btnContinue.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize:  .fourteen)
        btnContinue.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
    }

    @objc func actionBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CancelThisEventVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CancelEventTableViewCell", for:  indexPath) as! CancelEventTableViewCell
        let data = viewModel.arrData[indexPath.row]
        cell.lblTitle.text = data
            cell.btnSelect.setImage(UIImage(named: RADIO_SELECTION_ICON), for: .selected)
            cell.btnSelect.setImage(UIImage(named: FILTER_RADIO_INACTIVE), for: .normal)
        cell.btnSelect.addTarget(self, action: #selector(actionBtn(_ :)), for: .touchUpInside)
        return cell

    }

}

// MARK: - Actions
extension CancelThisEventVC {
    func setUI () {
        [self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }

    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }

    func btnContinueAction() {
        let vc = self.createView(storyboard: .scanevent, storyboardID: .EndScanPoPUpVC) as! EndScanPoPUpVC
        vc.delegate = self
        vc.strMsgForTitle = CANCEL_EVENT
        vc.strMsgForDescription = ARE_YOU_SURE_CANCEL_EVENT
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
        self.present(vc, animated: true)

    }

}
// MARK: - NavigationBarViewDelegate
extension CancelThisEventVC: AlertAction {
    func alertYesaction() {
//        let vc = self.createView(storyboard: .scanevent, storyboardID: .EndScanPoPUpVC) as! EndScanPoPUpVC
//        vc.delegate = self
//        vc.strMsgForTitle = "Order Refunded?"
//        vc.strMsgForDescription = "Are you sure your all orders are refunded?"
//        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
//        self.present(vc, animated: true)

    }

}

// MARK: - NavigationBarViewDelegate
extension CancelThisEventVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }

}
