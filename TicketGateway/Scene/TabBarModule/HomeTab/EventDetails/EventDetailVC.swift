//
//  EventDetailVC.swift
//  TicketGateway
//
//  Created by Apple  on 05/05/23.
//
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name
// swiftlint: disable trailing_whitespace
// swiftlint: disable comment_spacing
// swiftlint: disable opening_brace
import UIKit
import iOSDropDown
import AdvancedPageControl
import SVProgressHUD
import SDWebImage
import EventKitUI

protocol EventDetailVCProtocol:class{
    func updateData()
}

class EventDetailVC: UIViewController, UITextFieldDelegate{
    
    //MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageConrtrolEventImages: AdvancedPageControlView!
    @IBOutlet weak var collvwEventImages: UICollectionView!
    @IBOutlet weak var heightOfSuggestedOrganisedEvent: NSLayoutConstraint!
    @IBOutlet weak var stackVw: UIStackView!
    @IBOutlet weak var vwEventName: UIView!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblSuggestedEvent: EventsOrganizesListTableView!
    @IBOutlet weak var collVwTags: EventTagList!
    @IBOutlet weak var imgOrganiser: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblTicketSale: UILabel!
    @IBOutlet weak var lblSelectDateTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblFullAddress: UILabel!
    @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblRefundpolicyDisc: UILabel!
    @IBOutlet weak var lblAboutOfEvent: UILabel!
    @IBOutlet weak var lblAboutDiscripation: UILabel!
    @IBOutlet weak var lblOrganizer: UILabel!
    @IBOutlet weak var lblOrganiserName_Company: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblTags: UILabel!
    @IBOutlet weak var lblSuggestionForYou: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOnTicketGateway: UILabel!
    @IBOutlet weak var btnReadMore: CustomButtonNormalWithBorder!
    @IBOutlet weak var btnFollowing: CustomButtonGradiant!
    @IBOutlet weak var btnBookTickets: CustomButtonGradiant!
    @IBOutlet weak var btnAddToCalender: CustomButtonNormalWithBorder!
    @IBOutlet weak var btnShowMap: CustomButtonNormalWithBorder!
    @IBOutlet weak var txtDate: DropDown!
    @IBOutlet weak var txtLocation: DropDown!
    @IBOutlet weak var btnSelectLocationAccordingToDate: UIButton!
    @IBOutlet weak var btnSelectDate: UIButton!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var vwSelectDateView: UIView!
    @IBOutlet weak var vwSelectLocationView: UIView!
    @IBOutlet weak var vwSelectLocationAndDateView: UIView!

    @IBOutlet weak var dateAndLocationStackView: UIStackView!
    @IBOutlet weak var vwStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var tagsView: UIView!
    @IBOutlet weak var organizersView: UIView!
    @IBOutlet weak var suggestionsForYouView: UIView!
    
    @IBOutlet weak var vwOrganiserMainView: setBorderView!
    
    @IBOutlet weak var pageConrtrolEventImagesHt:NSLayoutConstraint!
    @IBOutlet weak var pageControllerParentView:UIView!
    @IBOutlet weak var pageConrtrolEventTop:NSLayoutConstraint!
    
    // MARK: - Variables
    var viewModel = EventDetailViewModel()
    weak var delegate : EventDetailVCProtocol?
    let store = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Imp line to set drawer at initial
        pageConrtrolEventImages.drawer = ScaleDrawer()
        self.funcCallApi()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

//MARK: - Functions
extension EventDetailVC {
    func loadData(){
//        viewModel.isLiked = viewModel.eventDetail?.isLike ?? false
//        self.funcCallApi()
        self.setUp()
        self.addTapGestureToOrganiserView()
    }
    
