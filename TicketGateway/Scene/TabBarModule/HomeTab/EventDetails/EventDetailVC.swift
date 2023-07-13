//
//  EventDetailVC.swift
//  TicketGateway
//
//  Created by Apple  on 05/05/23.
//

import UIKit
import iOSDropDown
import AdvancedPageControl

class EventDetailVC: UIViewController, UITextFieldDelegate{
    
    //MARK: - IBOutlets
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.tblSuggestedEvent.configure()
        self.tblSuggestedEvent.reloadData()
        self.tblSuggestedEvent.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfSuggestedOrganisedEvent.constant = self.tblSuggestedEvent.contentSize.height
        self.tblSuggestedEvent.layoutIfNeeded()
        self.navigationView.delegateBarAction = self
        self.navigationView.btnRight.isHidden = false
        self.navigationView.btnSecRight.isHidden = false
        self.navigationView.lblSeprator.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        btnAddToCalender.setTitles(text: ADD_TO_CALENDAR, textColour: UIColor.setColor(colorType: .TGBlue), borderColour: UIColor.setColor(colorType: .TGBlue))
        btnShowMap.setTitles(text: SHOW_MAP, textColour: UIColor.setColor(colorType: .TGBlue), borderColour: UIColor.setColor(colorType: .TGBlue))
        btnReadMore.setTitles(text: READ_MORE, textColour: UIColor.setColor(colorType: .TGBlue), borderColour: UIColor.setColor(colorType: .TGBlue))
      
        navigationView.lblTitle.text = EVENT
        navigationView.btnBack.isHidden = false
        navigationView.btnRight.setImage(UIImage(named: UPLOAD_ICON), for: .normal)
        navigationView.btnSecRight.setImage(UIImage(named: FAV_SELECT_ICON), for: .normal)
        navigationView.delegateBarAction = self
        btnFollowing.setTitles(text: FOLLOWING, font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        btnBookTickets.setTitles(text: TICKETS, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .TiitleColourDarkBlue))
        btnBookTickets.addLeftIcon(image: UIImage(named: TICKET_BLACK))
        [self.btnFollowing,self.btnReadMore,self.btnAddToCalender,self.btnBookTickets,btnSelectDate,btnSelectLocationAccordingToDate].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.toSetPageControll()
        self.dropDown()
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
        let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketVC) as? EventBookingTicketVC
    self.navigationController?.pushViewController(view!, animated: true)
    }
}

//MARK: - PageControl
extension EventDetailVC {
    func toSetPageControll() {
        pageConrtrolEventImages.drawer = ExtendedDotDrawer(numberOfPages: 6,
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
        return 6
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventImageCell", for: indexPath) as! EventImageCell
       //  cell.imgEvents.cornerRadius = 10
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth : CGFloat = 0
        var cellHeight : CGFloat = 0
        cellWidth = CGFloat(self.collvwEventImages.frame.size.width)
        cellHeight = CGFloat(self.collvwEventImages.frame.size.width)
        print(cellHeight)
        return CGSize(width: cellHeight, height: cellHeight)
   }

}

//MARK: - NavigationBarViewDelegate
extension EventDetailVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
