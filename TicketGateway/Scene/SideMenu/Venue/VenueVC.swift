//
//  VenueVC.swift
//  TicketGateway
//
//  Created by Apple  on 04/05/23.
//

import UIKit
import SideMenu

class VenueVC: UIViewController{
     
    // MARK: - IBOutlets
    @IBOutlet weak var btnViewAllMoreForNearOrganisedEvent: CustomButtonNormal!
    @IBOutlet weak var lblNearOrganisedEvent: UILabel!
    @IBOutlet weak var tblEvents: EventsOrganizesListTableView!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    // MARK: - Variables
    var isMenuOpened:Bool = false
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setUp()
     }
}
// MARK: - Functions
extension VenueVC{
    
    func setNavigationBar() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.lblTitle.text = VENUE
        self.vwNavigationView.btnRight.isHidden = false
        self.vwNavigationView.vwBorder.isHidden = false
        self.vwNavigationView.btnRight.setImage(UIImage(named: CANCEL_ICON), for: .normal)
        self.vwNavigationView.btnBack.isHidden = false
        
    }
    
    
    func setUp(){
        self.setUi()
        self.tblEvents.configure(isComingFrom: IsComingFromForEventsOrganizesListTableView.venue)
        self.tblEvents.tableDidSelectAtIndex = { _ in
            
        }
        
        
    }
    func setUi(){
        self.lblNearOrganisedEvent.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblNearOrganisedEvent.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.btnViewAllMoreForNearOrganisedEvent.setTitles(text: VIEW_MORE_EVENT, font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .tgBlue))
        self.btnViewAllMoreForNearOrganisedEvent.addRightIcon(image: UIImage(named: RIGHT_BLUE_ICON))
    }
}

// MARK: - CustomSearchMethodsDelegate
extension VenueVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
