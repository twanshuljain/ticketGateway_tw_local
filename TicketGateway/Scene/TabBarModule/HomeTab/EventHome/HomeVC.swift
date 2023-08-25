//
//  HomeVC.swift
//  TicketGateway
//
//  Created by Apple  on 17/04/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit
import SideMenu
import SVProgressHUD



class HomeVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var heightOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightOfNearOrganisedEvent: NSLayoutConstraint!
    @IBOutlet weak var btnViewAllForSuggestedOrganised: CustomButtonNormal!
    @IBOutlet weak var lblNearOrganisedEvent: UILabel!
    @IBOutlet weak var lblSuggestedOrganised: UILabel!
    @IBOutlet weak var tblEvents: EventsOrganizesListTableView!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var collvwSuggestedOrganisation: suggestedOrganizerList!
    @IBOutlet weak var tableParentView: UIView!
    @IBOutlet weak var collectionParentView: UIView!
    @IBOutlet weak var parentView: UIView!
    
    //MARK: - Variables
    var isMenuOpened: Bool = false
    var viewModel = HomeDashBoardViewModel()
    private let eventCategoryViewModel = GetEventCategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.funcCallApi()
        self.setUp()
        self.tblEvents.delegateShareAction = self
        self.tblEvents.delegateLikeAction = self
        self.collvwSuggestedOrganisation.delegateOrgansierToProfile = self
        self.collvwSuggestedOrganisation.followUnfollowDelegate = self
        
        // self.apiCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}


//MARK: - UITextFieldDelegate
extension HomeVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchHomeVC) as? EventSearchHomeVC
        view?.delegate = self
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
}
//MARK: - Functions
extension HomeVC {
    func setUp() {
        self.setUi()
        self.collvwSuggestedOrganisation.configure()
        self.tblEvents.delegateViewMore = self
        self.tblEvents.countryName = self.viewModel.countryName
        self.tblEvents.configure(isComingFrom: IsComingFromForEventsOrganizesListTableView.Home)
        self.tblEvents.tableDidSelectAtIndex = { _ in
            self.navigationController?.popViewController(animated: true)
        }
        self.tblEvents.tableDidSelectAtIndex = {  index in
            self.navigateToDetailVc(index: index)

        }
        //self.tblEvents.reloadData()
        self.tblEvents.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfNearOrganisedEvent.constant = self.tblEvents.contentSize.height
        self.vwSearchBar.delegate = self
        self.vwSearchBar.txtSearch.delegate = self
    }
    
    func navigateToDetailVc(index:IndexPath){
        if let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC{
            if self.viewModel.arrEventCategory.indices.contains(index.section){
                switch self.viewModel.arrEventCategory[index.section] {
                case .nearByLocation:
                    if self.viewModel.arrSearchCategoryData.indices.contains(index.row){
                        view.viewModel.eventId = self.viewModel.arrSearchCategoryData[index.row].event?.id
                    }
                case .weekend:
                    if self.viewModel.arrDataaWeekend.indices.contains(index.row){
                        view.viewModel.eventId = self.viewModel.arrDataaWeekend[index.row].event?.id
                    }
                case .online:
                    if self.viewModel.arrDataaVirtual.indices.contains(index.row){
                        view.viewModel.eventId = self.viewModel.arrDataaVirtual[index.row].event?.id
                    }
                case .popular:
                    if self.viewModel.arrDataaPopular.indices.contains(index.row){
                        view.viewModel.eventId = self.viewModel.arrDataaPopular[index.row].event?.id
                    }
                case .free:
                    if self.viewModel.arrDataaFree.indices.contains(index.row){
                        view.viewModel.eventId = self.viewModel.arrDataaFree[index.row].event?.id
                    }
                case .upcoming:
                    if self.viewModel.arrDataaUpcoming.indices.contains(index.row){
                        view.viewModel.eventId = self.viewModel.arrDataaUpcoming[index.row].event?.id
                    }
                }
                self.funcCallApiForEventDetail(eventId: view.viewModel.eventId, view: view)
            }
        }
    }
    
