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

protocol ViewMoreEventsVCProtocol: class {
    func reloadView(eventId:Int?, isEventDetailApiCall: Bool?)
}

class ViewMoreEventsVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var parentView:UIView!
    var viewModel = ViewMoreEventsViewModel()
    weak var delegate : ViewMoreEventsVCProtocol?
    weak var updateHomeScreenDelegate: (EventDetailVCProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.setData()
        //self.viewModel.refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        //tblView.refreshControl = self.viewModel.refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.isLikedAnyEvent = false
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
        if self.viewModel.isComingFrom == .Home{
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
        }else{
            navigationView.lblTitle.text = "Suggested Events"
            self.funcCallApiForSuggestedEvents()
        }

    }
    
    
    func navigateToDetail(index:IndexPath){
        let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC
        
        if self.viewModel.isComingFrom == .Home{
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
            view?.delegate = self
            self.navigationController?.pushViewController(view!, animated: true)
        } else if viewModel.isComingFrom == .EventDetail {
            if self.viewModel.itemsSuggestedEvents.indices.contains(index.row) {
                // On Click of cell api should call
                self.delegate?.reloadView(
                    eventId: self.viewModel.itemsSuggestedEvents[index.row].event?.id,
                    isEventDetailApiCall: true
                )
            }
            self.navigationController?.popViewController(animated: false)
        }
        
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
    
    func funcCallApiForSuggestedEvents(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.GetEventSuggestedCategory(viewAll:true,complition: { isTrue, messageShowToast in
                
                if isTrue == true {
                    self.parentView.stopLoading()
                    let data = self.viewModel.itemsSuggestedEvents
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
//         let spinner = UIActivityIndicatorView(style: .gray)
//         spinner.startAnimating()
//         spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tblView.bounds.width, height: CGFloat(44))
        if self.viewModel.isComingFrom == .Home{
            
            switch self.viewModel.arrEventCategory[self.viewModel.index] {
            case .nearByLocation:
                if self.viewModel.itemsLocation.count != self.viewModel.totalPage{
                    //self.tblView.tableFooterView = spinner
                    self.tblView.tableFooterView?.isHidden = false
                    self.funcCallApiForLocation()
                }else{
                    self.tblView.tableFooterView = nil
                    self.tblView.tableFooterView?.isHidden = true
                }
            case .weekend:
                if self.viewModel.itemsWeekend.count != self.viewModel.totalPage{
                   // self.tblView.tableFooterView = spinner
                    self.tblView.tableFooterView?.isHidden = false
                    self.funcCallApi()
                }else{
                    self.tblView.tableFooterView = nil
                    self.tblView.tableFooterView?.isHidden = true
                }
            case .online:
                if self.viewModel.itemsVirtual.count != self.viewModel.totalPage{
                   // self.tblView.tableFooterView = spinner
                    self.tblView.tableFooterView?.isHidden = false
                    self.funcCallApiForOnlineEvents()
                }else{
                    self.tblView.tableFooterView = nil
                    self.tblView.tableFooterView?.isHidden = true
                }
            case .popular:
                if self.viewModel.itemsPopular.count != self.viewModel.totalPage{
                  //  self.tblView.tableFooterView = spinner
                    self.tblView.tableFooterView?.isHidden = false
                    self.funcCallApiForPopularEvents()
                }else{
                    self.tblView.tableFooterView = nil
                    self.tblView.tableFooterView?.isHidden = true
                }
                
            case .free:
                if self.viewModel.itemsFree.count != self.viewModel.totalPage{
                   // self.tblView.tableFooterView = spinner
                    self.tblView.tableFooterView?.isHidden = false
                    self.funcCallApiForFreeEvents()
                }else{
                    self.tblView.tableFooterView = nil
                    self.tblView.tableFooterView?.isHidden = true
                }
                
                
            case .upcoming:
                if self.viewModel.itemsUpcoming.count != self.viewModel.totalPage{
                   // self.tblView.tableFooterView = spinner
                    self.tblView.tableFooterView?.isHidden = false
                    self.funcCallApiForUpcomingEvents()
                }else{
                    self.tblView.tableFooterView = nil
                    self.tblView.tableFooterView?.isHidden = true
                }
            }
        } else {
            if self.viewModel.itemsSuggestedEvents.count != self.viewModel.totalPage{
               // self.tblView.tableFooterView = spinner
                self.tblView.tableFooterView?.isHidden = false
                self.funcCallApiForSuggestedEvents()
            }else{
                self.tblView.tableFooterView = nil
                self.tblView.tableFooterView?.isHidden = true
            }
        }
    }
}

// MARK: - TableView Delegate
extension ViewMoreEventsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.isComingFrom == .Home{
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
            }
        } else {
            return  self.viewModel.itemsSuggestedEvents.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
            cell.selectionStyle = .none
            cell.btnLike.mk_addTapHandler { (btn) in
                 self.btnLikeActionTapped(btn: btn, indexPath: indexPath)
            }
            cell.btnShare.mk_addTapHandler { (btn) in
                 print("You can use here also directly : \(indexPath.row)")
                 self.btnShareActionTapped(btn: btn, indexPath: indexPath)
            }
            if self.viewModel.isComingFrom == .Home {
                switch self.viewModel.arrEventCategory[self.viewModel.index] {
                case .nearByLocation:
                    if self.viewModel.itemsLocation.indices.contains(indexPath.row){
                        cell.getEvent =  self.viewModel.itemsLocation[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (viewModel.itemsLocation[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                case .weekend:
                    if self.viewModel.itemsWeekend.indices.contains(indexPath.row){
                        cell.getEvent = self.viewModel.itemsWeekend[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (viewModel.itemsWeekend[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                case .online:
                    if self.viewModel.itemsVirtual.indices.contains(indexPath.row){
                        cell.getEvent = self.viewModel.itemsVirtual[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (viewModel.itemsVirtual[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                case .popular:
                    if self.viewModel.itemsPopular.indices.contains(indexPath.row){
                        cell.getEvent = self.viewModel.itemsPopular[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (viewModel.itemsPopular[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                case .free:
                    if self.viewModel.itemsFree.indices.contains(indexPath.row){
                        cell.getEvent = self.viewModel.itemsFree[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (viewModel.itemsFree[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                case .upcoming:
                    if self.viewModel.itemsUpcoming.indices.contains(indexPath.row){
                        cell.getEvent = self.viewModel.itemsUpcoming[indexPath.row]
                        cell.btnLike.setImage(UIImage(named: (viewModel.itemsUpcoming[indexPath.row].likeCountData?.isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                    }
                }
            } else {
                if self.viewModel.itemsSuggestedEvents.indices.contains(indexPath.row){
                    cell.getEvent =  self.viewModel.itemsSuggestedEvents[indexPath.row]
                    cell.btnLike.setImage(UIImage(named: (viewModel.itemsSuggestedEvents[indexPath.row].isLiked ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    func btnShareActionTapped(btn:UIButton, indexPath:IndexPath) {
        print("IndexPath : \(indexPath.row)")
        if viewModel.isComingFrom == .Home {
            switch viewModel.arrEventCategory[viewModel.index] {
            case .nearByLocation:
                if viewModel.itemsLocation.indices.contains(indexPath.row){
                    toShowActivityController(eventDetail: viewModel.itemsLocation[indexPath.row])
                }
            case .weekend:
                if viewModel.itemsWeekend.indices.contains(indexPath.row){
                    toShowActivityController(eventDetail: viewModel.itemsWeekend[indexPath.row])
                }
            case .online:
                if viewModel.itemsVirtual.indices.contains(indexPath.row){
                    toShowActivityController(eventDetail: viewModel.itemsVirtual[indexPath.row])
                }
            case .popular:
                if viewModel.itemsPopular.indices.contains(indexPath.row){
                    toShowActivityController(eventDetail: viewModel.itemsPopular[indexPath.row])
                }
            case .free:
                if viewModel.itemsFree.indices.contains(indexPath.row){
                    toShowActivityController(eventDetail: viewModel.itemsFree[indexPath.row])
                }
            case .upcoming:
                if viewModel.itemsUpcoming.indices.contains(indexPath.row){
                    toShowActivityController(eventDetail: viewModel.itemsUpcoming[indexPath.row])
                }
            }
        } else if viewModel.isComingFrom == .EventDetail {
            // Suggestions Event
            if viewModel.itemsSuggestedEvents.indices.contains(indexPath.row){
                toShowActivityController(eventDetail: viewModel.itemsSuggestedEvents[indexPath.row])
            }
        }
    }
    func btnLikeActionTapped(btn:UIButton, indexPath: IndexPath) {
        print("IndexPath row : \(indexPath.row)")
        if viewModel.isComingFrom == .Home {
            switch viewModel.arrEventCategory[viewModel.index] {
            case .nearByLocation:
                if viewModel.itemsLocation.indices.contains(indexPath.row) {
                    viewModel.itemsLocation[indexPath.row].likeCountData?.isLiked?.toggle()
                    viewModel.toCallFavouriteaApi(eventDetail: viewModel.itemsLocation[indexPath.row], isForLocation: true)
                }
            case .weekend:
                if viewModel.itemsWeekend.indices.contains(indexPath.row){
                    viewModel.itemsWeekend[indexPath.row].likeCountData?.isLiked?.toggle()
                    viewModel.toCallFavouriteaApi(eventDetail: viewModel.itemsWeekend[indexPath.row], isForLocation: false)
                }
            case .online:
                if viewModel.itemsVirtual.indices.contains(indexPath.row){
                    viewModel.itemsVirtual[indexPath.row].likeCountData?.isLiked?.toggle()
                    viewModel.toCallFavouriteaApi(eventDetail: viewModel.itemsVirtual[indexPath.row], isForLocation: false)
                }
            case .popular:
                if viewModel.itemsPopular.indices.contains(indexPath.row){
                    viewModel.itemsPopular[indexPath.row].likeCountData?.isLiked?.toggle()
                    viewModel.toCallFavouriteaApi(eventDetail: viewModel.itemsPopular[indexPath.row], isForLocation: false)
                }
            case .free:
                if viewModel.itemsFree.indices.contains(indexPath.row){
                    viewModel.itemsFree[indexPath.row].likeCountData?.isLiked?.toggle()
                    viewModel.toCallFavouriteaApi(eventDetail: viewModel.itemsFree[indexPath.row], isForLocation: false)
                }
            case .upcoming:
                if viewModel.itemsUpcoming.indices.contains(indexPath.row){
                    viewModel.itemsUpcoming[indexPath.row].likeCountData?.isLiked?.toggle()
                    viewModel.toCallFavouriteaApi(eventDetail: viewModel.itemsUpcoming[indexPath.row], isForLocation: false)
                }
            }
        } else if viewModel.isComingFrom == .EventDetail {
            if viewModel.itemsSuggestedEvents.indices.contains(indexPath.row){
                viewModel.itemsSuggestedEvents[indexPath.row].isLiked?.toggle()
                viewModel.toCallFavouriteaApi(eventDetail: viewModel.itemsSuggestedEvents[indexPath.row], isForLocation: false)
            }
        }
        self.tblView.reloadData()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
extension ViewMoreEventsVC: EventDetailVCProtocol {
    func updateData() {
        self.viewModel.currentPage = 1
        self.viewModel.totalPage = 1
        self.viewModel.itemsWeekend.removeAll()
        self.viewModel.itemsVirtual.removeAll()
        self.viewModel.itemsPopular.removeAll()
        self.viewModel.itemsFree.removeAll()
        self.viewModel.itemsUpcoming.removeAll()
        self.viewModel.itemsLocation.removeAll()
        self.viewModel.itemsSuggestedEvents.removeAll()
        self.setUp()
        self.setData()
        self.tblView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}
//MARK: - NavigationBarViewDelegate
extension ViewMoreEventsVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
        if viewModel.isLikedAnyEvent {
            // For API calling at HomeScreen when user comeback from MoreEventList Screen
            self.updateHomeScreenDelegate?.updateData()
            // For API calling of event detail when user come back from MoreEventList Screen
            self.delegate?.reloadView(eventId: viewModel.eventId, isEventDetailApiCall: true)
        }
    }
}
extension ViewMoreEventsVC: ActivityController {
    func toShowActivityController(eventDetail: GetEventModel) {
        var objectsToShare = [Any]()
        let shareImageObj = UIImage(named: "homeDas")
        
        if let eventTitle = eventDetail.event?.title{
            let title = "Event Title:- " + eventTitle
            objectsToShare.append(title)
        }
        
        let eventDate = " " + "\(eventDetail.date?.eventStartDate?.getDateFormattedFrom() ?? "")" +  " " + "to" + " " + "\(eventDetail.date?.eventEndDate?.getDateFormattedFromTo() ?? "")"
        let date = "\nEvent Date:- " + eventDate
        objectsToShare.append(date)
        
        
        let eventEndDate = " " + "\(eventDetail.date?.eventStartTime?.getFormattedTime() ?? "")" +  " " + "-" + " " + "\(eventDetail.date?.eventEndTime?.getFormattedTime() ?? "")"
        let time = "\nEvent Time:- " + eventEndDate
        objectsToShare.append(time)
        
        
        if let eventDesc = eventDetail.event?.eventDescription{
            var _ = "\nEvent Description:- " + eventDesc
            objectsToShare.append(eventDesc)
        } else {
            var desc = "\nEvent Description:- No Description available for this event"
            objectsToShare.append(desc)
        }
        
        if let imageUrl = eventDetail.coverImage?.eventCoverImage{
            if imageUrl.contains(APIHandler.shared.previousBaseURL){
                let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
                    objectsToShare.append("\n Check this image: - \(url)")
                } else {
                    objectsToShare.append(shareImageObj as Any)
                }
            }else{
                if let url = (APIHandler.shared.s3URL + imageUrl).getCleanedURL() {
                    objectsToShare.append("\n Check this image: - \(url)")
                } else {
                    objectsToShare.append(shareImageObj as Any)
                }
            }

        } else {
            objectsToShare.append(shareImageObj as Any)
        }
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        //  tblEvents.delegateShareAction = self
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
  
}
