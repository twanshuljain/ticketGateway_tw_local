//
//  SelectTicketTypeVC.swift
//  TicketGateway
//
//  Created by Apple on 16/06/23.
// swiftlint: disable force_cast
// swiftlint: disable line_length
import UIKit
class SelectTicketTypeVC: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var tblTicketTypeTablView: UITableView!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var btnDone: CustomButtonGradiant!
// MARK: - Variable
    let viewModel = SelectTicketTypeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationview()
        self.setTableView()
        self.setFont()
        self.setUI()

    }
}

// MARK: -
extension SelectTicketTypeVC {
    func setNavigationview() {
        vwNavigationView.delegateBarAction = self
        vwNavigationView.btnBack.isHidden = false
        vwNavigationView.lblTitle.text = SELECT_TICKET_TYPE
        vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        vwNavigationView.vwBorder.isHidden = false
    }
    func setTableView() {
        viewModel.arrTicketTypeList = viewModel.getScanTicketDetails.availableTicketList
        tblTicketTypeTablView.delegate = self
        tblTicketTypeTablView.dataSource = self
    }
    func setFont() {
        btnSelectAll.titleLabel?.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        btnSelectAll.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        btnDone.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnDone.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension SelectTicketTypeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrTicketTypeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectTicketTypeTableviewCell", for: indexPath) as! SelectTicketTypeTableviewCell
        let data = viewModel.arrTicketTypeList[indexPath.row]
        cell.lblTicketType.text = data
        if viewModel.isSelectAll {
            cell.selectAllSwitchOn()
        }
        cell.switchButtonDidTap = { sender in
            self.viewModel.isSelectAll = false
            if sender.isOn {
                self.viewModel.arrSelectedTicketTypeList.append(self.viewModel.arrTicketTypeList[indexPath.row])
            } else {
                self.viewModel.arrSelectedTicketTypeList.removeAll { str in
                    return str == self.viewModel.arrTicketTypeList[indexPath.row]
                }
            }
        }
        return cell
    }
}
// MARK: -
extension SelectTicketTypeVC {
    func setUI() {
        [self.btnDone, self.btnSelectAll].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnDone:
            self.btnDoneAction()
        case btnSelectAll:
            self.btnSelectAllAction()
        default:
            break
        }
    }
    func btnDoneAction() {
        guard !viewModel.arrSelectedTicketTypeList.isEmpty else {
            showAlertController(title: "Alert", message: SelectTicketMessage)
            return
        }
        print("selected Items:- ", viewModel.arrSelectedTicketTypeList)
        viewModel.getScanTicketDetails.selectedTicketType = viewModel.arrSelectedTicketTypeList
        let scannerVC = createView(storyboard: .scanevent, storyboardID: .ScannerVC) as? ScannerVC
        scannerVC?.viewModel.getScanTicketDetails = viewModel.getScanTicketDetails
        self.navigationController?.pushViewController(scannerVC ?? UIViewController(), animated: true)
    }
    func btnSelectAllAction() {
        viewModel.isSelectAll = true
        viewModel.arrSelectedTicketTypeList = viewModel.arrTicketTypeList
        tblTicketTypeTablView.reloadData()
    }
}
// MARK: - NavigationBarViewDelegate
extension SelectTicketTypeVC: NavigationBarViewDelegate {
    func navigationBackAction() {
     self.navigationController?.popViewController(animated: false)
    }
}
