//
//  MyOrderViewController.swift
//  TicketGateway
//
//  Created by Dr.Mac on 15/05/23.
//

import UIKit
import SideMenu

class MyOrderViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var upComingTableView: UITableView!
    @IBOutlet weak var vwNavigationBar: NavigationBarView!
    @IBOutlet weak var segmentBgView: UIView!
    @IBOutlet weak var btnUpcoming: UIButton!
    @IBOutlet weak var btnPast: UIButton!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblNotSeeingYourtickets: UILabel!
    @IBOutlet weak var lblLearnMore: UILabel!
    @IBOutlet weak var btnFindMyTickets: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var pastView: UIView!
    @IBOutlet weak var lblNoTicket: UILabel!
    @IBOutlet weak var lblLookForSomething: UILabel!
    @IBOutlet weak var btnBrowseEvents: UIButton!
    @IBOutlet weak var lblStillHavingTrouble: UILabel!
    @IBOutlet weak var btnVisitHelpCenter: UIButton!
    @IBOutlet weak var vwSearchBar: UIView!
    @IBOutlet weak var noTicketBgView: UIView!
    
    //MARK: - Variables
    let tbleData = ["Upcoming_ip", "Upcoming_ip"]
    let myOrderTableData = ["costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip", "costumeOrder_ip"]
    var isFromUpcoming : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setFont()
        self.setUI()
        self.isFromUpcoming = true
        self.setNavigationView()
        self.setButtonBackground()
        
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension MyOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tbleData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! UpcomingTableViewCell
        let data = tbleData[indexPath.row]
        cell.imgImage.image = UIImage(named: data)
        return cell
    }
}

//MARK: - Functions
extension MyOrderViewController {
    func setNavigationView() {
        self.vwNavigationBar.lblTitle.text = "My Orders"
        self.vwNavigationBar.imgBack.image = UIImage(named: "Menu")
        self.vwNavigationBar.btnBack.isHidden = false
        self.vwNavigationBar.delegateBarAction = self
    }
    
    func setTableView() {
        self.upComingTableView.separatorColor = .clear
        upComingTableView.delegate = self
        upComingTableView.dataSource = self
        upComingTableView.register(UINib(nibName: "UpcomingTableViewCell", bundle: nil), forCellReuseIdentifier: "UpcomingTableViewCell")
        
    }
    func setButtonBackground(){
        if isFromUpcoming == true {
            self.btnUpcoming.setTitleColor(UIColor.init(named: "white"), for: .normal)
            self.btnPast.setTitleColor(UIColor.init(named: "TGBlack"), for: .normal)
            self.btnUpcoming.backgroundColor = UIColor.init(named: "TGBlack")
            self.btnPast.backgroundColor = UIColor.init(named: "white")
            
        } else {
            self.btnPast.setTitleColor(UIColor.init(named: "white"), for: .normal)
            self.btnUpcoming.setTitleColor(UIColor.init(named: "TGBlack"), for: .normal)
            self.btnPast.backgroundColor = UIColor.init(named: "TGBlack")
            self.btnUpcoming.backgroundColor = UIColor.init(named: "white")
            
        }
    }
    func setFont(){
        self.segmentBgView.addBottomShadow()
        self.lblYear.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblYear.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnUpcoming.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnPast.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblNotSeeingYourtickets.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblNotSeeingYourtickets.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblLearnMore.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblLearnMore.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnFindMyTickets.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnFindMyTickets.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlack)
        
        
        self.lblNoTicket.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblNoTicket.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblLookForSomething.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblLookForSomething.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.btnBrowseEvents.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnBrowseEvents.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.lblStillHavingTrouble.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblStillHavingTrouble.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.btnVisitHelpCenter.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnVisitHelpCenter.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlue)
    }
    
    func setUI () {
        [btnPast,btnUpcoming].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }
}

//MARK: - Actions
extension MyOrderViewController {
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            print("TICKETS")
        case 1:
            let vc = self.createView(storyboard: .order, storyboardID: .SegmentCostumeVC)
            self.segmentControl.selectedSegmentIndex = 0
            self.navigationController?.pushViewController(vc, animated: false)
        default:
            break
        }
        
    }
    
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnUpcoming:
            self.UpcomingAction()
        case btnPast:
            PastAction()
            
        default:
            break
        }
    }
    
    func UpcomingAction() {
        self.isFromUpcoming = true
        self.setButtonBackground()
        self.pastView.isHidden = true
    }
    
    func PastAction() {
        self.isFromUpcoming = false
        self.setButtonBackground()
        self.pastView.isHidden = false
    }
    
}

//MARK: - NavigationBarViewDelegate
extension MyOrderViewController : NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}
