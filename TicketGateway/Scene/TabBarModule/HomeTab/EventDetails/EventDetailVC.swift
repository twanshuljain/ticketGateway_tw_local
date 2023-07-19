//
//  EventDetailVC.swift
//  TicketGateway
//
//  Created by Apple  on 05/05/23.
//

import UIKit
import iOSDropDown
import AdvancedPageControl
import SVProgressHUD
import SDWebImage

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
    
    var viewModel = EventDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.funcCallApi()
        self.setUp()
    }
}

//MARK: - Functions
extension EventDetailVC {
    func setUp(){
        self.setUi()
        self.collvwEventImages.reloadData()
        self.txtDate.delegate = self
        self.txtLocation.delegate = self
        self.collVwTags.configure()
        self.tblSuggestedEvent.configure(isComingFrom: IsComingFromForEventsOrganizesListTableView.EventDetail)
        self.tblSuggestedEvent.tableDidSelectAtIndex = { index in
            if self.viewModel.arrEventData.indices.contains(index.row){
                self.viewModel.eventId = self.viewModel.arrEventData[index.row].event?.id
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
        self.navigationView.lblSeprator.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        btnAddToCalender.setTitles(text: "Add to Calender", textColour: UIColor.setColor(colorType: .TGBlue), borderColour: UIColor.setColor(colorType: .TGBlue))
        btnShowMap.setTitles(text: "Show Map", textColour: UIColor.setColor(colorType: .TGBlue), borderColour: UIColor.setColor(colorType: .TGBlue))
        btnReadMore.setTitles(text: "Read More", textColour: UIColor.setColor(colorType: .TGBlue), borderColour: UIColor.setColor(colorType: .TGBlue))
        
        navigationView.lblTitle.text = "Event"
        navigationView.btnBack.isHidden = false
        navigationView.btnRight.setImage(UIImage(named: "upload_ip"), for: .normal)
        navigationView.btnSecRight.setImage(UIImage(named: "favSele_ip"), for: .normal)
        navigationView.delegateBarAction = self
        btnFollowing.setTitles(text: "Following", font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        btnBookTickets.setTitles(text: "Tickets", font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .TiitleColourDarkBlue))
        btnBookTickets.addLeftIcon(image: UIImage(named: "ticketBlack"))
        [self.btnFollowing,self.btnReadMore,self.btnAddToCalender,self.btnBookTickets,btnSelectDate,btnSelectLocationAccordingToDate].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.toSetPageControll()
        self.dropDown()
    }
    
    func funcCallApi(){
        if let eventId = self.viewModel.eventId{
            if Reachability.isConnectedToNetwork() //check internet connectivity
            {
                SVProgressHUD.show()
                viewModel.GetEventDetailApi(complition: { isTrue, messageShowToast in
                    if isTrue == true {
                        SVProgressHUD.dismiss()
                        DispatchQueue.main.async {
                            self.collvwEventImages.reloadData()
                            self.setData()
                        }
                        if let eventCategoryId = self.viewModel.eventDetail?.event?.eventCategoryID{
                            self.viewModel.suggestedEventCategoryId = eventCategoryId
                            self.funcCallApiForEventCategory(categoryId: eventCategoryId)
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
    }
    
    func funcCallApiForEventCategory(categoryId:Int){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.GetEventSuggestedCategory(categoryId: categoryId) { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    DispatchQueue.main.async {
                        self.tblSuggestedEvent.arrData = self.viewModel.arrEventData
                        self.tblSuggestedEvent.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
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
        self.lblEventName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblSelectDateTime.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblEventName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblAboutOfEvent.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblAboutOfEvent.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblOrganizer.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblOrganizer.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblTags.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblTags.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblSuggestionForYou.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblSuggestionForYou.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
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
        self.lblPrice.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblOnTicketGateway.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblOnTicketGateway.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
    func setData(){
        let eventDetail = self.viewModel.eventDetail
        self.lblPrice.text = "CAD$\(eventDetail?.ticketOnwards ?? 0) onwards"
        self.lblEventName.text = eventDetail?.event?.title ?? ""
        self.lblEventDate.text = "\(eventDetail?.eventDateObj?.eventStartDate?.getDateFormattedFrom() ?? "")" +  " " + "-" + " " + "\(eventDetail?.eventDateObj?.eventEndDate?.getDateFormattedFromTo() ?? "")"
        
        self.lblDate.text = ("\(eventDetail?.eventDateObj?.eventStartDate?.getDateFormattedFrom() ?? "")" +  " " + "to" + " " + "\(eventDetail?.eventDateObj?.eventEndDate?.getDateFormattedFromTo() ?? "")")
        self.lblTime.text = ("\(eventDetail?.eventDateObj?.eventStartTime?.getFormattedTime() ?? "")" +  " " + "-" + " " + "\(eventDetail?.eventDateObj?.eventEndTime?.getFormattedTime() ?? "")")
        self.lblAddress.text = eventDetail?.eventLocation?.eventAddress ?? ""
        self.lblFullAddress.text = (eventDetail?.eventLocation?.eventState ?? "") + " " + (eventDetail?.eventLocation?.eventAddress ?? "")
        self.lblRefundpolicyDisc.text = "Refunds" + " " + (eventDetail?.eventRefundPolicy?.policyDescription ?? "")
        self.lblAboutDiscripation.text = eventDetail?.event?.eventDescription ?? ""
        
        //ORGANIZER
        self.lblOrganiserName_Company.text = eventDetail?.organizer?.name ?? ""
        self.lblFollowers.text = "\(eventDetail?.organizer?.followers ?? 0)  followers"
        if let imageUrl = eventDetail?.organizer?.profileImage {
            if imageUrl.contains(APIHandler.shared.baseURL){
                let imageUrl = imageUrl.replacingOccurrences(of: APIHandler.shared.baseURL, with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
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
        self.collVwTags.setData(eventDetail: eventDetail)
        
        self.toSetPageControll()
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
        case btnReadMore :
            self.addToCalenAction()
        case btnShowMap :
            self.addToCalenAction()
        case btnAddToCalender :
            self.addToCalenAction()
        case btnSelectDate :
            self.txtDate.showList()
        case btnSelectLocationAccordingToDate :
            self.txtLocation.showList()
        default:
            break
        }
    }
    
    func addToCalenAction(){
        
    }
    
    func btnBookTicket()
    {
        if let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketVC) as? EventBookingTicketVC{
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.ticketId = "\(self.viewModel.eventDetail?.event?.ticketID ?? 0)"
            view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}

//MARK: - PageControl
extension EventDetailVC {
    func toSetPageControll() {
        pageConrtrolEventImages.drawer = ExtendedDotDrawer(numberOfPages: self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0,
                                                           space: 16.0,
                                                           indicatorColor: UIColor.setColor(colorType: .TiitleColourDarkBlue),
                                                           dotsColor: UIColor.setColor(colorType: .PlaceHolder),
                                                           isBordered: false,
                                                           borderWidth: 0.0,
                                                           indicatorBorderColor: .clear,
                                                           indicatorBorderWidth: 0.0)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        pageConrtrolEventImages.setPageOffset(offSet / width)
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

//MARK: - NavigationBarViewDelegate
extension EventDetailVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
