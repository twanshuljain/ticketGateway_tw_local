//
//  MyOrderViewController.swift
//  TicketGateway
//
//  Created by Dr.Mac on 15/05/23.
// swiftlint: disable force_cast
// swiftlint: disable line_length
import UIKit
import SideMenu

class MyOrderViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var upComingTableView: UITableView!
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    @IBOutlet weak var segmentBgView: UIView!
    @IBOutlet weak var btnUpcoming: UIButton!
    @IBOutlet weak var btnPast: UIButton!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var pastView: UIView!
    @IBOutlet weak var lblNoTicket: UILabel!
    @IBOutlet weak var lblLookForSomething: UILabel!
    @IBOutlet weak var btnBrowseEvents: UIButton!
    @IBOutlet weak var lblStillHavingTrouble: UILabel!
    @IBOutlet weak var btnVisitHelpCenter: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnFilter: CustomButtonNormal!
    @IBOutlet weak var vwBgSearchView: UIView!
    @IBOutlet weak var vwPopUp: customSocialLoginView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var lblPopYear: UILabel!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnDate: UIButton!
    // MARK: - Variables
    let tbleData = ["Upcoming_ip", "Upcoming_ip"]
    let myOrderTableData = ["costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip"]
    var isFromUpcoming : Bool = false
    var viewModel: MyOrderViewModel = MyOrderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setFont()
        self.setUI()
        self.isFromUpcoming = true
        self.setNavigationView()
        self.setButtonBackground()
    }
    override func viewWillAppear(_ animated: Bool) {
        getMyOrderApiCall(isFromUpcoming: true)
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension MyOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myOrder.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! UpcomingTableViewCell
        cell.getTicket = viewModel.myOrder[indexPath.row]
        return cell
    }
}
// MARK: - Functions
extension MyOrderViewController {
    func getMyOrderApiCall(isFromUpcoming: Bool) {
        viewModel.myOrdersModel.filterBy = isFromUpcoming ? "upcoming" : "past"
        viewModel.myOrdersApiCall(myOrdersModel: viewModel.myOrdersModel,
                                  completion: { isTrue, message in
            if isTrue {
                self.upComingTableView.reloadData()
            } else {
                DispatchQueue.main.async {
//                    self.parentView.stopLoading()
                    self.showToast(message: message)
                }
            }
        })
    }
    func setNavigationView() {
        self.vwNavigationBar.lblTitle.text = MY_ORDERS
        self.vwNavigationBar.imgBack.image = UIImage(named: MENU_ICON)
        self.vwNavigationBar.btnBack.isHidden = false
        self.vwNavigationBar.delegateBarAction = self
    }
    func setTableView() {
        self.upComingTableView.separatorColor = .clear
        upComingTableView.delegate = self
        upComingTableView.dataSource = self
        upComingTableView.register(UINib(nibName: "UpcomingTableViewCell", bundle: nil), forCellReuseIdentifier: "UpcomingTableViewCell")
    }
    func setButtonBackground() {
        if isFromUpcoming == true {
            self.btnUpcoming.setTitleColor(UIColor.init(named: "white"), for: .normal)
            self.btnPast.setTitleColor(UIColor.init(named: "TGBlack"), for: .normal)
            self.btnUpcoming.backgroundColor = UIColor.init(named: "TGBlack")
            self.btnPast.backgroundColor = UIColor.init(named: "white")
        } else {
            self.btnPast.setTitleColor(UIColor.init(named: "white"), for: .normal)
            self.btnUpcoming.setTitleColor(UIColor.init(named: "TGBlack"), for: .normal)
            self.btnPast.backgroundColor = UIColor.init(named: "TGBlack")
            self.btnUpcoming.backgroundColor = UIColor.init(named: "white")
        }
    }
    func setFont() {
        self.segmentBgView.addBottomShadow()
        self.vwPopUp.isHidden = true
        self.lblYear.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblYear.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnUpcoming.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnPast.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblNoTicket.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblNoTicket.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblLookForSomething.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblLookForSomething.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnBrowseEvents.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnBrowseEvents.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblStillHavingTrouble.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblStillHavingTrouble.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnVisitHelpCenter.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnVisitHelpCenter.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnFilter.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.btnFilter.titleLabel?.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnFilter.addLeftIcon(image: UIImage(named: FILTER))
        self.lblMonth.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblMonth.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblPopYear.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblPopYear.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    func setUI () {
        [btnPast,btnUpcoming,btnFilter].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }
}
//MARK: - Actions
extension MyOrderViewController {
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            print("TICKETS")
        case 1:
            let vc = self.createView(storyboard: .order, storyboardID: .SegmentCostumeVC)
            self.segmentControl.selectedSegmentIndex = 0
            self.navigationController?.pushViewController(vc, animated: false)
        default:
            break
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnUpcoming:
            self.upcomingAction()
        case btnPast:
            self.pastAction()
        case btnFilter:
            self.filterAction()
        default:
            break
        }
    }
    func upcomingAction() {
        self.isFromUpcoming = true
        self.setButtonBackground()
        self.pastView.isHidden = true
        getMyOrderApiCall(isFromUpcoming: true)
    }
    func pastAction() {
        self.isFromUpcoming = false
        self.setButtonBackground()
        getMyOrderApiCall(isFromUpcoming: false)
//        self.pastView.isHidden = false
    }
    func filterAction() {
        vwPopUp.isHidden = !vwPopUp.isHidden
    }
}

//MARK: - NavigationBarViewDelegate
extension MyOrderViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}