    func setUi(){
        self.lblNearOrganisedEvent.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblNearOrganisedEvent.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblSuggestedOrganised.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblSuggestedOrganised.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.btnViewAllForSuggestedOrganised.setTitles(text: SEE_ALL, font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .tgBlue))
      }
     override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightOfNearOrganisedEvent.constant = tblEvents.contentSize.height
        
    }
    
    func apiCall(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.GetEventApi(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    DispatchQueue.main.async {
                        self.tblEvents.arrDataaWeekend = self.viewModel.arrDataaWeekend
                        
                        self.tblEvents.reloadData()
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
            self.viewModel.dispatchGroup.enter()
            viewModel.getEventAsPerLocation(countryName: self.viewModel.countryName, complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    if let itemsLocation = self.viewModel.arrEventData.itemsLocation{
                        self.viewModel.semaphore.wait()
                        self.tblEvents.arrDataCategorySearch = []
                        self.tblEvents.arrDataCategorySearch.append(contentsOf: itemsLocation)
                        self.viewModel.semaphore.signal()
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
        
        
        self.viewModel.dispatchGroup.notify(queue: .main) {
            print("Finished Api Call GetEventApiForLocations")
            self.funcCallApiForWeekendEvents(viewAll: false)
        }
    }
    
    func funcCallApiForWeekendEvents(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            self.viewModel.dispatchGroup1.enter()
            viewModel.getEventApiForWeekendEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                
                if isTrue == true {
                    self.parentView.stopLoading()
                    //                   DispatchQueue.main.async {
                    if let itemWeekend = self.viewModel.arrEventData.itemsWeekend{
                        self.viewModel.semaphore.wait()
//                        itemWeekend.forEach { data in
//                            self.tblEvents.arrDataaWeekend.append(data)
//                        }
                        self.tblEvents.arrDataaWeekend = []
                        self.tblEvents.arrDataaWeekend.append(contentsOf: itemWeekend)
                        self.viewModel.semaphore.signal()
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
        
        
        self.viewModel.dispatchGroup1.notify(queue: .main) {
            print("Finished Api Call GetEventApiForWeekendEvents")
            self.funcCallApiForOnlineEvents(viewAll: false)
        }
    }
    
    func funcCallApiForOnlineEvents(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            self.viewModel.dispatchGroup2.enter()
            viewModel.getEventApiForOnlineEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    if let itemsVirtual = self.viewModel.arrEventData.itemsVirtual{
                        self.viewModel.semaphore.wait()
                        self.tblEvents.arrDataaVirtual = []
                        self.tblEvents.arrDataaVirtual.append(contentsOf: itemsVirtual)
                        self.viewModel.semaphore.signal()
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
        
        self.viewModel.dispatchGroup2.notify(queue: .main) {
            print("Finished Api Call GetEventApiForOnlineEvents")
            self.funcCallApiForPopularEvents(viewAll: false)
        }
    }
    func funcCallApiForPopularEvents(viewAll: Bool){
        if Reachability.isConnectedToNetwork() // check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            self.viewModel.dispatchGroup3.enter()
            viewModel.getEventApiForPopularEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    if let itemsPopular = self.viewModel.arrEventData.itemsPopular{
                        self.viewModel.semaphore.wait()
                        self.tblEvents.arrDataaPopular = []
                        self.tblEvents.arrDataaPopular.append(contentsOf: itemsPopular)
                        self.viewModel.semaphore.signal()
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
        
        self.viewModel.dispatchGroup3.notify(queue: .main) {
            print("Finished Api Call GetEventApiForPopularEvents")
            self.funcCallApiForFreeEvents(viewAll: false)
        }
    }
    
    
    func funcCallApiForFreeEvents(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            self.viewModel.dispatchGroup4.enter()
            viewModel.getEventApiForFreeEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    if let itemsFree = self.viewModel.arrEventData.itemsFree{
                        self.viewModel.semaphore.wait()
                        self.tblEvents.arrDataaFree = []
                        self.tblEvents.arrDataaFree.append(contentsOf: itemsFree)
                        self.viewModel.semaphore.signal()
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
        
        self.viewModel.dispatchGroup4.notify(queue: .main) {
            print("Finished Api Call GetEventApiForFreeEvents")
            self.funcCallApiForUpcomingEvents(viewAll: false)
        }
    }
    
    func funcCallApiForUpcomingEvents(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            self.viewModel.dispatchGroup5.enter()
            viewModel.getEventApiForUpcomingEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    print("Finished Api Call GetEventApiForFreeEvents")
                        if let itemsUpcoming = self.viewModel.arrEventData.itemsUpcoming{
                            self.viewModel.semaphore.wait()
                            //var arr = self.tblEvents.arrDataaUpcoming.removeDuplicates()
                            self.tblEvents.arrDataaUpcoming = []
                            self.tblEvents.arrDataaUpcoming.append(contentsOf: itemsUpcoming)
                            self.viewModel.semaphore.signal()
                        }
//                    if let items = self.viewModel.arrEventData.items{
//                        self.tblEvents.arrDataa = items
//                    }
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
        
        self.viewModel.dispatchGroup5.notify(queue: .main) {
            self.tblEvents.arrEventCategory = self.viewModel.arrEventCategory
                self.tblEvents.reloadData()
                self.funcCallApiForOrganizersList(viewAll: false)
        }
        
    }
    
    func funcCallApiForOrganizersList(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getOrganizersList { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    DispatchQueue.main.async {
                        self.lblSuggestedOrganised.text = "Organizers to follow"
                        self.collvwSuggestedOrganisation.arrOrganizersList = self.viewModel.arrOrganizersList
                        self.collvwSuggestedOrganisation.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.parentView.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    
    func funcCallFavoriteApi() {
        if Reachability.isConnectedToNetwork() {
            
        }
    }
    
    func funcCallApiForEventDetail(eventId:Int?, view: EventDetailVC){
        if let eventId = eventId{
          if Reachability.isConnectedToNetwork() //check internet connectivity
          {
              parentView.showLoading(centreToView: self.view)
              self.viewModel.dispatchGroup6.enter()
              viewModel.GetEventDetailApi(eventId: eventId, complition: { isTrue, messageShowToast in
                  if isTrue == true {
                      self.parentView.stopLoading()
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
            
            self.viewModel.dispatchGroup6.notify(queue: .main) {
                let numberOfPage = self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0
                AppShareData.sharedObject().saveNumOfPage(numOfPage: numberOfPage)
                view.viewModel.eventDetail = self.viewModel.eventDetail
                view.delegate = self
                self.navigationController?.pushViewController(view, animated: false)
            }
      }
  }
 
    func refreshData() {
        self.viewModel.arrSearchCategoryData.removeAll()
        //self.viewModel.arrEventData = nil
        self.viewModel.arrEventCategory.removeAll()
        self.viewModel.arrDataaWeekend.removeAll()
        self.viewModel.arrDataaVirtual.removeAll()
        self.viewModel.arrDataaPopular.removeAll()
        self.viewModel.arrDataaFree.removeAll()
        self.viewModel.arrDataaUpcoming.removeAll()
        self.viewModel.arrOrganizersList?.removeAll()
        
        self.tblEvents.arrData.removeAll()
        self.tblEvents.arrDataa.removeAll()
        self.tblEvents.arrDataaFree.removeAll()
        self.tblEvents.arrSearchData.removeAll()
        self.tblEvents.arrDataaPopular.removeAll()
        self.tblEvents.arrDataaVirtual.removeAll()
        self.tblEvents.arrDataaWeekend.removeAll()
        self.tblEvents.arrDataaUpcoming.removeAll()
        self.tblEvents.arrEventCategory.removeAll()
        self.tblEvents.arrDataCategorySearch.removeAll()
        self.collvwSuggestedOrganisation.arrOrganizersList?.removeAll()
        self.lblSuggestedOrganised.text = ""
        tblEvents.reloadData()
        collvwSuggestedOrganisation.reloadData()
        
        self.funcCallApi()
        self.setUp()
    }
}

//MARK: - CustomSearchMethodsDelegate
extension HomeVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
        
    }
    
    func rightButtonPressed(_ sender: UIButton) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchLocationVC) as? EventSearchLocationVC
        view?.delegate = self
        if self.viewModel.selectedIndexForCountry != nil{
            view?.selectedIndex = self.viewModel.selectedIndexForCountry
        }
        self.navigationController?.pushViewController(view!, animated: true)
    }
}

// MARK: -
extension HomeVC: SendLocation {
    func toSendLocation(location: String, selectedIndex:Int) {
        vwSearchBar.lblAddress.text = location
        self.viewModel.countryName = location
        self.viewModel.selectedIndexForCountry = selectedIndex
        self.refreshData()
    }
}

// MARK: - EventsOrganizesListTableViewProtocol
extension HomeVC: EventsOrganizesListTableViewProtocol{
    func tapActionOfViewMoreEvents(index: Int) {
        let view = self.createView(storyboard: .home, storyboardID: .ViewMoreEventsVC) as? ViewMoreEventsVC
        view?.updateHomeScreenDelegate = self
        view?.viewModel.index = index
        view?.viewModel.countryName = self.viewModel.countryName
        view?.viewModel.arrEventCategory = self.viewModel.arrEventCategory
        self.navigationController?.pushViewController(view!, animated: true)
    }
}


extension HomeVC: ActivityController {
    func toShowActivityController(eventDetail: GetEventModel) {
        var objectsToShare = [Any]()
        var shareImageObj = UIImage(named: "homeDas")
        
        if let eventTitle = eventDetail.event?.title{
            var title = "Event Title:- " + eventTitle
            objectsToShare.append(title)
        }
        
        let eventDate = " " + "\(eventDetail.date?.eventStartDate?.getDateFormattedFrom() ?? "")" +  " " + "to" + " " + "\(eventDetail.date?.eventEndDate?.getDateFormattedFromTo() ?? "")"
        var date = "\nEvent Date:- " + eventDate
        objectsToShare.append(date)
        
        
        let eventEndDate = " " + "\(eventDetail.date?.eventStartTime?.getFormattedTime() ?? "")" +  " " + "-" + " " + "\(eventDetail.date?.eventEndTime?.getFormattedTime() ?? "")"
        var time = "\nEvent Time:- " + eventEndDate
        objectsToShare.append(time)
        
        
        if let eventDesc = eventDetail.event?.eventDescription{
            var _ = "\nEvent Description:- " + eventDesc
            objectsToShare.append(eventDesc)
        }else{
            var desc = "\nEvent Description:- No Description available for this event"
            objectsToShare.append(desc)
        }
        
        if let imageUrl = eventDetail.coverImage?.eventCoverImage{
            if imageUrl.contains(APIHandler.shared.previousBaseURL){
                let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if let url = URL(string: APIHandler.shared.s3URL + imageUrl){
                    objectsToShare.append("\n Check this image: - \(url)")
                }else{
                    objectsToShare.append(shareImageObj)
                }
            }else{
                if let url = URL(string: APIHandler.shared.s3URL + imageUrl){
                    objectsToShare.append("\n Check this image: - \(url)")
                }else{
                    objectsToShare.append(shareImageObj)
                }
            }

        } else {
            objectsToShare.append(shareImageObj)
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
extension HomeVC: EventDetailVCProtocol{
    func updateData() {
        self.refreshData()
    }
}
extension HomeVC: FavouriteAction {    
    func toCallFavouriteaApi(eventDetail: GetEventModel, isForLocation: Bool) {
        if isForLocation {
            print("eventDetail.isLiked", eventDetail.likeCountData?.isLiked ?? false)
            print("eventDetail.event?.id", eventDetail.event?.id ?? 0)
            viewModel.favouriteApiForHome(
                likeStatus: eventDetail.likeCountData?.isLiked ?? false,
                eventId: eventDetail.event?.id ?? 0
            )
        } else {
            print("eventDetail.isLiked", eventDetail.likeCountData?.isLiked ?? false)
            print("eventDetail.event?.id", eventDetail.event?.id ?? 0)
            viewModel.favouriteApiForHome(
                likeStatus: eventDetail.likeCountData?.isLiked ?? false,
                eventId: eventDetail.event?.id ?? 0
            )
        }
    }
}
// MARK: - 
extension HomeVC: NavigateToProfile, suggestedOrganizerListProtocol {
    func followUnfollowAction(tag: Int) {
        if let cell = self.collvwSuggestedOrganisation.cellForItem(at: IndexPath.init(row: tag, section: 0)) as? suggestedOrganizerCell{
            if Reachability.isConnectedToNetwork() //check internet connectivity
            {
                if let organizerId = self.collvwSuggestedOrganisation.arrOrganizersList?[tag].userID {
                    parentView.showLoading(centreToView: self.view)
                    viewModel.followUnFollowApi(organizerId: organizerId, complition: { isTrue, messageShowToast in
                        if isTrue {
                            DispatchQueue.main.async {
                                self.parentView.stopLoading()
                                self.collvwSuggestedOrganisation.arrOrganizersList?.removeAll()
                                //self.collvwSuggestedOrganisation.reloadData()
                                self.funcCallApiForOrganizersList(viewAll: false)
//                                if messageShowToast == FollowUnfollow.follow.rawValue {
//                                    cell.btnFollerwers.setTitle("Following", for: .normal)
//                                } else {
//                                    cell.btnFollerwers.setTitle("Follow", for: .normal)
//                                }
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
        }
    }
    
    func tapActionOrganiser(index: Int, data: Organizers) {
        if let vc = self.createView(storyboard: .profile, storyboardID: .ManageEventProfileVC) as? ManageEventProfileVC {
            vc.isComingFromOranizer = true
            vc.name = data.name ?? ""
            if let url = URL(string: APIHandler.shared.baseURL + (data.profileImage ?? "")) {
                vc.imageUrl = url
            }
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
