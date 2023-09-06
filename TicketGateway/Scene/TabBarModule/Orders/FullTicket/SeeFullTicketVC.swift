//
//  SeeFullTicketVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 31/05/23.
// swiftlint: disable force_cast
// swiftlint: disable line_length
import UIKit
import CoreImage

class SeeFullTicketVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var vwTicketDottedLine: UIView!
    @IBOutlet weak var lblTicket: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var vwNameDottedLine: UIView!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblTicketsAndSeats: UILabel!
    @IBOutlet weak var lblGeneralAdmission: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDateValue: UILabel!
    @IBOutlet weak var btnAddToCalender: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnViewMap: UIButton!
    @IBOutlet weak var vwViewMapDottedLine: UIView!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblOrderNumberValue: UILabel!
    @IBOutlet weak var lblEventSummary: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var btnViewEventList: UIButton!
    @IBOutlet weak var lblOrganizer: UILabel!
    @IBOutlet weak var lblOrganizerName: UILabel!
    @IBOutlet weak var btnFollowing: CustomButtonGradiant!
    @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblRefundPolicyDays: UILabel!
    @IBOutlet weak var lblPolicyExpired: UILabel!
    @IBOutlet weak var btnGetARefund: UIButton!
    @IBOutlet weak var btnSeeLessView: CustomButtonNormal!
    @IBOutlet weak var btnSaveTicketAsImage: CustomButtonNormal!
    @IBOutlet weak var btnAddAppToWallet: CustomButtonNormal!
    @IBOutlet weak var vwSeeLessDottedLine: UIView!
    @IBOutlet weak var vwRefundPolicyDottedLine: UIView!
    @IBOutlet weak var tblMyTicket : UITableView!
    @IBOutlet weak var heightOfMyTicket: NSLayoutConstraint!
    @IBOutlet weak var imgScanCode : UIImageView!
    
    var viewModel: SeeFullTicketViewModel = SeeFullTicketViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setNavigationBar()
        self.configure()
        self.setUI()
        self.setData()
    }
}
// MARK: - Functions
extension SeeFullTicketVC {
    
