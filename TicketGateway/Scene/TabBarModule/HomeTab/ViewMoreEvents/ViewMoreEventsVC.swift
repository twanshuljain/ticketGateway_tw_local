//
//  ViewMoreEventsVC.swift
//  TicketGateway
//
//  Created by Apple on 12/07/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import UIKit
import SideMenu

class ViewMoreEventsVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var navigationView: NavigationBarView!
    
    var arrData:GetEvent?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUp()
    }
    

}
//MARK: - Functions
extension ViewMoreEventsVC{
    func setUp() {
        self.tblView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        self.vwSearchBar.delegate = self
        self.vwSearchBar.txtSearch.delegate = self
        
        self.navigationView.delegateBarAction = self
        self.navigationView.btnBack.isHidden = false
        self.navigationView.btnSecRight.isHidden = true
        self.navigationView.lblSeprator.isHidden = true
        self.navigationView.vwBorder.isHidden = true
        navigationView.lblTitle.text = "Weekend"
    }
}

// MARK: - TableView Delegate
extension ViewMoreEventsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData?.itemsWeekend?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell {
            if let data = arrData?.itemsWeekend, data.indices.contains(indexPath.row){
                cell.getEvent = data[indexPath.row]
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
//MARK: - CustomSearchMethodsDelegate
extension ViewMoreEventsVC: CustomSearchMethodsDelegate {
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

//MARK: - UITextFieldDelegate
extension ViewMoreEventsVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchHomeVC) as? EventSearchHomeVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
}
//MARK: - NavigationBarViewDelegate
extension ViewMoreEventsVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
