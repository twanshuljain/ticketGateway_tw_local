//
//  ViewMoreEventsVC.swift
//  TicketGateway
//
//  Created by Apple on 12/07/23.
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
import SVProgressHUD

class ViewMoreEventsVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var navigationView: NavigationBarView!
    
   
    var viewModel = ViewMoreEventsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        //self.viewModel.refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        //tblView.refreshControl = self.viewModel.refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setData()
    }

}
//MARK: - Functions
extension ViewMoreEventsVC{
    func setUp() {
        self.tblView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        self.navigationView.delegateBarAction = self
        self.navigationView.btnBack.isHidden = false
        self.navigationView.btnSecRight.isHidden = true
        self.navigationView.lblSeprator.isHidden = true
        self.navigationView.vwBorder.isHidden = true
        self.setNavigationView()
    }
    
    func setNavigationView() {
        self.vwSearchBar.delegate = self
        self.vwSearchBar.txtSearch.delegate = self
        self.vwSearchBar.btnMenu.isHidden = true
        self.vwSearchBar.vwLocation.isHidden = true
    }
    
    func setData(){
        switch self.viewModel.arrEventCategory[self.viewModel.index] {
        case .nearByLocation:
            navigationView.lblTitle.text = "Events near Toronto"
            //self.funcCallApi()
        case .weekend:
            navigationView.lblTitle.text = "This Weekend"
            self.funcCallApi()
        case .online:
            navigationView.lblTitle.text = "Online Events"
            self.funcCallApiForOnlineEvents()
        case .popular:
            navigationView.lblTitle.text = "Popular Events"
            self.funcCallApiForPopularEvents()
        case .free:
            navigationView.lblTitle.text = "Free Events"
           self.funcCallApiForFreeEvents()
        case .upcoming:
            navigationView.lblTitle.text = "Upcoming Events"
            self.funcCallApiForUpcomingEvents()
        default:
            break;
        }
    }
    
    
    func funcCallApiForLocation(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.getEventApiForWeekendEvents(viewAll:true,complition: { isTrue, messageShowToast in
                
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    if let itemWeekend = self.viewModel.arrData?.itemsWeekend{
                        DispatchQueue.main.async {
                            self.tblView.reloadData()
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
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
    
    
    func funcCallApi(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.getEventApiForWeekendEvents(viewAll:true,complition: { isTrue, messageShowToast in
                
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    if let itemWeekend = self.viewModel.arrData?.itemsWeekend{
                        DispatchQueue.main.async {
                            self.tblView.reloadData()
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
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
    
    func funcCallApiForOnlineEvents(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.getEventApiForOnlineEvents(viewAll:true,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    if let itemsVirtual = self.viewModel.arrData?.itemsVirtual{
                        DispatchQueue.main.async {
                            self.tblView.reloadData()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
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


    func funcCallApiForPopularEvents(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.getEventApiForPopularEvents(viewAll:true,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    if let itemsPopular = self.viewModel.arrData?.itemsPopular{
                        DispatchQueue.main.async {
                            self.tblView.reloadData()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
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


    func funcCallApiForFreeEvents(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.getEventApiForFreeEvents(viewAll:true,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    if let itemsFree = self.viewModel.arrData?.itemsFree{
                        DispatchQueue.main.async {
                            self.tblView.reloadData()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
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

    func funcCallApiForUpcomingEvents(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.getEventApiForUpcomingEvents(viewAll:true,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                        if let itemsUpcoming = self.viewModel.arrData?.itemsUpcoming{
                            DispatchQueue.main.async {
                                self.tblView.reloadData()
                            }
                        }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
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
    
    @objc func loadData() {
        // Make network call to fetch data for currentPage
        self.viewModel.currentPage += 1
        viewModel.refreshControl.endRefreshing()
        
        switch self.viewModel.arrEventCategory[self.viewModel.index] {
        case .weekend:
            self.funcCallApi()
        case .online:
            self.funcCallApiForOnlineEvents()
        case .popular:
            self.funcCallApiForPopularEvents()
        case .free:
           self.funcCallApiForFreeEvents()
        case .upcoming:
            self.funcCallApiForUpcomingEvents()
        default:
            break;
        }
    }
}

// MARK: - TableView Delegate
extension ViewMoreEventsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.viewModel.arrEventCategory[self.viewModel.index] {
        case .weekend:
            return self.viewModel.arrData?.itemsWeekend?.count ?? 0
        case .online:
            return self.viewModel.arrData?.itemsVirtual?.count ?? 0
        case .popular:
            return self.viewModel.arrData?.itemsPopular?.count ?? 0
        case .free:
            return self.viewModel.arrData?.itemsFree?.count ?? 0
        case .upcoming:
            return self.viewModel.arrData?.itemsUpcoming?.count ?? 0
        default:
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
            switch self.viewModel.arrEventCategory[self.viewModel.index] {
            case .weekend:
                if let data = self.viewModel.arrData?.itemsWeekend, data.indices.contains(indexPath.row){
                    cell.getEvent = data[indexPath.row]
                }
            case .online:
                if let data = self.viewModel.arrData?.itemsVirtual, data.indices.contains(indexPath.row){
                    cell.getEvent = data[indexPath.row]
                }
            case .popular:
                if let data = self.viewModel.arrData?.itemsPopular, data.indices.contains(indexPath.row){
                    cell.getEvent = data[indexPath.row]
                }
            case .free:
                if let data = self.viewModel.arrData?.itemsFree, data.indices.contains(indexPath.row){
                    cell.getEvent = data[indexPath.row]
                }
            case .upcoming:
                if let data = self.viewModel.arrData?.itemsUpcoming, data.indices.contains(indexPath.row){
                    cell.getEvent = data[indexPath.row]
                }
            default:
                if let data = self.viewModel.arrData?.itemsWeekend, data.indices.contains(indexPath.row){
                    cell.getEvent = data[indexPath.row]
                }
            }
            
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        switch self.viewModel.arrEventCategory[self.viewModel.index] {
//        case .weekend:
//            if let data = self.viewModel.arrData?.itemsWeekend, indexPath.row == data.count - 1, self.viewModel.currentPage < self.viewModel.totalPage {
//                self.loadData()
//            }
//        case .online:
//            if let data = self.viewModel.arrData?.itemsVirtual, indexPath.row == data.count - 1, self.viewModel.currentPage < self.viewModel.totalPage {
//                self.loadData()
//            }
//        case .popular:
//            if let data = self.viewModel.arrData?.itemsPopular, indexPath.row == data.count - 1, self.viewModel.currentPage < self.viewModel.totalPage {
//                self.loadData()
//            }
//        case .free:
//            if let data = self.viewModel.arrData?.itemsFree, indexPath.row == data.count - 1, self.viewModel.currentPage < self.viewModel.totalPage {
//                self.loadData()
//            }
//        case .upcoming:
//            if let data = self.viewModel.arrData?.itemsUpcoming, indexPath.row == data.count - 1, self.viewModel.currentPage < self.viewModel.totalPage {
//                self.loadData()
//            }
//        default:
//            break;
//        }
        
        self.addLoader(indexPath: indexPath)
    }
    
    func addLoader(indexPath :IndexPath){
        let lastSectionIndex = self.tblView.numberOfSections - 1
        let lastRowIndex = tblView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            self.loadData()
            
           // print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tblView.bounds.width, height: CGFloat(44))

            self.tblView.tableFooterView = spinner
            self.tblView.tableFooterView?.isHidden = false
        }
    }
    
    
}
//MARK: - CustomSearchMethodsDelegate
extension ViewMoreEventsVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
        
    }
    
    func rightButtonPressed(_ sender: UIButton) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchLocationVC) as? EventSearchLocationVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension ViewMoreEventsVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchHomeVC) as? EventSearchHomeVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
}
//MARK: - NavigationBarViewDelegate
extension ViewMoreEventsVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
