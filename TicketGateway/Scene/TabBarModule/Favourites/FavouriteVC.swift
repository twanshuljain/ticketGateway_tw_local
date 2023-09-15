//
//  FavouriteVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 29/05/23.
// swiftlint: disable force_cast
// swiftlint: disable line_length
import UIKit
import SideMenu

class FavouriteVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var favouriteTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var findEventCollectionView: UICollectionView!
    @IBOutlet weak var vwNoLikedEventView: UIView!
    @IBOutlet weak var lblNoLikedEvent: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblFindEventNearYou: UILabel!
    @IBOutlet weak var vwVenueView: UIView!
    @IBOutlet weak var lblVenuNoLikeEvent: UILabel!
    @IBOutlet weak var lblVenuDescription: UILabel!
    @IBOutlet weak var lblVenuSuggestionForYou: UILabel!
    @IBOutlet weak var topConstraintTblView: NSLayoutConstraint!
    
    // MARK: All Properties
    var viewModel: FavouriteViewModel = FavouriteViewModel()
    let collectionData = ["Today", "Tomorrow", "This Week", "This Weekend"]
    var selectedDevice = ""
    var isFromDeselected = false
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.configure()
        self.setCollectionView()
        self.setFont()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateData()
    }
}
// MARK: - Functions
extension FavouriteVC {
    func configure() {
        favouriteTableView.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteTableViewCell")
        favouriteTableView.separatorColor = UIColor.clear
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        favouriteTableView.reloadData()
    }
    func setFont() {
        let labels = [lblNoLikedEvent, lblFindEventNearYou, lblVenuNoLikeEvent]
        for label in labels {
            label?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
            label?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        let lbls = [lblDescription, lblVenuDescription]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        lblVenuSuggestionForYou.font = UIFont.setFont(fontType: .bold, fontSize: .eighteen)
        lblVenuSuggestionForYou.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
    }
    func setNavigationBar() {
        vwNavigationView.lblTitle.text = FAVOURITE
        vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        vwNavigationView.imgBack.image = UIImage(named: MENU_ICON)
        vwNavigationView.btnBack.isHidden =  false
        vwNavigationView.delegateBarAction = self
    }
    func setCollectionView() {
        findEventCollectionView.delegate = self
        findEventCollectionView.dataSource = self
    }
    func getFavouriteList() {
        if Reachability.isConnectedToNetwork() {
            self.view.showLoading(centreToView: self.view)
            viewModel.getFavouriteList(favouriteModel: viewModel.favouriteModel, completion: { isTrue, message in
                if isTrue {
                    DispatchQueue.main.async {
                        self.favouriteTableView.reloadData()
                        self.view.stopLoading()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: message)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    func getVenueList() {
        if Reachability.isConnectedToNetwork() {
            self.view.showLoading(centreToView: self.view)
            viewModel.getVenueList(venueModel: viewModel.venueModel, completion: { isTrue, message in
                if isTrue {
                    DispatchQueue.main.async {
                        self.favouriteTableView.reloadData()
                        self.view.stopLoading()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: message)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
}
// MARK: - Actions
extension FavouriteVC {
    @IBAction func actionSegmentController(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            viewModel.isForVenue = false
            topConstraintTblView.constant = 5
            self.vwNoLikedEventView.isHidden = true
            self.vwVenueView.isHidden = true
            self.favouriteTableView.reloadData()
            let indexPath = IndexPath.init(row: viewModel.eventScrollToValue, section: 0)
           // if viewModel.eventScrollToValue <= self.favouriteTableView.numberOfRows(inSection: 0) {
            if self.favouriteTableView.visibleCells.indices.contains(viewModel.eventScrollToValue) {
                self.favouriteTableView.scrollToRow(at: indexPath, at: .none, animated: false)
            }
        case 1:
            viewModel.isForVenue = true
            topConstraintTblView.constant = viewModel.arrVenueList.isEmpty ? 300 : 5
            self.vwNoLikedEventView.isHidden = !(viewModel.arrVenueList.isEmpty)
//            self.vwVenueView.isHidden = false
            self.favouriteTableView.reloadData()
            let indexPath = IndexPath.init(row: viewModel.venueScrollToValue, section: 0)
            //if viewModel.venueScrollToValue <= self.favouriteTableView.numberOfRows(inSection: 0) {
              if self.favouriteTableView.visibleCells.indices.contains(viewModel.venueScrollToValue) {
                self.favouriteTableView.scrollToRow(at: indexPath, at: .none, animated: false)
            }
        default:
            break
        }
    }
    func loadMoreData() {
        if viewModel.isForVenue && viewModel.arrVenueList.isEmpty {
            if viewModel.arrSuggestionsList.count < viewModel.totalPageVenue {
                print("venue load more data")
                viewModel.venueModel.page += 1
                getVenueList()
            }
        } else if !viewModel.isForVenue {
            if viewModel.arrFavouriteList.count < viewModel.totalPageEvent {
                print("event load more data")
                viewModel.favouriteModel.page += 1
                getFavouriteList()
            }
        } else {
            if viewModel.arrVenueList.count < viewModel.totalPageVenue {
                print("venue load more data")
                viewModel.venueModel.page += 1
                getVenueList()
            }
        }
    }
    func btnLikeAction(indexPath: IndexPath) {
        var eventId: Int = 0
        if viewModel.isForVenue && viewModel.arrVenueList.isEmpty {
            eventId = viewModel.arrSuggestionsList[indexPath.row].event?.id ?? 0
        } else if !viewModel.isForVenue {
            eventId = viewModel.arrFavouriteList[indexPath.row].eventId ?? 0
        } else {
            eventId = viewModel.arrVenueList[indexPath.row].id ?? 0
        }
        // API Calling for Dislike the Event
        if Reachability.isConnectedToNetwork() {
            self.view.showLoading(centreToView: self.view)
            AppShareData().commanEventLikeApiCall(
                likeStatus: false,
                eventId: eventId,
                completion: { isTrue, message in
                    if isTrue {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            if self.viewModel.isForVenue && self.viewModel.arrVenueList.isEmpty {
                                self.viewModel.arrSuggestionsList.removeAll()
                                self.getSuggestionsList(categoryId: 3)
                            } else if self.viewModel.isForVenue {
                                self.viewModel.arrVenueList.removeAll()
                                self.getVenueList()
                            } else {
                                self.viewModel.arrFavouriteList.removeAll()
                                self.getFavouriteList()
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            self.showToast(message: message)
                        }
                    }
                }
            )
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    func btnShareAction(index: Int) {
        var eventDetail: GetFavouriteItem?
        if viewModel.isForVenue && viewModel.arrVenueList.isEmpty {
            let data = viewModel.arrSuggestionsList[index]
            self.shareEventDetailData(
                eventStartDate: data.date?.eventStartDate ?? "",
                eventEndDate: data.date?.eventEndDate ?? "",
                eventCoverImage: data.coverImage?.eventCoverImage ?? "",
                eventTitle: data.event?.title ?? "",
                eventStartTime: data.date?.eventStartTime ?? "",
                eventEndTime: data.date?.eventEndTime ?? "",
                eventDescription: data.event?.eventDescription
            )
        } else if !viewModel.isForVenue  {
            eventDetail = viewModel.arrFavouriteList[index]
            if let eventDetail = eventDetail {
                self.shareEventDetailData(
                    eventStartDate: "-",
                    eventEndDate: "-",
                    eventCoverImage: eventDetail.coverImage?.eventCoverImage,
                    eventTitle: eventDetail.eventTitle,
                    eventStartTime: "-",
                    eventEndTime: "-",
                    eventDescription: nil
                )
            }
        } else {
            let data = viewModel.arrVenueList[index]
            self.shareEventDetailData(
                eventStartDate: "-",
                eventEndDate: "-",
                eventCoverImage: data.image ?? "-",
                eventTitle: data.venueName ?? "",
                eventStartTime: "-",
                eventEndTime: "-",
                eventDescription: nil
            )
        }
    }
    func navigateToDetailVc(index: IndexPath) {
        if let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC {
            if viewModel.isForVenue && viewModel.arrVenueList.isEmpty {
                if viewModel.arrSuggestionsList.indices.contains(index.row) {
                    view.viewModel.eventId = viewModel.arrSuggestionsList[index.row].event?.id
                }
            } else if !viewModel.isForVenue {
                if viewModel.arrFavouriteList.indices.contains(index.row) {
                    view.viewModel.eventId = viewModel.arrFavouriteList[index.row].eventId
                }
            } else {
                if viewModel.arrVenueList.indices.contains(index.row) {
                    view.viewModel.eventId = viewModel.arrVenueList[index.row].id ?? 0
                }
            }
            if !(viewModel.isForVenue && !viewModel.arrVenueList.isEmpty) {
                funcCallApiForEventDetail(eventId: view.viewModel.eventId, view: view)
            }
        }
    }
    func funcCallApiForEventDetail(eventId:Int?, view: EventDetailVC) {
        if let eventId = eventId {
            if Reachability.isConnectedToNetwork() //check internet connectivity
            {
                self.view.showLoading(centreToView: self.view)
                self.viewModel.dispatchGroup.enter()
                viewModel.GetEventDetailApi(eventId: eventId, complition: { isTrue, messageShowToast in
                    if isTrue == true {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            self.showToast(message: messageShowToast)
                        }
                    }
                })
            } else {
                DispatchQueue.main.async {
                    self.view.stopLoading()
                    self.showToast(message: ValidationConstantStrings.networkLost)
                }
            }
            self.viewModel.dispatchGroup.notify(queue: .main) {
                var numberOfPage = 0
                if self.viewModel.eventDetail?.eventCoverImageObj?.eventCoverImage != nil || self.viewModel.eventDetail?.eventCoverImageObj?.eventCoverImage != ""{
                    numberOfPage = (self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0) + 1
                }else{
                    numberOfPage = self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0
                }
                // Here we are saving number of pages for page control UI on detail screen, We need to store it for first time only.
                AppShareData.sharedObject().saveNumOfPage(numOfPage: numberOfPage)
                view.viewModel.eventDetail = self.viewModel.eventDetail
                self.navigationController?.pushViewController(view, animated: false)
            }
        }
    }
    func getSuggestionsList(categoryId: Int) {
        if Reachability.isConnectedToNetwork() { //check internet connectivity
            DispatchQueue.main.async { [self] in
                self.view.showLoading(centreToView: self.view)
            }
            viewModel.eventDetailViewModel.GetEventSuggestedCategory(categoryId: categoryId) { isTrue, messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                        self.viewModel.arrSuggestionsList.append(contentsOf: self.viewModel.eventDetailViewModel.arrEventData)
                        self.view.stopLoading()
                        self.favouriteTableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    func updateData() {
        viewModel.arrFavouriteList.removeAll()
        viewModel.arrVenueList.removeAll()
        viewModel.arrSuggestionsList.removeAll()
        self.view.showLoading(centreToView: self.view)
        viewModel.venueModel.page = 1
        viewModel.favouriteModel.page = 1
        getFavouriteList()
        getVenueList()
        getSuggestionsList(categoryId: 3)
    }
}

// MARK: - TableView Delegate
extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = UILabel()
        label.frame = CGRect.init(x: 16, y: 0, width: headerView.frame.width-16, height: headerView.frame.height)
        label.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        label.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        label.text = "Suggestions for you"
        headerView.addSubview(label)
        if viewModel.isForVenue && viewModel.arrVenueList.isEmpty {
            return headerView
        } else {
            headerView.isHidden = true
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel.isForVenue && viewModel.arrVenueList.isEmpty {
            return 40
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isForVenue && viewModel.arrVenueList.isEmpty {
            print("arr suggestion data in numberOfRowsInSection count:", viewModel.arrSuggestionsList.count)
            return self.viewModel.arrSuggestionsList.count
        } else if !viewModel.isForVenue {
            print("arr fav data in numberOfRowsInSection")
            return viewModel.arrFavouriteList.count
        } else {
            print("else in numberOfRowsInSection")
            return viewModel.arrVenueList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath) as? FavouriteTableViewCell {
            if  viewModel.isForVenue && viewModel.arrVenueList.isEmpty {
                if viewModel.arrSuggestionsList.indices.contains(indexPath.row){
                    print("arr suggestion data in cellForRowAt")
                    cell.getSuggestionsData = self.viewModel.arrSuggestionsList[indexPath.row]
                }
            } else if !viewModel.isForVenue {
                if viewModel.arrFavouriteList.indices.contains(indexPath.row){
                    print("arr fav data in cellForRowAt")
                    cell.getFavouriteData =  viewModel.arrFavouriteList[indexPath.row]
                }
            } else {
                if viewModel.arrVenueList.indices.contains(indexPath.row){
                    print("arr venue data in cellForRowAt")
                    cell.getVenueData = viewModel.arrVenueList[indexPath.row]
                }
            }
            cell.lblFavoriteDate.isHidden = viewModel.isForVenue
            cell.likeButtonPressed = {
                self.btnLikeAction(indexPath: indexPath)
            }
            cell.shareButtonPressed = {
                self.btnShareAction(index: indexPath.row)
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailVc(index: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("in \(indexPath.row)")
        let lastSectionIndex = favouriteTableView.numberOfSections - 1
        let lastRowIndex = favouriteTableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            self.loadMoreData()
        }
        if viewModel.isForVenue {
            viewModel.venueScrollToValue = lastRowIndex
        } else {
            viewModel.eventScrollToValue = lastRowIndex
        }
    }
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FavouriteVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindEventCollectionViewCell", for: indexPath) as! FindEventCollectionViewCell
        let data = collectionData[indexPath.row]
        cell.lblTitle.text = data
        return cell
    }
}
// MARK: - NavigationBarViewDelegate
extension FavouriteVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        let sideMenu = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sideMenu.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}