    func configure() {
        tblMyTicket.register(UINib(nibName: "MyTicketListingTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTicketListingTableViewCell")
        tblMyTicket.delegate = self
        tblMyTicket.dataSource = self
    }
    
    func setUI() {
        [self.btnGetARefund,self.btnSeeLessView,self.btnSaveTicketAsImage,self.btnAddAppToWallet,self.btnViewEventList].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.tblMyTicket.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfMyTicket.constant = self.tblMyTicket.contentSize.height
    }
    func getTime(strDate: String) -> String {
        let date = strDate.convertStringToDate(date: strDate)
        return date.getOnlyTimeFromDate(date: date)
    }
    
    func getTimeISO(strDate: String) -> String {
        let date = strDate.convertStringToDateForProfile(date: strDate)
        return date.getOnlyTimeFromDate(date: date)
    }
    
    func getWeekDay(strDate: String) -> String {
        let date = strDate.convertStringToDate(date: strDate)
        return date.getWeekDay(date: date) ?? "-"
    }
    func setNavigationBar() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = MY_TICKETS
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.vwNavigationView.btnRight.isHidden = false
        self.vwNavigationView.btnRight.setImage(UIImage(named: MENU_DOT_ICON), for: .normal)
        self.vwNavigationView.btnRight.addTarget(self, action: #selector(addActionSheet), for: .touchUpInside)
    }
    @objc func addActionSheet() {
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Transfer this ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            if let transferTicketVC = self.createView(storyboard: .order, storyboardID: .TransferTicketVC) as? TransferTicketVC{
                transferTicketVC.viewModel.ticketDetails = self.viewModel.ticketDetails
                transferTicketVC.viewModel.eventDetail = self.viewModel.eventDetail
                transferTicketVC.viewModel.myTicket = self.viewModel.myTicket
                self.navigationController?.pushViewController(transferTicketVC, animated: true)
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Exchange ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let exchangeTicketVC = self.createView(storyboard: .order, storyboardID: .ExchangeTicketVC)
            self.navigationController?.pushViewController(exchangeTicketVC, animated: true)
        }))
        actionsheet.addAction(UIAlertAction(title: "Change name on ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            if let changeNameVC = self.createView(storyboard: .order, storyboardID: .ChangeNameVC) as? ChangeNameVC{
                changeNameVC.viewModel.myTicket = self.viewModel.myTicket
                self.navigationController?.pushViewController(changeNameVC, animated: true)
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Share this event", style: UIAlertAction.Style.default, handler: { (action) -> Void in
        }))
        actionsheet.addAction(UIAlertAction(title: "Contact organiser", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            if let contactOrganiserVC = self.createView(storyboard: .order, storyboardID: .ContactOrganiserVC) as? ContactOrganiserVC{
                contactOrganiserVC.viewModel.eventDetail = self.viewModel.eventDetail
                contactOrganiserVC.viewModel.oranizerId = self.viewModel.eventDetail?.organizer?.id ?? 0
                self.navigationController?.pushViewController(contactOrganiserVC, animated: true)
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
        }))
        self.present(actionsheet, animated: true, completion: nil)
    }
    func setFont() {
        let regularLbl = [lblTicket, lblEvent, lblTicketsAndSeats, lblDate, lblLocation, lblOrderNumber, lblEventSummary, lblOrganizer]
        for lbl in regularLbl {
            lbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .eighteen)
        self.lblName.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        let mediumLbl = [lblEventName, lblGeneralAdmission, lblDateValue, lblLocationName, lblOrderNumberValue]
        for lbl in mediumLbl {
            lbl?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        let btns = [btnAddToCalender, btnViewMap, btnViewEventList, btnGetARefund]
        for btn in btns {
            btn?.titleLabel?.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
            btn?.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        }
        self.lblAddress.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblAddress.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblSummary.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblSummary.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblRefundPolicy.font = UIFont.setFont(fontType: .semiBold, fontSize: .twelve)
        self.lblRefundPolicy.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblRefundPolicyDays.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblRefundPolicyDays.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnSeeLessView.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSeeLessView.titleLabel?.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnSeeLessView.addRightIcon(image: UIImage(named: CHEVRON_DOWN_DB_ICON))
        self.btnSaveTicketAsImage.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSaveTicketAsImage.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnSaveTicketAsImage.addLeftIcon(image: UIImage(named: DOWNLOAD_ICON_ORDER))
        self.btnAddAppToWallet.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnAddAppToWallet.titleLabel?.textColor = UIColor.setColor(colorType: .white)
        self.btnAddAppToWallet.addLeftIcon(image: UIImage(named: APPLE_WALLET_ICON))
        let dottedLines = [vwNameDottedLine, vwTicketDottedLine, vwSeeLessDottedLine, vwViewMapDottedLine, vwRefundPolicyDottedLine]
        for dottedLine in dottedLines {
            dottedLine?.createDottedLine(width: 2, color: UIColor.setColor(colorType: .borderLineColour).cgColor, dashPattern: [6, 6])
        }
        self.lblOrganizerName.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblOrganizerName.textColor = UIColor.setColor(colorType: .tgBlack)
        self.btnFollowing.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnFollowing.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblPolicyExpired.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
    }
    
    
    func setData(){
        let eventDetail = self.viewModel.eventDetail
      //  lblEventName.text = viewModel.ticketDetails?.eventTitle ?? "-"
      //  lblAddress.text = viewModel.ticketDetails?.location ?? "-"
        
        
        if let base64String = self.viewModel.myTicket?.items?.first?.qrcodeBase64Data{
//            if let qrCode = base64String.generateQRCode(qrCodeImageView: imgScanCode) {
//                imgScanCode.image = qrCode
//            }
            
           // if let qrCodeImage = base64String.base64ToImage(){
                imgScanCode.image = UIImage.decodeBase64(toImage: base64String)
           // }
        }
        
        self.lblName.text = self.viewModel.myTicket?.items?.first?.nameOnTicket ?? ""
        
        self.lblEventName.text = eventDetail?.event?.title ?? ""
        //((eventDetail?.event?.title ?? "") + " - " + "\(eventDetail?.eventDateObj?.eventStartDate?.getDateFormattedFromTo() ?? "")")
        //self.lblGeneralAdmission.text = viewModel.myTicket?.items?.first?.ticketName ?? ""
        
        if let startDate = eventDetail?.eventDateObj?.eventStartDate, let startTime =  eventDetail?.eventDateObj?.eventStartTime {
            lblDateValue.text = "\(startDate.getDayFormattedFromTo()), \(startDate.getDateFormattedFromTo()) / \(startTime.getFormattedTime())"
        }
       
        self.lblAddress.text = eventDetail?.eventLocation?.eventAddress ?? ""
        lblOrderNumberValue.text = "#\(viewModel.myTicket?.items?.first?.orderNumber ?? "")"
        
        //ABOUt US
        if (eventDetail?.organizer?.eventDescription != "") && (eventDetail?.organizer?.eventDescription != nil){
            self.lblEventSummary.isHidden = false
            self.lblSummary.text = eventDetail?.organizer?.eventDescription ?? ""
            
        }else{
            self.lblEventSummary.isHidden  = true
            self.lblSummary.text = ""
        }
        
        //ORGANIZER
        self.lblOrganizerName.text = eventDetail?.organizer?.name ?? ""
        
        //FOLLOW/UNFOLLOW
        print("eventDetail?.isFollow", eventDetail?.isFollow as Any)
        if let isFollow = eventDetail?.isFollow {
            if isFollow {
                self.btnFollowing.setTitles(
                    text: "Following",
                    font: UIFont.boldSystemFont(ofSize: 15),
                    tintColour: .black
                )
            } else {
                self.btnFollowing.setTitles(
                    text: "Follow",
                    font: UIFont.boldSystemFont(ofSize: 15),
                    tintColour: .black
                )
            }
        }
        
        //REFUND
        self.lblRefundPolicyDays.text = "Refunds" + " " + (eventDetail?.eventRefundPolicy?.policyDescription ?? "")
        
        tblMyTicket.reloadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightOfMyTicket.constant = tblMyTicket.contentSize.height
        if self.viewModel.myTicket?.items == nil{
            self.heightOfMyTicket.constant = 0
        }else{
            if let items = self.viewModel.myTicket?.items, items.count == 0{
                //self.lblTicket
                self.heightOfMyTicket.constant = 0
            }else{
                self.heightOfMyTicket.constant = tblMyTicket.contentSize.height
            }
        }
    }
}

