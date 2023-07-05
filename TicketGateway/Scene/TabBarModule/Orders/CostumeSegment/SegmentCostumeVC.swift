//
//  SegmentCostumeVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 22/05/23.
//

import UIKit
import SideMenu

class SegmentCostumeVC: ViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    @IBOutlet weak var segmentBgView: UIView!
    @IBOutlet weak var vwSearchBar: UIView!
    @IBOutlet weak var btnFilter: CustomButtonNormal!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    @IBOutlet weak var tblCostume: UITableView!
   
    //MARK: - Variables
    let tableData = ["costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setTableView()
        self.setNavigationView()
      
    }
}

//MARK: - Functions
extension SegmentCostumeVC{
    func setNavigationView() {
        self.vwNavigationBar.lblTitle.text = "My Orders"
        self.vwNavigationBar.imgBack.image = UIImage(named: "Menu")
        self.vwNavigationBar.btnBack.isHidden = false
        self.vwNavigationBar.delegateBarAction = self

    }

    func setTableView() {
        tblCostume.separatorColor = UIColor.clear
        tblCostume.delegate = self
        tblCostume.dataSource = self
        tblCostume.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
        
    }
    
    func setFont() {
        self.segmentcontrol.selectedSegmentIndex = 1
        self.segmentBgView.addBottomShadow()
        self.btnFilter.addLeftIcon(image: UIImage(named: "ic-Filter"))
        self.lblYear.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblYear.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnFilter.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.btnFilter.titleLabel?.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
}

//MARK: - Actions
extension SegmentCostumeVC{
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        switch segmentcontrol.selectedSegmentIndex {
        case 0:
            self.navigationController?.popViewController(animated: false)
        case 1:
            break
        default:
            break
        }
       
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SegmentCostumeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        let data = tableData[indexPath.row]
        cell.imgImage.image = UIImage(named: data)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.createView(storyboard: .order, storyboardID: .MyTicketVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - NavigationBarViewDelegate
extension SegmentCostumeVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
  }
}
