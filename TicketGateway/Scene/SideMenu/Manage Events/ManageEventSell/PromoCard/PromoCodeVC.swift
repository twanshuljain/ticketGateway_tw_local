//
//  PromoCodeVC.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
//

import UIKit

class PromoCodeVC: UIViewController {
    
// MARK: - @IBOutlets
    @IBOutlet weak var vwSearchBar: CustomSearchBar!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var btnApply: CustomButtonGradiant!
    @IBOutlet weak var tblPromoList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view.
    }
    
}

// MARK: - Functions
extension PromoCodeVC{
    func setUp() {
        self.btnApply.setTitles(text: APPLY, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        self.navigationView.lblTitle.text = PROMO_CODE
        self.navigationView.btnBack.isHidden = false
        self.navigationView.imgBack.image = UIImage(named: X_ICON)
        self.navigationView.btnRight.isHidden = false
        self.navigationView.btnRight.setImage(UIImage(named: PROFILE_ICON), for: .normal)
        self.navigationView.btnRight.layer.cornerRadius = 20
        self.navigationView.btnRight.clipsToBounds = true
        self.navigationView.lblSeprator.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.vwBorder.isHidden = false
        self.vwSearchBar.delegate = self
        self.vwSearchBar.txtSearch.delegate = self
        self.vwSearchBar.btnMenu.isHidden = true
        self.vwSearchBar.vwLocation.isHidden = true
    }
}

// MARK: - TableView Delegate
extension PromoCodeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCodeCell") as! PromoCodeCell
         return cell
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TicketOverAllEstimateBarCell") as! TicketOverAllEstimateBarCell
       
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("in \(indexPath.row)")
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
    }
    
}
// MARK: - NavigationBarViewDelegate
extension PromoCodeVC : NavigationBarViewDelegate {
  func navigationBackAction() {
    self.navigationController?.popViewController(animated: false)
  }
}
extension PromoCodeVC: CustomSearchMethodsDelegate {
    func leftButtonPressed(_ sender: UIButton) {
       
    }
    
    func RightButtonPressed(_ sender: UIButton) {
        let view = self.createView(storyboard: .home, storyboardID: .EventSearchLocationVC) as? EventSearchLocationVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
}

// MARK: - @IBOutlets
extension PromoCodeVC:UITextFieldDelegate{
    
}
