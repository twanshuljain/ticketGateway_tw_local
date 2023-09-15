//
//  EventSearchVC.swift
//  TicketGateway
//
//  Created by Apple  on 22/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit
import iOSDropDown
import SideMenu
import SVProgressHUD
class EventSearchHomeVC: UIViewController,  UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var collVwEventSubCategory: EventSearchCategoryCollectionList!
    @IBOutlet weak var btnReset: CustomButtonNormal!
    @IBOutlet weak var btnShowResult: CustomButtonGradiant!
    @IBOutlet weak var vwBlack: UIView!
    @IBOutlet weak var tblEvents: EventsOrganizesListTableView!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var lblTotalEvents: UILabel!
    @IBOutlet weak var btnFIlter: UIButton!
    @IBOutlet weak var collVwEvent: EventSearchCategoryCollectionList!
    @IBOutlet weak var btnSortByRelevence: UIButton!
    @IBOutlet weak var txtSortByRelevance: DropDown!
    @IBOutlet weak var vwCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var vwSortByRelevanceHeight: NSLayoutConstraint!
    weak var delegate : EventDetailVCProtocol?
    // MARK: - Variables
    private let viewModel = GetEventCategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.isLikedAnyEvent = false
        self.vwCollectionViewHeight.constant = 0
        self.vwSortByRelevanceHeight.constant = 0
        self.vwBlack.isHidden =  true
        self.tblEvents.delegateLikeAction = self
        self.tblEvents.delegateShareAction = self
        self.vwSearchBar.delegate = self
        self.vwSearchBar.vwLocation.isHidden = true
        self.vwSearchBar.btnMenu.setImage(UIImage(named: BACK_ARROW_ICON), for: .normal)
        self.collVwEvent.configure()
        self.tblEvents.configure(isComingFrom: IsComingFromForEventsOrganizesListTableView.EventSearch)
        self.collVwEvent.isFromCategory = true
        self.collVwEventSubCategory.configure()
        self.collVwEventSubCategory.isFromCategory = false
        [self.btnReset, self.btnShowResult, self.btnSortByRelevence, self.btnFIlter,].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.tblEvents.tableDidSelectAtIndex = {  index in
            let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC
            if self.viewModel.arrSearchData.indices.contains(index.row){
                view?.viewModel.eventId = self.viewModel.arrSearchData[index.row].event?.id
                self.navigationController?.pushViewController(view!, animated: true)
            }
        }
        self.collVwEvent.collVwDidSelectAtIndex = { obj in
            print("--------------------------------------------",obj)
            self.vwBlack.isHidden =  false
        }
        self.collVwEventSubCategory.collectionViewLayout = createLeftAlignedLayout()
        self.btnShowResult.setTitles(text: SHOW_RESULT, font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        self.btnReset.setTitles(text: RESET, font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .tgBlue))
        self.viewModel.funcCallApi(vc: self)
        self.funcSetDropDown()
        self.setSearchBar()
    }
    func setSearchBar() {
        vwSearchBar.txtSearch.becomeFirstResponder()
        tblEvents.isFromSearch = true
        vwSearchBar.txtSearch.addTarget(self, action: #selector(searchAction(_:)), for: .allEditingEvents)
    }
    @objc func searchAction(_ sender: UITextField) {
        if Reachability.isConnectedToNetwork() // check internet connectivity
        {
            self.view.showLoading(centreToView: self.view)
            viewModel.getEventSearchApi(searchText: sender.text ?? "", complition: { isTrue, showMessage in
                if isTrue {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.tblEvents.arrSearchData = self.viewModel.arrSearchData
                        self.tblEvents.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.showToast(message: showMessage)
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
//MARK: - Functions
extension EventSearchHomeVC {
    func funcSetDropDown() {
        txtSortByRelevance.optionArray = ["Jan", "Feb", "Mar","April"]
        txtSortByRelevance.delegate = self
        txtSortByRelevance.optionIds = [1, 23, 54, 22]
        txtSortByRelevance.didSelect{ (selectedText , index ,id) in
            self.txtSortByRelevance.text = "\(selectedText)\(index)"
        }
    }
}
//MARK: - Actions
extension EventSearchHomeVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnReset:
            self.btnResetAction()
        case btnFIlter:
            self.btnFilterAction()
        case btnShowResult:
            break
           // self.btnShowResultAction()
        case btnSortByRelevence:
            self.btnSortByRelevenceAction()
        default:
            break
        }
    }
    func btnResetAction() {
        self.vwBlack.isHidden =  true
    }
    func btnFilterAction() {
        self.vwBlack.isHidden =  false
    }
    func btnSortByRelevenceAction() {
        self.txtSortByRelevance.showList()
    }
    func btnShowResultAction() {
//        self.collVwEvent.collVwDidSelectAtIndex = { obj in
//            self.callEventSearchCategoryApi(category: "\(obj.name ?? "")")
//            self.tblEvents.isFromSearch = false
//            self.vwSearchBar.txtSearch.resignFirstResponder()
//            self.tblEvents.reloadData()
//        }
//        self.vwBlack.isHidden =  true
    }
//    func callEventSearchCategoryApi(category: String) {
//        if Reachability.isConnectedToNetwork() // check internet connectivity
//        {
//            SVProgressHUD.show()
//            viewModel.getEventSearchCategoryApi(category: category, complition: { isTrue, showMessage in
//                if isTrue {
//                    SVProgressHUD.dismiss()
//                    self.tblEvents.arrDataCategorySearch = self.viewModel.arrSearchCategoryData
//                } else {
//                    DispatchQueue.main.async {
//                        SVProgressHUD.dismiss()
//                        self.showToast(message: showMessage)
//                    }
//                }
//            })
//        } else {
//            DispatchQueue.main.async {
//                SVProgressHUD.dismiss()
//                self.showToast(message: ValidationConstantStrings.networkLost)
//            }
//        }
//    }
}

// MARK: - CustomSearchMethodsDelegate
extension EventSearchHomeVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
        if viewModel.isLikedAnyEvent {
            self.delegate?.updateData()
        }
        self.navigationController?.popViewController(animated: true)
    }
    func rightButtonPressed(_ sender: UIButton) {
        print("hello")
    }
    private func createLeftAlignedLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(          // this is your cell
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(40),         // variable width
                heightDimension: .absolute(50)          // fixed height
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),  // 100% width as inset by its Section
                heightDimension: .estimated(40)         // variable height; allows for multiple rows of items
            ),
            subitems: [item]
        )
        group.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 5)
        group.interItemSpacing = .fixed(10)         // horizontal spacing between cells
        return UICollectionViewCompositionalLayout(section: .init(group: group))
    }
}
extension EventSearchHomeVC: FavouriteAction {
    func toCallFavouriteaApi(eventDetail: GetEventModel, isForLocation: Bool) {
        // Condition for -> If user with guest login then like/unlike feature should not work.
        if (UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin)) {
            self.showToast(message: Unable_To_LikeFollow)
            return
        }
        viewModel.isLikedAnyEvent = true
        AppShareData().commanEventLikeApiCall(
            likeStatus: eventDetail.likeCountData?.isLiked ?? false,
            eventId: eventDetail.event?.id ?? 0,
            completion: { _,_ in
            }
        )
    }
}
extension EventSearchHomeVC: ActivityController {
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
