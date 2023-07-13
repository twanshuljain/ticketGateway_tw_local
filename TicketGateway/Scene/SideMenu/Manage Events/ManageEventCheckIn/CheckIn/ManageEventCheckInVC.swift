//
//  ManageEventCheckInVC.swift
//  TicketGateway
//
//  Created by Apple on 26/06/23.
//

import UIKit
import SideMenu

class ManageEventCheckInVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var vwNavighationView: NavigationBarView!
    @IBOutlet weak var btnScanQR: CustomButtonGradiant!
    @IBOutlet weak var btnStats: CustomButtonGradiant!
    @IBOutlet weak var contactTableView: UITableView!
    
    //MARK: - Variables
    let viewModel = ManageEventCheckInViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setTableView()
        self.generateWordsDict()
        self.setFont()
        self.setUI()
        
    }
    

}

//MARK: -
extension ManageEventCheckInVC {
    
    func setTableView() {
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
        self.contactTableView.separatorColor = UIColor.clear
        
    }
    
    func generateWordsDict(){
        for contact in viewModel.arrData {
            let key = "\(contact[contact.startIndex])"
            let upper = key.uppercased()
            if var contactValue = viewModel.contactDictionary[upper]
            {
                contactValue.append(contact)
                viewModel.contactDictionary[upper]?.append(contact)
            }else{
                viewModel.contactDictionary[upper] = [contact]
            }
        }
        viewModel.contactSection = [String](viewModel.contactDictionary.keys)
        viewModel.contactSection = viewModel.contactSection.sorted()
    }
    
    
    func setFont() {
        self.btnScanQR.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnScanQR.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnScanQR.addLeftIcon(image: UIImage(named: SCAN_ICON))
        self.btnStats.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnStats.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnStats.addLeftIcon(image: UIImage(named: BAR_CHART_ICON))
    }
    
    func setNavigationBar() {
        self.vwNavighationView.delegateBarAction = self
        self.vwNavighationView.btnBack.isHidden = false
        self.vwNavighationView.lblTitle.text = HEADER_TITLE_SUNBURN
        self.vwNavighationView.lblDiscripation.isHidden = false
        self.vwNavighationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavighationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.vwNavighationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
        self.vwNavighationView.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.vwNavighationView.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.vwNavighationView.imgBack.image = UIImage(named: MENU_ICON)
    }
    
}

//MARK: - Instance Method
extension ManageEventCheckInVC {
    func setUI () {
        [self.btnScanQR,self.btnStats].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnScanQR:
            self.btnScanQRAction()
        case btnStats:
            self.btnStatsAction()
        default:
            break
        }
    }
    
    func btnScanQRAction() {
        
        let vc = createView(storyboard: .manageevent, storyboardID: .ScanQRVC)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func btnStatsAction() {
        let vc = createView(storyboard: .scanevent, storyboardID: .ScanSummaryVC)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
//MARK: -
extension ManageEventCheckInVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.contactSection.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // arrData.count
        let contactKey = viewModel.contactSection[section]
        if let contactValue = viewModel.contactDictionary[contactKey]{
            return contactValue.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        let cotactkey = viewModel.contactSection[indexPath.section]
        if let contactValue = viewModel.contactDictionary[cotactkey.uppercased()] {
            cell.lblName?.text = contactValue[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.contactSection[section].uppercased()
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.contactSection
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = viewModel.contactSection.firstIndex(of: title) else {
            return -1
        }
        return index
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.contactTableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: -
extension ManageEventCheckInVC: NavigationBarViewDelegate ,UITextFieldDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
        
        //    self.navigationController?.popViewController(animated: true)
        
    }
}