// MARK: - Actions
extension SeeFullTicketVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnGetARefund:
            self.btnRefundAction()
        case btnSeeLessView:
            self.seeLessViewAction()
        case btnSaveTicketAsImage:
            break
        case btnAddAppToWallet:
            break
        case btnViewEventList:
            self.viewEventListAction()
        default:
            break
        }
    }
    func btnRefundAction() {
        let vc = self.createView(storyboard: .order, storyboardID: .RequestRefundVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func seeLessViewAction() {
        let vc = self.createView(storyboard: .order, storyboardID: .MyTicketVC)
        self.navigationController?.popViewController(animated: false)
    }
    func saveTicketAsImage() {
    }
    func addAppToWalletAction() {
    }
    
    func viewEventListAction() {
        self.navigateToEventDetail()
    }
    
    func navigateToEventDetail() {
        if let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC {
            view.viewModel.eventId = viewModel.myTicket?.items?.first?.eventID //TO BE CHANGED
            let numberOfPage = self.viewModel.eventDetail?.eventCoverImageObj?.eventAdditionalCoverImages?.count ?? 0
           //  Here we are saving number of pages for page control UI on detail screen, We need to store it for first time only.
            AppShareData.sharedObject().saveNumOfPage(numOfPage: numberOfPage)
            view.viewModel.eventDetail = self.viewModel.eventDetail
            view.viewModel.isFromPast = self.viewModel.isFromPast
            self.navigationController?.pushViewController(view, animated: false)
           // view.delegate = self
            
            //funcCallApiForEventDetail(eventId: view.viewModel.eventId, view: view)
        }
    }
}
// MARK: - UITableViewDelegate,UITableViewDataSource
extension SeeFullTicketVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.myTicket?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketListingTableViewCell", for: indexPath) as? MyTicketListingTableViewCell{
            if let data = self.viewModel.myTicket?.items?[indexPath.row]{
                cell.setData(ticketData: data)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}

// MARK: - NavigationBarViewDelegate
extension SeeFullTicketVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
}
