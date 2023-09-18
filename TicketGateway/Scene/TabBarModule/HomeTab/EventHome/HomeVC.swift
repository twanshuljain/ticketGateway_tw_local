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
        self.tblEvents.countryName = self.viewModel.country?.country_name ?? self.getCountry()
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
        vwSearchBar.lblAddress.text = self.viewModel.selectedCountryName ?? self.getCountry()
        self.vwSearchBar.delegate = self
        self.vwSearchBar.txtSearch.delegate = self
    }
    
    func navigateToDetailVc(index:IndexPath){
        if let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC{
            if self.viewModel.arrEventCategory.indices.contains(index.section){
                switch self.viewModel.arrEventCategory[index.section] {
                case .noLocationData:
                    print("No Data Found")
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
            viewModel.getEventAsPerLocation(countryName: self.viewModel.country?.country_name ?? self.getCountry(), complition: { isTrue, messageShowToast in
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
                var numberOfPage = 0
                if self.viewModel.eventDetail?.eventCoverImageObj?.eventCoverImage != nil || self.viewModel.eventDetail?.eventCoverImageObj?.eventCoverImage != ""{
                    numberOfPage = (self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0) + 1
                }else{
                    numberOfPage = self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0
                }
                // Here we are saving number of pages for page control UI on detail screen, We need to store it for first time only.
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
        if self.viewModel.selectedCountryName != nil && self.viewModel.selectedCountryName != ""{
            view?.selectedCountry = self.viewModel.selectedCountryName
        }else{
            view?.selectedCountry = self.viewModel.currentRegionCountry
        }
        view?.selecetdCountriesModel = CountryInfo.init(country_code: "", dial_code: "", country_name: view?.selectedCountry ?? "")
        view?.selecetdCountriesModel = self.viewModel.country
        self.navigationController?.pushViewController(view!, animated: true)
    }
}

// MARK: -
extension HomeVC: SendLocation {
    func toSendLocation(location: CountryInfo, selectedCountry: String) {
        vwSearchBar.lblAddress.text = location.country_name ?? self.getCountry()
        self.viewModel.country = location
        self.viewModel.selectedCountryName = selectedCountry
        self.refreshData()
    }
}

// MARK: - EventsOrganizesListTableViewProtocol
extension HomeVC: EventsOrganizesListTableViewProtocol{
    func tapActionOfViewMoreEvents(index: Int) {
        let view = self.createView(storyboard: .home, storyboardID: .ViewMoreEventsVC) as? ViewMoreEventsVC
        view?.updateHomeScreenDelegate = self
        view?.viewModel.index = index
        view?.viewModel.countryName = self.viewModel.country?.country_name ?? self.getCountry()
        view?.viewModel.arrEventCategory = self.viewModel.arrEventCategory
        self.navigationController?.pushViewController(view!, animated: true)
    }
}


extension HomeVC: ActivityController {
    func toShowActivityController(eventDetail: GetEventModel) {
        self.shareEventDetailData(
            eventStartDate: eventDetail.date?.eventStartDate ?? "",
            eventEndDate: eventDetail.date?.eventEndDate ?? "",
            eventCoverImage: eventDetail.coverImage?.eventCoverImage,
            eventTitle: eventDetail.event?.title,
            eventStartTime: eventDetail.date?.eventStartTime ?? "",
            eventEndTime: eventDetail.date?.eventEndTime ?? "",
            eventDescription: eventDetail.event?.eventDescription
        )
    }
  
}
extension HomeVC: EventDetailVCProtocol{
    func updateData() {
        self.refreshData()
    }
}
extension HomeVC: FavouriteAction {    
    func toCallFavouriteaApi(eventDetail: GetEventModel, isForLocation: Bool) {
        // Condition for -> If user with guest login then like/unlike feature should not work.
        if (UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin)) {
            self.showToast(message: Unable_To_Like)
            return
        }
        AppShareData().commanEventLikeApiCall(likeStatus: eventDetail.likeCountData?.isLiked ?? false, eventId: eventDetail.event?.id ?? 0, completion: { _,_ in
            self.funcCallApi()
        })
    }
}
// MARK: - 
extension HomeVC: NavigateToProfile, suggestedOrganizerListProtocol {
    func followUnfollowAction(tag: Int) {
        // Condition for -> If user with guest login then like/unlike feature should not work.
        if UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin) {
            self.showToast(message: Unable_To_Follow)
            return
        }
        if let cell = self.collvwSuggestedOrganisation.cellForItem(at: IndexPath.init(row: tag, section: 0)) as? suggestedOrganizerCell {
            if Reachability.isConnectedToNetwork() { //check internet connectivity
                if let organizerId = self.collvwSuggestedOrganisation.arrOrganizersList?[tag].userID {
                    parentView.showLoading(centreToView: self.view)
                    AppShareData().commanFollowUnfollowApi(organizerId: organizerId, complition: { isTrue, messageShowToast in
                        if isTrue {
                            DispatchQueue.main.async {
                                self.parentView.stopLoading()
                                self.collvwSuggestedOrganisation.arrOrganizersList?.removeAll()
                                self.funcCallApiForOrganizersList(viewAll: false)
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
            let url = (data.profileImage ?? "")
            vc.imageUrl = url
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
