//
//  HomeVC.swift
//  TicketGateway
//
//  Created by Apple  on 17/04/23.
//

import UIKit
import SideMenu
import SVProgressHUD



class HomeVC: UIViewController{
    
    //MARK: - IBOutlets
    @IBOutlet weak var heightOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightOfNearOrganisedEvent: NSLayoutConstraint!
    @IBOutlet weak var btnViewAllMoreForNearOrganisedEvent: CustomButtonNormal!
    @IBOutlet weak var btnViewAllForSuggestedOrganised: CustomButtonNormal!
    @IBOutlet weak var lblNearOrganisedEvent: UILabel!
    @IBOutlet weak var lblSuggestedOrganised: UILabel!
    @IBOutlet weak var tblEvents: EventsOrganizesListTableView!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var collvwSuggestedOrganisation: suggestedOrganizerList!
    
    //MARK: - Variables
    var isMenuOpened:Bool = false
    var viewModel = HomeDashBoardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.funcCallApi()
    }
}


//MARK: - UITextFieldDelegate
extension HomeVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchHomeVC) as? EventSearchHomeVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
}
//MARK: - Functions
extension HomeVC {
    func setUp(){
        self.setUi()
        self.collvwSuggestedOrganisation.configure()
        self.tblEvents.configure()
        self.tblEvents.tableDidSelectAtIndex = { _ in
            self.navigationController?.popViewController(animated: true)
        }
        self.tblEvents.tableDidSelectAtIndex = { _ in
            let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC
            self.navigationController?.pushViewController(view!, animated: true)
        }
        self.tblEvents.reloadData()
        self.tblEvents.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfNearOrganisedEvent.constant = self.tblEvents.contentSize.height
        self.vwSearchBar.delegate = self
        self.vwSearchBar.txtSearch.delegate = self
    }
    
    func setUi(){
        self.lblNearOrganisedEvent.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblNearOrganisedEvent.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblSuggestedOrganised.font = UIFont.setFont(fontType: .bold, fontSize: .twenty)
        self.lblSuggestedOrganised.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        
        self.btnViewAllMoreForNearOrganisedEvent.setTitles(text: "View more events", font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .TGBlue))
        
        self.btnViewAllMoreForNearOrganisedEvent.addRightIcon(image: UIImage(named: "ri8Blue"))
        
        self.btnViewAllForSuggestedOrganised.setTitles(text: "See all", font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .TGBlue))
        
        
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightOfNearOrganisedEvent.constant = tblEvents.contentSize.height
        
    }
    
    func funcCallApi(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.GetEventApi(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    DispatchQueue.main.async {
                        self.tblEvents.arrData = self.viewModel.arrEventData
                        self.tblEvents.reloadData()
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

//MARK: - CustomSearchMethodsDelegate
extension HomeVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
        
    }
    
    func RightButtonPressed(_ sender: UIButton) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchLocationVC) as? EventSearchLocationVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
}
