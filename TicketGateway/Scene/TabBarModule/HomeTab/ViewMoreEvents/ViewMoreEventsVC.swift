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
    @IBOutlet weak var parentView:UIView!
   
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
            self.funcCallApiForLocation()
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
    
    
    func navigateToDetail(index:IndexPath){
        let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC
        switch self.viewModel.arrEventCategory[self.viewModel.index] {
        case .nearByLocation:
            if self.viewModel.itemsLocation.indices.contains(index.row){
                view?.viewModel.eventId = self.viewModel.itemsLocation[index.row].event?.id
            }
        case .weekend:
            if self.viewModel.itemsWeekend.indices.contains(index.row){
                view?.viewModel.eventId = self.viewModel.itemsWeekend[index.row].event?.id
            }
        case .online:
            if self.viewModel.itemsVirtual.indices.contains(index.row){
                view?.viewModel.eventId = self.viewModel.itemsVirtual[index.row].event?.id
            }
        case .popular:
            if self.viewModel.itemsPopular.indices.contains(index.row){
                view?.viewModel.eventId = self.viewModel.itemsPopular[index.row].event?.id
            }
        case .free:
            if self.viewModel.itemsFree.indices.contains(index.row){
                view?.viewModel.eventId = self.viewModel.itemsFree[index.row].event?.id
            }
        case .upcoming:
            if self.viewModel.itemsUpcoming.indices.contains(index.row){
                view?.viewModel.eventId = self.viewModel.itemsUpcoming[index.row].event?.id
            }
        }
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
    func funcCallApiForLocation(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getEventAsPerLocation(viewAll:true, countryName: "Toronto", complition: { isTrue, messageShowToast in
                
                if isTrue == true {
                    self.parentView.stopLoading()
                    let data = self.viewModel.itemsLocation
                    //self.viewModel.itemsLocation.removeAll()
                 //   self.viewModel.itemsLocation = data.removeDuplicates()
                        DispatchQueue.main.async {
                            self.tblView.reloadData()
                        }
                 //   }
                    
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
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
    
    
    func funcCallApi(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getEventApiForWeekendEvents(viewAll:true,complition: { isTrue, messageShowToast in
                
                if isTrue == true {
                    self.parentView.stopLoading()
                    let data = self.viewModel.itemsWeekend
                    //self.viewModel.itemsWeekend.removeAll()
                 //   self.viewModel.itemsWeekend = data.removeDuplicates()
                    
                   // self.viewModel.itemsWeekend = self.viewModel.itemsWeekend.removeDuplicates()
                        DispatchQueue.main.async {
                            self.tblView.tableFooterView = nil
                            self.tblView.tableFooterView?.isHidden = true
                            self.tblView.reloadData()
                        }
                    
                    
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
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
    
    func funcCallApiForOnlineEvents(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getEventApiForOnlineEvents(viewAll:true,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                  //  if let itemsVirtual = self.viewModel.arrData?.itemsVirtual{
                    
                    let data = self.viewModel.itemsVirtual
                   // self.viewModel.itemsVirtual.removeAll()
                    //self.viewModel.itemsVirtual = data.removeDuplicates()
                    
                     //   self.viewModel.itemsVirtual = self.viewModel.itemsVirtual.removeDuplicates()
                        DispatchQueue.main.async {
                            self.tblView.tableFooterView = nil
                            self.tblView.tableFooterView?.isHidden = true
                            self.tblView.reloadData()
                        }
                   // }
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
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


    func funcCallApiForPopularEvents(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getEventApiForPopularEvents(viewAll:true,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                   // if let itemsPopular = self.viewModel.arrData?.itemsPopular{
                    let data = self.viewModel.itemsPopular
                    print("self.viewModel.itemsPopular Before",self.viewModel.itemsPopular.count)
                    //self.viewModel.itemsPopular.removeAll()
                   // self.viewModel.itemsPopular = data.removeDuplicates()
                    print("self.viewModel.itemsPopular After",self.viewModel.itemsPopular.count)
                    //self.viewModel.itemsPopular = self.viewModel.itemsPopular.removeDuplicates()
                        DispatchQueue.main.async {
                            self.tblView.tableFooterView = nil
                            self.tblView.tableFooterView?.isHidden = true
                            self.tblView.reloadData()
                        }
                  //  }
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
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


    func funcCallApiForFreeEvents(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getEventApiForFreeEvents(viewAll:true,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                   // if let itemsFree = self.viewModel.arrData?.itemsFree{
                    
                    let data = self.viewModel.itemsFree
                   // self.viewModel.itemsFree.removeAll()
                //    self.viewModel.itemsFree = data.removeDuplicates()
                    
                    //self.viewModel.itemsFree = self.viewModel.itemsFree.removeDuplicates()
                        DispatchQueue.main.async {
                            self.tblView.tableFooterView = nil
                            self.tblView.tableFooterView?.isHidden = true
                            self.tblView.reloadData()
                        }
                   // }
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
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

    func funcCallApiForUpcomingEvents(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getEventApiForUpcomingEvents(viewAll:true,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                   //     if let itemsUpcoming = self.viewModel.arrData?.itemsUpcoming{
                    
                    let data = self.viewModel.itemsUpcoming
                  //  self.viewModel.itemsUpcoming.removeAll()
                //    self.viewModel.itemsUpcoming = data.removeDuplicates()
                    
                         //   self.viewModel.itemsUpcoming = self.viewModel.itemsUpcoming.removeDuplicates()
                            DispatchQueue.main.async {
                                self.tblView.tableFooterView = nil
                                self.tblView.tableFooterView?.isHidden = true
                                self.tblView.reloadData()
                            }
                 //       }
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
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
    
    @objc func loadData() {
        // Make network call to fetch data for currentPage
        self.viewModel.currentPage += 1
        
        // print("this is the last cell")
         let spinner = UIActivityIndicatorView(style: .gray)
         spinner.startAnimating()
         spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tblView.bounds.width, height: CGFloat(44))
        switch self.viewModel.arrEventCategory[self.viewModel.index] {
        case .nearByLocation:
            if self.viewModel.itemsLocation.count != self.viewModel.totalPage{
                self.tblView.tableFooterView = spinner
                self.tblView.tableFooterView?.isHidden = false
                self.funcCallApiForLocation()
            }else{
                self.tblView.tableFooterView = nil
                self.tblView.tableFooterView?.isHidden = true
            }
        case .weekend:
            if self.viewModel.itemsWeekend.count != self.viewModel.totalPage{
                self.tblView.tableFooterView = spinner
                self.tblView.tableFooterView?.isHidden = false
                self.funcCallApi()
            }else{
                self.tblView.tableFooterView = nil
                self.tblView.tableFooterView?.isHidden = true
            }
        case .online:
            if self.viewModel.itemsVirtual.count != self.viewModel.totalPage{
                self.tblView.tableFooterView = spinner
                self.tblView.tableFooterView?.isHidden = false
                self.funcCallApiForOnlineEvents()
            }else{
                self.tblView.tableFooterView = nil
                self.tblView.tableFooterView?.isHidden = true
            }
        case .popular:
            if self.viewModel.itemsPopular.count != self.viewModel.totalPage{
                self.tblView.tableFooterView = spinner
                self.tblView.tableFooterView?.isHidden = false
                self.funcCallApiForPopularEvents()
            }else{
                self.tblView.tableFooterView = nil
                self.tblView.tableFooterView?.isHidden = true
            }
            
        case .free:
            if self.viewModel.itemsFree.count != self.viewModel.totalPage{
                self.tblView.tableFooterView = spinner
                self.tblView.tableFooterView?.isHidden = false
                self.funcCallApiForFreeEvents()
            }else{
                self.tblView.tableFooterView = nil
                self.tblView.tableFooterView?.isHidden = true
            }
            
          
        case .upcoming:
            if self.viewModel.itemsUpcoming.count != self.viewModel.totalPage{
                self.tblView.tableFooterView = spinner
                self.tblView.tableFooterView?.isHidden = false
                self.funcCallApiForUpcomingEvents()
            }else{
                self.tblView.tableFooterView = nil
                self.tblView.tableFooterView?.isHidden = true
            }
            
           
        default:
            break;
        }
    }
}

// MARK: - TableView Delegate
extension ViewMoreEventsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.viewModel.arrEventCategory[self.viewModel.index] {
        case .nearByLocation:
            return self.viewModel.itemsLocation.count
        case .weekend:
            return self.viewModel.itemsWeekend.count
        case .online:
            return self.viewModel.itemsVirtual.count
        case .popular:
            return self.viewModel.itemsPopular.count
        case .free:
            return self.viewModel.itemsFree.count
        case .upcoming:
            return self.viewModel.itemsUpcoming.count
        default:
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
            switch self.viewModel.arrEventCategory[self.viewModel.index] {
            case .nearByLocation:
                if self.viewModel.itemsLocation.indices.contains(indexPath.row){
                    cell.getEvent =  self.viewModel.itemsLocation[indexPath.row]
                }
            case .weekend:
                if self.viewModel.itemsWeekend.indices.contains(indexPath.row){
                    cell.getEvent = self.viewModel.itemsWeekend[indexPath.row]
                }
            case .online:
                if self.viewModel.itemsVirtual.indices.contains(indexPath.row){
                    cell.getEvent = self.viewModel.itemsVirtual[indexPath.row]
                }
            case .popular:
                if self.viewModel.itemsPopular.indices.contains(indexPath.row){
                    cell.getEvent = self.viewModel.itemsPopular[indexPath.row]
                }
            case .free:
                if self.viewModel.itemsFree.indices.contains(indexPath.row){
                    cell.getEvent = self.viewModel.itemsFree[indexPath.row]
                }
            case .upcoming:
                if self.viewModel.itemsUpcoming.indices.contains(indexPath.row){
                    cell.getEvent = self.viewModel.itemsUpcoming[indexPath.row]
                }
            default:
                if self.viewModel.itemsWeekend.indices.contains(indexPath.row){
                    cell.getEvent = self.viewModel.itemsWeekend[indexPath.row]
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
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToDetail(index: indexPath)
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