    func setUp(){
        self.setUi()
        self.tblSuggestedEvent.delegateShareAction = self
        self.tblSuggestedEvent.delegateViewMore = self
        self.collvwEventImages.reloadData()
        self.txtDate.delegate = self
        self.txtLocation.delegate = self
        self.collVwTags.configure()
        self.tblSuggestedEvent.configure(isComingFrom: IsComingFromForEventsOrganizesListTableView.EventDetail)
        self.tblSuggestedEvent.tableDidSelectAtIndex = { index in
            if self.viewModel.arrEventData.indices.contains(index.row){
                self.viewModel.eventId = self.viewModel.arrEventData[index.row].event?.id
                self.viewModel.eventDetail = nil
                self.funcCallApi()
                self.setUp()
                self.scrollView.setContentOffset(.zero, animated: false)
            }
        }
        self.tblSuggestedEvent.reloadData()
        self.tblSuggestedEvent.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfSuggestedOrganisedEvent.constant = self.tblSuggestedEvent.contentSize.height
        self.tblSuggestedEvent.layoutIfNeeded()
        self.navigationView.delegateBarAction = self
        self.navigationView.btnRight.isHidden = false
        self.navigationView.btnSecRight.isHidden = false
        self.navigationView.btnRight.addTarget(self, action: #selector(btnShareAction(_:)), for: .touchUpInside)
        self.navigationView.lblSeprator.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        btnAddToCalender.setTitles(text: "Add ", textColour: UIColor.setColor(colorType: .tgBlue), borderColour: UIColor.setColor(colorType: .tgBlue))
        btnAddToCalender.addRightIcon(image: UIImage.init(named: "calendar_blue"))
        btnShowMap.setTitles(text: "Show Map", textColour: UIColor.setColor(colorType: .tgBlue), borderColour: UIColor.setColor(colorType: .tgBlue))
        btnReadMore.setTitles(text: "Read More", textColour: UIColor.setColor(colorType: .tgBlue), borderColour: UIColor.setColor(colorType: .tgBlue))
        
        navigationView.lblTitle.text = "Event"
        navigationView.btnBack.isHidden = false
        navigationView.btnRight.setImage(UIImage(named: "upload_ip"), for: .normal)
//        self.navigationView.btnSecRight.setImage(UIImage(named: "favSele_ip"), for: .selected)
        print("viewModel.eventDetail?.isLike", viewModel.eventDetail?.isLike)
        self.navigationView.btnSecRight.setImage(UIImage(named: (viewModel.eventDetail?.isLike ?? false) ? "favSele_ip" : "favUnSele_ip"), for: .normal)
        navigationView.btnSecRight.addTarget(self, action: #selector(btnLikeAction(_:)), for: .touchUpInside)
        navigationView.delegateBarAction = self
        btnFollowing.setTitles(text: "Following", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        btnBookTickets.setTitles(text: "Tickets", font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .titleColourDarkBlue))
        btnBookTickets.addLeftIcon(image: UIImage(named: "ticketBlack"))
        [self.btnFollowing, self.btnReadMore, self.btnAddToCalender, self.btnShowMap,
         self.btnBookTickets, self.btnSelectDate, self.btnSelectLocationAccordingToDate].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.toSetPageControll()
        self.dropDown()
    }
    
    func addTapGestureToOrganiserView() {
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(navigateToProfileForOrganiser(_:)))
        self.vwOrganiserMainView.addGestureRecognizer(gesture)
    }
    
    @objc func navigateToProfileForOrganiser(_ sender: UITapGestureRecognizer) {
        let eventDetail = self.viewModel.eventDetail
        if let vc = self.createView(storyboard: .profile, storyboardID: .ManageEventProfileVC) as? ManageEventProfileVC {
            vc.isComingFromOranizer = true
            vc.name = eventDetail?.organizer?.name ?? ""
            if let url = URL(string: eventDetail?.organizer?.profileImage ?? "") {
                vc.imageUrl = url
            }
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
      func funcCallApi(){
          if self.viewModel.eventDetail != nil {
              DispatchQueue.main.async {
                  self.collvwEventImages.reloadData()
                  self.setData()
                  self.loadData()
                  if self.viewModel.eventDetail?.is_multi_location == true {
                      self.dateAndLocationStackView.isHidden = false
                     self.vwStackHeight.constant = 155
                  } else {
                      self.dateAndLocationStackView.isHidden = true
                      self.vwStackHeight.constant = 0

                  }
              }
              
              if let eventCategoryId = self.viewModel.eventDetail?.event?.eventCategoryID{
                  self.viewModel.suggestedEventCategoryId = eventCategoryId
                  self.funcCallApiForEventCategory(categoryId: eventCategoryId)
              }
          }else{
              if self.viewModel.eventId != nil{
                if Reachability.isConnectedToNetwork() //check internet connectivity
                {
                    vwEventName.showLoading(centreToView: self.view)
                    viewModel.GetEventDetailApi(complition: { isTrue, messageShowToast in
                        if isTrue == true {
                            self.vwEventName.stopLoading()
                            DispatchQueue.main.async {
                                let numberOfPage = self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0
                                AppShareData.sharedObject().saveNumOfPage(numOfPage: numberOfPage)
                                self.collvwEventImages.reloadData()
                                self.setData()
                                self.loadData()
                                if self.viewModel.eventDetail?.is_multi_location == true {
                                    self.dateAndLocationStackView.isHidden = false
                                   self.vwStackHeight.constant = 155
                                } else {
                                    self.dateAndLocationStackView.isHidden = true
                                    self.vwStackHeight.constant = 0

                                }
                            }
                            
                            if let eventCategoryId = self.viewModel.eventDetail?.event?.eventCategoryID{
                                self.viewModel.suggestedEventCategoryId = eventCategoryId
                                self.funcCallApiForEventCategory(categoryId: eventCategoryId)
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.vwEventName.stopLoading()
                                self.showToast(message: messageShowToast)
                            }
                        }
                    })
                } else {
                    DispatchQueue.main.async {
                        self.vwEventName.stopLoading()
                        self.showToast(message: ValidationConstantStrings.networkLost)
                    }
                }
            }
          }
    }
    
    func funcCallApiForEventCategory(categoryId:Int){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            DispatchQueue.main.async { [self] in
                self.tblSuggestedEvent.isHidden = true
                vwEventName.showLoading(centreToView: self.view)
            }
            viewModel.GetEventSuggestedCategory(categoryId: categoryId) { isTrue, messageShowToast in
                if isTrue == true {
                    self.vwEventName.stopLoading()
                    DispatchQueue.main.async {
                        self.tblSuggestedEvent.isHidden = false
                        self.tblSuggestedEvent.arrData = self.viewModel.arrEventData
                        self.tblSuggestedEvent.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.vwEventName.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.vwEventName.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightOfSuggestedOrganisedEvent.constant = tblSuggestedEvent.contentSize.height
        
    }
    
    func setUi(){
        self.lblFollowers.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblFollowers.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblEventName.font = UIFont.setFont(fontType: .bold, fontSize: .twentyFour)
        self.lblEventName.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblSelectDateTime.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblEventName.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblAboutOfEvent.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblAboutOfEvent.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblOrganizer.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblOrganizer.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblTags.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblTags.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblSuggestionForYou.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblSuggestionForYou.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblAboutDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblAboutDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblFullAddress.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFullAddress.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTime.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblTime.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblRefundpolicyDisc.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblRefundpolicyDisc.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblDate.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblDate.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblAddress.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblAddress.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblRefundPolicy.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblRefundPolicy.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblPrice.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblPrice.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblOnTicketGateway.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblOnTicketGateway.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
    func setData(){
        let eventDetail = self.viewModel.eventDetail
//        self.navigationView.btnSecRight.isSelected = eventDetail?.isLike ?? false
        self.lblPrice.text = "CAD$\(eventDetail?.ticketOnwards ?? 0) onwards"
        self.lblEventName.text = eventDetail?.event?.title ?? ""
        self.lblEventDate.text = "\(eventDetail?.eventDateObj?.eventStartDate?.getDateFormattedFrom() ?? "")" +  " " + "-" + " " + "\(eventDetail?.eventDateObj?.eventEndDate?.getDateFormattedFromTo() ?? "")"
        self.lblDate.text = ("\(eventDetail?.eventDateObj?.eventStartDate?.getDateFormattedFrom() ?? "")" +  " " + "to" + " " + "\(eventDetail?.eventDateObj?.eventEndDate?.getDateFormattedFromTo() ?? "")")
        self.lblTime.text = ("\(eventDetail?.eventDateObj?.eventStartTime?.getFormattedTime() ?? "")" +  " " + "-" + " " + "\(eventDetail?.eventDateObj?.eventEndTime?.getFormattedTime() ?? "")")
        self.lblAddress.text = eventDetail?.eventLocation?.eventAddress ?? ""
        self.lblFullAddress.text = (eventDetail?.eventLocation?.eventState ?? "") + " " + (eventDetail?.eventLocation?.eventAddress ?? "")
        self.lblRefundpolicyDisc.text = "Refunds" + " " + (eventDetail?.eventRefundPolicy?.policyDescription ?? "")
        
        //ABOUt US
        if (eventDetail?.organizer?.eventDescription != "") && (eventDetail?.organizer?.eventDescription != nil){
            self.aboutView.isHidden = false
            self.lblAboutDiscripation.text = eventDetail?.organizer?.eventDescription ?? ""
            
        }else{
            self.aboutView.isHidden = true
            self.lblAboutDiscripation.text = ""
        }
        
        //ORGANIZER
        self.lblOrganiserName_Company.text = eventDetail?.organizer?.name ?? ""
        self.lblFollowers.text = "\(eventDetail?.organizer?.followers ?? 0)  followers"
        if let imageUrl = eventDetail?.organizer?.profileImage {
            if imageUrl.contains(APIHandler.shared.previousBaseURL){
                let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.previousBaseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if let url = URL(string: APIHandler.shared.baseURL + imageUrl){
                    self.imgOrganiser.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                }else{
                    self.imgOrganiser.image = UIImage(named: "profile")
                }
            }else{
                if let url = URL(string: APIHandler.shared.baseURL + imageUrl){
                    self.imgOrganiser.sd_setImage(with: url, placeholderImage: UIImage(named: "homeDas"), options: SDWebImageOptions.continueInBackground)
                }else{
                    self.imgOrganiser.image = UIImage(named: "profile")
                }
            }
        } else {
            self.imgOrganiser.image = UIImage(named: "profile")
        }
        
        //TAGS
        if eventDetail?.eventTagsObj?.eventTags?.count != 0 && eventDetail?.eventTagsObj?.eventTags != nil{
            self.tagsView.isHidden = false
            self.collVwTags.setData(eventDetail: eventDetail)
        }else{
            self.tagsView.isHidden = true
        }
        self.dropDown()
    }
    
    func dropDown(){
        txtDate.optionArray = ["May 25 - May 30 6:00 AM - 7:00 AM", "May 25 - May 30 6:00 AM - 7:00 ", "May 25 - May 30 6:00 AM - 7:00 AM","May 25 - May 30 6:00 AM - 7:00 AM"]
        
        txtDate.optionIds = [1,23,54,22]
        txtDate.didSelect{(selectedText , index ,id) in
            self.txtDate.text = "\(selectedText)"
        }
        
        txtLocation.optionArray = ["Supermarket bar and Variety", "Supermarket bar and Variety", "Supermarket bar and Variety","Supermarket bar and Variety"]
        
        txtLocation.optionIds = [1,23,54,22]
        txtLocation.didSelect{(selectedText , index ,id) in
            self.txtLocation.text = "\(selectedText)"
        }
    }
}

//MARK: - Actions
extension EventDetailVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnBookTickets:
            self.btnBookTicket()
        case btnReadMore:
            self.addToCalenAction()
        case btnFollowing:
            self.addFollowingAction()
        case btnShowMap:
            self.btnShowMapAction()
        case btnAddToCalender:
            self.addToCalenAction()
        case btnSelectDate:
            self.txtDate.showList()
        case btnSelectLocationAccordingToDate:
            self.txtLocation.showList()
        default:
            break
        }
    }
    func a() {
        var dateComponents = DateComponents()
            dateComponents.year = 2020
            dateComponents.month = 1
            dateComponents.day = 1
            dateComponents.hour = 10
            dateComponents.minute = 30
            let startDate = Calendar.current.date(from: dateComponents)
            dateComponents.hour = 11
            let endDate = Calendar.current.date(from: dateComponents)
        let event: EKEvent = EKEvent(eventStore: self.store)
            event.title = "Concours de coinchée"
            event.startDate = startDate
            event.endDate = endDate
            event.notes = "Cantine scolaire de Goupillières"
      //  event.calendar = self.store.eventStore.defaultCalendarForNewEvents
    }
    private func getCurrentDateComponent(date: Date) -> DateComponents {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
       return components
    }
    
    
    func addToCalenAction() {
        DispatchQueue.main.async {
          self.store.requestAccess(to: .event, completion: { sucess, err in
            if sucess, err == nil {
              DispatchQueue.main.async {
                var identifier: String?
                let newEvent = EKEvent(eventStore: self.store)
                let eventObject = self.viewModel.eventDetail?.eventDateObj
                print("startDate", eventObject?.eventStartDate as Any)
                print("endDate", eventObject?.eventEndDate as Any)
                print("startTime", eventObject?.eventStartTime as Any)
                print("endTime", eventObject?.eventEndTime as Any)
                let startDateTime = self.combineDateWithTime(
                  date: eventObject?.eventStartDate?.convertToDate() ?? Date(),
                  time: eventObject?.eventStartTime?.convertStringToDateForTime() ?? Date()
                )
                let endDateTime = self.combineDateWithTime(
                  date: eventObject?.eventEndDate?.convertToDate() ?? Date(),
                  time: eventObject?.eventEndTime?.convertStringToDateForTime() ?? Date()
                )
                newEvent.title = self.viewModel.eventDetail?.event?.title
                newEvent.startDate = startDateTime
                newEvent.endDate = endDateTime
                let vc = EKEventViewController()
                vc.delegate = self
                vc.event = newEvent
                let navVC = UINavigationController(rootViewController: vc)
                self.present(navVC, animated: true)
                do {
                  try self.store.save(newEvent, span: .thisEvent, commit: true)
                  identifier = newEvent.eventIdentifier
                  print("Saved event with ID: \(String(describing: newEvent.eventIdentifier))")
                  // The event gets created and the ID is printed to the console but at a time when the whole function already has returned (nil)
                } catch let error as NSError {
                  print("Failed to save event with error: \(error)")
                }
              }
            } else {
            }
          })
        }
      }
    
    func combineDateWithTime(date: Date, time: Date) -> Date? {
        print("DATE:---:", date)
        print("TIME:---:", time)
        var calendar = NSCalendar.autoupdatingCurrent
        calendar.locale = Locale(identifier: "en_US_POSIX")
        calendar.timeZone = TimeZone(abbreviation: "GMT") ?? .current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        var mergedComponents = DateComponents()
        mergedComponents.year = dateComponents.year
        mergedComponents.month = dateComponents.month
        mergedComponents.day = dateComponents.day
        mergedComponents.hour = timeComponents.hour
        mergedComponents.minute = timeComponents.minute
        return calendar.date(from: mergedComponents)
    }
    
    func btnBookTicket() {
//        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketVC) as? EventBookingTicketVC{
//            view.viewModel.eventDetail = self.viewModel.eventDetail
//            view.viewModel.eventId = self.viewModel.eventId
//            view.viewModel.ticketId = "\(self.viewModel.eventDetail?.event?.ticketID ?? 0)"
//           // view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
//            self.navigationController?.pushViewController(view, animated: true)
//        }
        
        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketOnApplyCouponVC) as? EventBookingTicketOnApplyCouponVC{
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.eventId = self.viewModel.eventId
            view.viewModel.ticketId = "\(self.viewModel.eventDetail?.event?.ticketID ?? 0)"
           // view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func addFollowingAction() {
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            if let organizerId = self.viewModel.eventDetail?.organizer?.id{
                vwEventName.showLoading(centreToView: self.view)
                viewModel.followUnFollowApi(organizerId: organizerId, complition: { isTrue, messageShowToast in
                    if isTrue{
                        DispatchQueue.main.async {
                            self.vwEventName.stopLoading()
                            if messageShowToast == self.viewModel.isFollow.rawValue{
                                self.btnFollowing.setTitle("Following", for: .normal)
                            }else{
                                self.btnFollowing.setTitle("UnFollowing", for: .normal)
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.vwEventName.stopLoading()
                            self.showToast(message: messageShowToast)
                        }
                    }
                })
            } else {
                DispatchQueue.main.async {
                    self.vwEventName.stopLoading()
                    self.showToast(message: ValidationConstantStrings.networkLost)
                }
            }
        }
    }
    
    func btnShowMapAction() {
        let view = createView(storyboard: .home, storyboardID: .EventMapVC) as! EventMapVC
        let eventLocation = self.viewModel.eventDetail?.eventLocation
        print("---------", eventLocation?.latitude)
        print("---------", eventLocation?.longitude)
        view.latitude =  eventLocation?.latitude ?? 00.0
        view.longitude =  eventLocation?.longitude ?? 00.0
        view.location = eventLocation?.eventAddress ?? ""
        self.navigationController?.pushViewController(view, animated: true)
    }

    @objc func btnShareAction(_ sender: UIButton) {
        let eventDetail = self.viewModel.eventDetail
        let text =  "Event Name:\(eventDetail?.event?.title ?? "") + Location: \( eventDetail?.eventLocation?.eventAddress ?? "")"
        let textToShare = [ text ]
//        let image = UIImage(named: "Image")
//        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func btnLikeAction(_ sender: UIButton) {
        viewModel.eventDetail?.isLike?.toggle()
        if Reachability.isConnectedToNetwork() //check internet connectivity
           {
          //  parentView.showLoading(centreToView: self.view)
            let eventId = self.viewModel.eventDetail?.event?.id ?? 0
            viewModel.favouriteApi(likeStatus: viewModel.eventDetail?.isLike ?? false, eventId: eventId, complition: { isTrue, messageShowToast in
                DispatchQueue.main.async {
                    let image =  (self.viewModel.eventDetail?.isLike ?? false) ? UIImage(named: "favSele_ip") : UIImage(named: "favUnSele_ip")
                        self.navigationView.btnSecRight.setImage(image, for: .normal)
                }
            })
        } else {
            
                self.showToast(message: ValidationConstantStrings.networkLost)
        }
        
    }
}

// MARK: - PageControl
extension EventDetailVC {
    func toSetPageControll() {
        if (self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages == nil) ||
            (self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count == 0) ||
            (self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count == 1) {
            self.pageConrtrolEventTop.constant = 0
            self.pageControllerParentView.isHidden = false
        } else {
            self.pageConrtrolEventTop.constant = 10
            let numberOfPage = self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0
            AppShareData.sharedObject().saveNumOfPage(numOfPage: numberOfPage)
            pageConrtrolEventImages.drawer = ScaleDrawer(numberOfPages: numberOfPage)
            self.pageControllerParentView.isHidden = true
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        pageConrtrolEventImages.setPage(Int(round(offSet / width)))
    }
}

//MARK: - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
extension EventDetailVC : UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        var imgCount = self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0
        if imgCount == 0{
            if self.viewModel.eventDetail?.eventCoverImageObj?.eventCoverImage != nil{
                return 1
            }
            return 0
        }else{
            return imgCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventImageCell", for: indexPath) as! EventImageCell
        cell.setData(index: indexPath.row, eventDetail: self.viewModel.eventDetail)
        //  cell.imgEvents.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
//MARK: - EKEventViewDelegate
extension EventDetailVC: EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true)
    }
    
    
}
//MARK: -
extension EventDetailVC:  ActivityController, EventsOrganizesListTableViewProtocol{
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
            var desc = "\nEvent Description:- " + eventDesc
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
    
    func tapActionOfViewMoreEvents(index: Int) {
        let view = self.createView(storyboard: .home, storyboardID: .ViewMoreEventsVC) as? ViewMoreEventsVC
        view?.viewModel.isComingFrom = .EventDetail
        view?.delegate = self
        view?.viewModel.categoryId = self.viewModel.suggestedEventCategoryId
        //view?.viewModel.index = index
        //view?.viewModel.arrEventCategory = self.viewModel.arrEventCategory
        self.navigationController?.pushViewController(view!, animated: true)
    }
  
}

//MARK: - ViewMoreEventsVCProtocol
extension EventDetailVC: ViewMoreEventsVCProtocol{
    func reloadView(eventId: Int?) {
        self.viewModel.eventId = eventId
        self.loadData()
    }
}


//MARK: - NavigationBarViewDelegate
extension EventDetailVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.delegate?.updateData()
        self.navigationController?.popViewController(animated: true)
    }
    
}
