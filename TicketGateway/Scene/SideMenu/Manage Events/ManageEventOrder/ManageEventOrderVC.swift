//
// ManageEventOrderVC.swift
// TicketGateway
//
// Created by Dr.Mac on 23/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name
import UIKit
import SideMenu
class ExpandableName {
    var isExpanded : Bool
    init(isExpanded: Bool) {
        self.isExpanded = isExpanded
    }
}
class ManageEventOrderVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    @IBOutlet weak var OrderTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var BgNoOrderView: UIView!
    @IBOutlet weak var lblSorry: UILabel!
    @IBOutlet weak var lblYourSearch: UILabel!
    @IBOutlet weak var btnScan: UIButton!
    //MARK: - Variables
    var viewModel = ManageEventOrderViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setNavigationBar()
        self.setFont()
        self.setUI()
    }
}
//MARK: - Functions
extension ManageEventOrderVC{
    func setNavigationBar() {
        self.vwNavigationBar.delegateBarAction = self
        self.vwNavigationBar.btnBack.isHidden = false
        self.vwNavigationBar.lblTitle.text = HEADER_TITLE_SUNBURN
        self.vwNavigationBar.lblDiscripation.isHidden = false
        self.vwNavigationBar.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationBar.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.vwNavigationBar.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
        self.vwNavigationBar.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.vwNavigationBar.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.vwNavigationBar.imgBack.image = UIImage(named: MENU_ICON)
    }
    func setTableView() {
        self.OrderTableView.delegate = self
        self.OrderTableView.dataSource = self
        self.OrderTableView.separatorColor = UIColor.clear
        self.OrderTableView.register(UINib(nibName: "ManageOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ManageOrderTableViewCell")
        self.OrderTableView.register(UINib(nibName: "RefundRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "RefundRequestTableViewCell")
        self.OrderTableView.register(UINib(nibName: "RequestRefundHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RequestRefundHeaderView")
    }
    func setFont() {
        self.lblSorry.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblSorry.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblYourSearch.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblYourSearch.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
}
//MARK: - Button Actions
extension ManageEventOrderVC {
    func setUI () {
        [btnScan].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnScan:
            self.btnScanAction()
        default:
            break
        }
    }
    func btnScanAction() {
        let vc = createView(storyboard: .manageevent, storyboardID: .ScanQRVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Segment Actions
extension ManageEventOrderVC{
    @objc func nextBtn(sender: UIButton){
        var obj = viewModel.arrData[sender.tag]
        print(viewModel.arrData[sender.tag])
        if obj.isExpanded == false
        {
            obj.isExpanded = true
        } else {
            obj.isExpanded = false
        }
        print("value",viewModel.arrData)
        self.OrderTableView.reloadData()
    }
    @IBAction func actionSegmentControl(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            viewModel.isRefundRequest = false
            self.OrderTableView.reloadData()
        case 1:
            viewModel.isRefundRequest = true
            self.OrderTableView.reloadData()
        default:
            break
        }
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ManageEventOrderVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int{
        if viewModel.isRefundRequest == true{
            return viewModel.arrData.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !viewModel.isRefundRequest {
            return viewModel.orderTableData.count
        } else {
            if viewModel.arrData[section].isExpanded == true{
                return 1
            } else {
                return 0
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.isRefundRequest {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManageOrderTableViewCell", for: indexPath) as! ManageOrderTableViewCell
            let data = viewModel.orderTableData[indexPath.row]
            cell.lblName.text = data
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RefundRequestTableViewCell", for: indexPath) as! RefundRequestTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RequestRefundHeaderView") as! RequestRefundHeaderView
        headerView.contentView.backgroundColor = UIColor.white
        headerView.btnChevron.tag = section
        headerView.btnChevron.addTarget(self, action: #selector(nextBtn(sender:)), for: .touchUpInside)
        let obj = viewModel.arrData[section]
        if obj.isExpanded == true {
            headerView.btnChevron.setImage(UIImage(named: CIRCLE_CHEVRON_UP_ICON), for: .normal)
            headerView.vwLineView.isHidden = true
        }else {
            headerView.btnChevron.setImage(UIImage(named: CIRCLE_CHEVRON_DOWN_ICON), for: .normal)
            headerView.vwLineView.isHidden = false
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.isRefundRequest ? 50 : 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = createView(storyboard: .manageventorder, storyboardID: .ManageEventOrderDeatilVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - NavigationBarViewDelegate
extension ManageEventOrderVC : NavigationBarViewDelegate{
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}
