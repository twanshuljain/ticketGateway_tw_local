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
    @IBOutlet weak var vwPopUp: CustomSocialLoginView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var lblPopYear: UILabel!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var parentView: UIView!

    // MARK: - Variables
    var viewModel: MyOrderViewModel = MyOrderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setFont()
        setUI()
        setNavigationView()
        setSearchBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.isFromUpcoming = true
        setButtonBackground()
        setButtonsTitle()
        resetPage()
        getMyOrderApiCall(isFromUpcoming: true, searchText: "")
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension MyOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrMyOrder.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as? UpcomingTableViewCell {
            if viewModel.arrMyOrder.indices.contains(indexPath.row) {
                cell.setData(getTicket: viewModel.arrMyOrder[indexPath.row], isFaded: viewModel.isFromUpcoming == true ? false : true)
            }
            return cell
        }
        return UITableViewCell.init()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            loadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.createView(storyboard: .order, storyboardID: .MyTicketVC) as? MyTicketVC
        if viewModel.arrMyOrder.indices.contains(indexPath.row) {
            viewController?.viewModel.ticketDetails = viewModel.arrMyOrder[indexPath.row]
        }
        viewController?.viewModel.isFromPast = viewModel.isFromUpcoming == true ? false : true
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}
// MARK: - Functions
extension MyOrderViewController {
    func getMyOrderApiCall(isFromUpcoming: Bool, isFromSearch: Bool = false, searchText: String = "") {
        if Reachability.isConnectedToNetwork() {
            if isFromSearch {
                viewModel.myOrdersModel.searchQuery = searchText
                viewModel.myOrdersModel.page = 1
            }
            viewModel.myOrdersModel.filterBy = isFromUpcoming ? "upcoming" : "past"
            parentView.showLoading(centreToView: self.view)
            viewModel.myOrdersApiCall(myOrdersModel: viewModel.myOrdersModel,
                                      isFromSearch: isFromSearch,
                                      completion: { isTrue, message in
                if isTrue {
                    if isFromUpcoming {
                        self.viewModel.upcomingCount = self.viewModel.arrMyOrder.count
                        self.btnUpcoming.setTitle("Upcoming (\(self.viewModel.upcomingCount))", for: .normal)
                        self.pastView.isHidden = self.viewModel.arrMyOrder.isEmpty ? false : true
                    } else {
                        self.viewModel.pastCount = self.viewModel.arrMyOrder.count
                        self.btnPast.setTitle("Past (\(self.viewModel.pastCount))", for: .normal)
                        self.pastView.isHidden = self.viewModel.arrMyOrder.isEmpty ? false : true
                    }
                    self.upComingTableView.reloadData()
                    self.parentView.stopLoading()
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: message)
                        self.upComingTableView.reloadData()
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
    func setNavigationView() {
        vwNavigationBar.lblTitle.text = MY_ORDERS
        vwNavigationBar.imgBack.image = UIImage(named: MENU_ICON)
        vwNavigationBar.btnBack.isHidden = false
        vwNavigationBar.delegateBarAction = self
    }

    func resetPage() {
        viewModel.myOrdersModel.page = 1
        viewModel.arrMyOrder.removeAll()
        txtSearch.text = ""
    }
    @objc func searchBarAction(_ sender: UITextField) {
        let text = sender.text?.trimmingCharacters(in: .whitespaces)
        if !(text?.isEmpty ?? false) {
            getMyOrderApiCall(isFromUpcoming: viewModel.isFromUpcoming,
                              isFromSearch: true,
                              searchText: text ?? "-")
        }
    }
    func setSearchBar() {
        txtSearch.delegate = self
        txtSearch.autocorrectionType = .no
        txtSearch.spellCheckingType = .no
        txtSearch.autocapitalizationType = .none
        txtSearch.addTarget(self, action: #selector(searchBarAction(_:)), for: .allEditingEvents)
    }
    func setTableView() {
        upComingTableView.separatorColor = .clear
        upComingTableView.delegate = self
        upComingTableView.dataSource = self
        upComingTableView.register(UINib(nibName: "UpcomingTableViewCell", bundle: nil), forCellReuseIdentifier: "UpcomingTableViewCell")
    }
    func setButtonBackground() {
        if viewModel.isFromUpcoming {
            btnUpcoming.setTitleColor(UIColor.init(named: "white"), for: .normal)
            btnPast.setTitleColor(UIColor.init(named: "TGBlack"), for: .normal)
            btnUpcoming.backgroundColor = UIColor.init(named: "TGBlack")
            btnPast.backgroundColor = UIColor.init(named: "white")
        } else {
            btnPast.setTitleColor(UIColor.init(named: "white"), for: .normal)
            btnUpcoming.setTitleColor(UIColor.init(named: "TGBlack"), for: .normal)
            btnPast.backgroundColor = UIColor.init(named: "TGBlack")
            btnUpcoming.backgroundColor = UIColor.init(named: "white")
        }
    }
    func setButtonsTitle() {
        self.btnUpcoming.setTitle("Upcoming", for: .normal)
        self.btnPast.setTitle("Past", for: .normal)
        viewModel.arrMyOrder.removeAll()
    }
    func setFont() {
        segmentBgView.addBottomShadow()
        vwPopUp.isHidden = true
        lblYear.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        lblYear.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblYear.isHidden = true
        btnUpcoming.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnPast.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        lblNoTicket.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        lblNoTicket.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        lblLookForSomething.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblLookForSomething.textColor = UIColor.setColor(colorType: .lblTextPara)
        btnBrowseEvents.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnBrowseEvents.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        lblStillHavingTrouble.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblStillHavingTrouble.textColor = UIColor.setColor(colorType: .lblTextPara)
        btnVisitHelpCenter.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnVisitHelpCenter.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        btnFilter.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        btnFilter.titleLabel?.textColor = UIColor.setColor(colorType: .lblTextPara)
        btnFilter.addLeftIcon(image: UIImage(named: FILTER))
        lblMonth.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblMonth.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblPopYear.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblPopYear.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblDate.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    func setUI () {
        [btnPast,btnUpcoming,btnFilter,btnBrowseEvents].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }
}
// MARK: - Actions
extension MyOrderViewController {
    @IBAction private func actionSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            print("TICKETS")
        case 1:
            let vc = self.createView(storyboard: .order, storyboardID: .SegmentCostumeVC)
            segmentControl.selectedSegmentIndex = 0
            navigationController?.pushViewController(vc, animated: false)
        default:
            break
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnUpcoming:
            upcomingAction()
        case btnPast:
            pastAction()
        case btnFilter:
            filterAction()
        case btnBrowseEvents:
            browseEventsAction()
        default:
            break
        }
    }
    func upcomingAction() {
        viewModel.myOrdersModel.searchQuery = ""
        txtSearch.text = ""
        viewModel.isFromUpcoming = true
        setButtonBackground()
        //pastView.isHidden = true
        viewModel.arrMyOrder.removeAll()
        viewModel.myOrdersModel.page = 1
        getMyOrderApiCall(isFromUpcoming: true)
    }
    func pastAction() {
        viewModel.myOrdersModel.searchQuery = ""
        txtSearch.text = ""
        viewModel.isFromUpcoming = false
        setButtonBackground()
        viewModel.arrMyOrder.removeAll()
        viewModel.myOrdersModel.page = 1
        getMyOrderApiCall(isFromUpcoming: false)
    }

    func browseEventsAction() {
        self.tabBarController?.selectedIndex = 0
    }

    func filterAction() {
        vwPopUp.isHidden = !vwPopUp.isHidden
    }
    func loadData() {
        viewModel.myOrdersModel.page += 1
        if viewModel.arrMyOrder.count != viewModel.totalCount {
            print("viewModel.totalCount", viewModel.totalCount)
            print("load more data")
            getMyOrderApiCall(isFromUpcoming: viewModel.isFromUpcoming)
        }
    }
}

// MARK: - NavigationBarViewDelegate
extension MyOrderViewController: NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}
extension MyOrderViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the current text in the text field
        guard let currentText = textField.text else {
            return true
        }
        // When last character remove from search bar API should call Past Data should show.
        if currentText.count == 1 && string == "" {
            print("last character removed")
            getMyOrderApiCall(isFromUpcoming: viewModel.isFromUpcoming,
                              isFromSearch: true)
        }
        return true
    }
}
