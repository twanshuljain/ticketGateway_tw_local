//
//  EventSearchHomeVC.swift
//  TicketGateway
//
//  Created by Apple  on 22/05/23.
//

import UIKit
import SideMenu

class EventSearchLocationVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblOnlineEventDis: UILabel!
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var lblOnlineEvents: UILabel!
    @IBOutlet weak var lblNearByDiscripation: UILabel!
    @IBOutlet weak var lblNearBy: UILabel!
    @IBOutlet weak var lblBrowingIn: UILabel!
    @IBOutlet weak var tblList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.setUI()
        self.vwSearchBar.delegate = self
        self.vwSearchBar.vwLocation.isHidden = true
        self.vwSearchBar.txtSearch.attributedPlaceholder = NSAttributedString(string:"Find events in...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.setColor(colorType: .PlaceHolder)])
        self.vwSearchBar.txtSearch.delegate = self
        self.vwSearchBar.btnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
    }
}

// MARK: - Functions
extension EventSearchLocationVC{
    private func setUp(){
        self.tblList.dataSource = self
        self.tblList.delegate = self
        self.tblList.reloadData()
    }
    
    private func setUI(){
        [self.lblNearBy,self.lblOnlineEvents,self.lblBrowingIn].forEach{
            $0.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
            $0.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        }
        [self.lblNearByDiscripation,self.lblOnlineEventDis].forEach{
            $0.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        
    }
}

// MARK: - TableView Delegate
extension EventSearchLocationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocationCell") as!SearchLocationCell
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocationCell") as! SearchLocationCell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("in \(indexPath.row)")
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
    }
    
}

//MARK: - UITextFieldDelegate
extension EventSearchLocationVC: UITextFieldDelegate {
    
}

//MARK: - CustomSearchMethodsDelegate
extension EventSearchLocationVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func RightButtonPressed(_ sender: UIButton) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchLocationVC) as? EventSearchLocationVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
}
