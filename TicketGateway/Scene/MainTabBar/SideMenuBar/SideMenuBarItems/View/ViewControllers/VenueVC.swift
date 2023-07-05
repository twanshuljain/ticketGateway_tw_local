//
//  VenueVC.swift
//  TicketGateway
//
//  Created by Apple  on 04/05/23.
//

import UIKit
import SideMenu

class VenueVC: UIViewController{
     
    @IBOutlet weak var btnViewAllMoreForNearOrganisedEvent: CustomButtonNormal!
    @IBOutlet weak var lblNearOrganisedEvent: UILabel!
    @IBOutlet weak var tblEvents: EventsOrganizesListTableView!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    var isMenuOpened:Bool = false
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.vwSearchBar.delegate = self
     }
  
    func setUp(){
        self.setUi()
        self.tblEvents.configure()
        self.tblEvents.tableDidSelectAtIndex = { _ in
            
        }
    }
        
        func setUi(){
            self.lblNearOrganisedEvent.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
            self.lblNearOrganisedEvent.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
            self.btnViewAllMoreForNearOrganisedEvent.setTitles(text: "View more events", font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .TGBlue))
            self.btnViewAllMoreForNearOrganisedEvent.addRightIcon(image: UIImage(named: "ri8Blue"))
            
          
          
        }
}
extension VenueVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    
    func RightButtonPressed(_ sender: UIButton) {
        print("hello")
    }
    

    
}
