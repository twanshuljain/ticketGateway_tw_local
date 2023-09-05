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
        onAppearActions()
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
    func onAppearActions() {
        viewModel.arrFavouriteList.removeAll()
        viewModel.arrVenueList.removeAll()
        viewModel.venueModel.page = 1
        viewModel.favouriteModel.page = 1
        getFavouriteList()
        getVenueList()
    }
    func shareEventDetailData(eventDetail: GetFavouriteItem) {
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
}
// MARK: - Actions
extension FavouriteVC {
    @IBAction func actionSegmentController(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            viewModel.isForVenue = false
           // self.vwNoLikedEventView.isHidden = true
            self.vwVenueView.isHidden = true
            self.favouriteTableView.reloadData()
        case 1:
            viewModel.isForVenue = true
            // self.vwNoLikedEventView.isHidden = false
            self.vwVenueView.isHidden = false
            self.favouriteTableView.reloadData()
        default:
            break
        }
    }
    func loadMoreData() {
        if viewModel.isForVenue {
            if viewModel.arrVenueList.count < viewModel.totalPageVenue {
                print("venue load more data")
                viewModel.venueModel.page += 1
                getVenueList()
            }
        } else {
            if viewModel.arrFavouriteList.count < viewModel.totalPageEvent {
                print("event load more data")
                viewModel.favouriteModel.page += 1
                getFavouriteList()
            }
        }
    }
    func btnLikeAction(indexPath: IndexPath) {
        let eventId = viewModel.isForVenue ? viewModel.arrVenueList[indexPath.row].eventId : viewModel.arrFavouriteList[indexPath.row].eventId
        // API Calling for Dislike the Event
        if Reachability.isConnectedToNetwork() {
            self.view.showLoading(centreToView: self.view)
            AppShareData().commanEventLikeApiCall(
                likeStatus: false,
                eventId: eventId ?? 0,
                completion: { isTrue, message in
                    if isTrue {
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            if self.viewModel.isForVenue {
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
    func navigateToDetailVc(index: IndexPath) {
        if let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC {
            if viewModel.arrFavouriteList.indices.contains(index.row) {
                view.viewModel.eventId = viewModel.arrFavouriteList[index.row].eventId
            }
            funcCallApiForEventDetail(eventId: view.viewModel.eventId, view: view)
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
                let numberOfPage = self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0
                // Here we are saving number of pages for page control UI on detail screen, We need to store it for first time only.
                AppShareData.sharedObject().saveNumOfPage(numOfPage: numberOfPage)
                view.viewModel.eventDetail = self.viewModel.eventDetail
                self.navigationController?.pushViewController(view, animated: false)
            }
        }
    }
}

// MARK: - TableView Delegate
extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isForVenue ? viewModel.arrVenueList.count : viewModel.arrFavouriteList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath) as! FavouriteTableViewCell
        cell.getFavouriteData = viewModel.isForVenue ? viewModel.arrVenueList[indexPath.row] : viewModel.arrFavouriteList[indexPath.row]
        cell.lblFavoriteDate.isHidden = viewModel.isForVenue
        cell.likeButtonPressed = {
            self.btnLikeAction(indexPath: indexPath)
        }
        cell.shareButtonPressed = {
            let eventDetail = self.viewModel.isForVenue ? self.viewModel.arrVenueList[indexPath.row] : self.viewModel.arrFavouriteList[indexPath.row]
            self.shareEventDetailData(eventDetail: eventDetail)
        }
        return cell
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
