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
        self.funcCallApi(viewAll: false)
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
        self.tblEvents.delegateViewMore = self
        self.tblEvents.configure(isComingFrom: IsComingFromForEventsOrganizesListTableView.Home)
        self.tblEvents.tableDidSelectAtIndex = { _ in
            self.navigationController?.popViewController(animated: true)
        }
       
        self.tblEvents.tableDidSelectAtIndex = {  index in
            let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC
            switch index.section {
            case 0:
                if self.viewModel.arrDataaWeekend.indices.contains(index.row){
                    view?.viewModel.eventId = self.viewModel.arrDataaWeekend[index.row].event?.id
                }
            case 1:
                if self.viewModel.arrDataaVirtual.indices.contains(index.row){
                    view?.viewModel.eventId = self.viewModel.arrDataaVirtual[index.row].event?.id
                }
            case 2:
                if self.viewModel.arrDataaPopular.indices.contains(index.row){
                    view?.viewModel.eventId = self.viewModel.arrDataaPopular[index.row].event?.id
                }
            case 3:
                if self.viewModel.arrDataaFree.indices.contains(index.row){
                    view?.viewModel.eventId = self.viewModel.arrDataaFree[index.row].event?.id
                }
            case 4:
                if self.viewModel.arrDataaUpcoming.indices.contains(index.row){
                    view?.viewModel.eventId = self.viewModel.arrDataaUpcoming[index.row].event?.id
                }
            default:
                break;
            }
            
            self.navigationController?.pushViewController(view!, animated: true)
        }
        //self.tblEvents.reloadData()
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
        self.btnViewAllForSuggestedOrganised.setTitles(text: SEE_ALL, font: .systemFont(ofSize: 20), tintColour: .blue, textColour: UIColor.setColor(colorType: .TGBlue))
      }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightOfNearOrganisedEvent.constant = tblEvents.contentSize.height
        
    }
    
    func funcCallApi(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            self.viewModel.dispatchGroup1.enter()
            viewModel.getEventApiForWeekendEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    //                   DispatchQueue.main.async {
                    if let itemWeekend = self.viewModel.arrEventData.itemsWeekend{
                        self.viewModel.semaphore.wait()
//                        itemWeekend.forEach { data in
//                            self.tblEvents.arrDataaWeekend.append(data)
//                        }
                        self.tblEvents.arrDataaWeekend = []
                        self.tblEvents.arrDataaWeekend.append(contentsOf: itemWeekend)
                        self.viewModel.semaphore.signal()
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
        
        
        self.viewModel.dispatchGroup1.notify(queue: .main) {
            print("Finished Api Call GetEventApiForWeekendEvents")
            self.funcCallApiForOnlineEvents(viewAll: false)
        }
    }
    
    func funcCallApiForOnlineEvents(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            self.viewModel.dispatchGroup2.enter()
            viewModel.getEventApiForOnlineEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    if let itemsVirtual = self.viewModel.arrEventData.itemsVirtual{
                        self.viewModel.semaphore.wait()
                        self.tblEvents.arrDataaVirtual = []
                        self.tblEvents.arrDataaVirtual.append(contentsOf: itemsVirtual)
                        self.viewModel.semaphore.signal()
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
        
        self.viewModel.dispatchGroup2.notify(queue: .main) {
            print("Finished Api Call GetEventApiForOnlineEvents")
            self.funcCallApiForPopularEvents(viewAll: false)
        }
    }
    
    
    func funcCallApiForPopularEvents(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            self.viewModel.dispatchGroup3.enter()
            viewModel.getEventApiForPopularEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    if let itemsPopular = self.viewModel.arrEventData.itemsPopular{
                        self.viewModel.semaphore.wait()
                        self.tblEvents.arrDataaPopular = []
                        self.tblEvents.arrDataaPopular.append(contentsOf: itemsPopular)
                        self.viewModel.semaphore.signal()
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
        
        self.viewModel.dispatchGroup3.notify(queue: .main) {
            print("Finished Api Call GetEventApiForPopularEvents")
            self.funcCallApiForFreeEvents(viewAll: false)
        }
    }
    
    
    func funcCallApiForFreeEvents(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            self.viewModel.dispatchGroup4.enter()
            viewModel.getEventApiForFreeEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    if let itemsFree = self.viewModel.arrEventData.itemsFree{
                        self.viewModel.semaphore.wait()
                        self.tblEvents.arrDataaFree = []
                        self.tblEvents.arrDataaFree.append(contentsOf: itemsFree)
                        self.viewModel.semaphore.signal()
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
        
        self.viewModel.dispatchGroup4.notify(queue: .main) {
            print("Finished Api Call GetEventApiForFreeEvents")
            self.funcCallApiForUpcomingEvents(viewAll: false)
        }
    }
    
    func funcCallApiForUpcomingEvents(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            self.viewModel.dispatchGroup5.enter()
            viewModel.getEventApiForUpcomingEvents(viewAll:viewAll,complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    print("Finished Api Call GetEventApiForFreeEvents")
                        if let itemsUpcoming = self.viewModel.arrEventData.itemsUpcoming{
                            self.viewModel.semaphore.wait()
                            //var arr = self.tblEvents.arrDataaUpcoming.removeDuplicates()
                            self.tblEvents.arrDataaUpcoming = []
                            self.tblEvents.arrDataaUpcoming.append(contentsOf: itemsUpcoming)
                            self.viewModel.semaphore.signal()
                        }
//                    if let items = self.viewModel.arrEventData.items{
//                        self.tblEvents.arrDataa = items
//                    }
//                    
                    DispatchQueue.main.async {
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
        
        self.viewModel.dispatchGroup5.notify(queue: .main) {
            self.funcCallApiForOrganizersList(viewAll: false)
        }
        
    }
    
    func funcCallApiForOrganizersList(viewAll:Bool){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.getOrganizersList { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    DispatchQueue.main.async {
                        self.collvwSuggestedOrganisation.arrOrganizersList = self.viewModel.arrOrganizersList
                        self.collvwSuggestedOrganisation.reloadData()
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

//MARK: - EventsOrganizesListTableViewProtocol
extension HomeVC:EventsOrganizesListTableViewProtocol{
    func tapActionOfViewMoreEvents(index: Int) {
        let view = self.createView(storyboard: .home, storyboardID: .ViewMoreEventsVC) as? ViewMoreEventsVC
        self.navigationController?.pushViewController(view!, animated: true)
        switch index {
        case 0:
            self.funcCallApi(viewAll: true)
        case 1:
            self.funcCallApiForOnlineEvents(viewAll: true)
        case 2:
            self.funcCallApiForPopularEvents(viewAll: true)
        case 3:
            self.funcCallApiForFreeEvents(viewAll: true)
        case 4:
            self.funcCallApiForUpcomingEvents(viewAll: true)
        default:
            break;
        }
    }
}
