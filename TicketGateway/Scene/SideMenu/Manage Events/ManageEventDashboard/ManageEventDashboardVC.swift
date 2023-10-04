//
//  ManageEventDashboardVC.swift
//  TicketGateway
//
//  Created by Apple  on 19/05/23.


import UIKit
import SideMenu
import iOSDropDown


class ManageEventDashboardVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblTickets: TicketOverAllEstimateBarTableViewList!
    @IBOutlet weak var lblNetTicketSold: UILabel!
    @IBOutlet weak var lblNetTicketSoldValue: UILabel!
    @IBOutlet weak var lblTotalAddCheck: UILabel!
    @IBOutlet weak var lblTotalAddCheckValue: UILabel!
    @IBOutlet weak var lblAddmissionSold: UILabel!
    @IBOutlet weak var lblAddmissionSoldTotalAvaiable: UILabel!
    @IBOutlet weak var btnSeeMore: CustomButtonNormal!
    @IBOutlet weak var lblTotalTicketSold: UILabel!
    @IBOutlet weak var txtMonths: DropDown!
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setUi()
        
    }
    
    func setup() {
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = HEADER_TITLE_SUNBURN
        self.navigationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
        self.navigationView.btnBack.isHidden = false
        
        self.navigationView.btnRight.isHidden =  false
        self.navigationView.btnRight.setImage(UIImage(named: EVEN_FILTER_ICON), for: .normal)
        self.navigationView.imgBack.image = UIImage(named: MENU_ICON)
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.lblDiscripation.isHidden = false
        self.btnSeeMore.setTitles(text: "See More", font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .tgBlue), textColour: UIColor.setColor(colorType: .tgBlue))
        self.tblTickets.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.tblTickets.configure()
        self.heightOfTableView.constant = self.tblTickets.contentSize.height
        txtMonths.optionArray = ["Jan", "Feb", "Mar","April"]
        txtMonths.delegate = self
        txtMonths.optionIds = [1,23,54,22]
        txtMonths.didSelect{(selectedText , index ,id) in
            self.txtMonths.text = "Selected String: \(selectedText) \n index: \(index)"
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationView.imgBack.image = UIImage(named: BACK_ARROW_ICON)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightOfTableView.constant = tblTickets.contentSize.height
        
    }
    
}

// MARK: - Functions
extension ManageEventDashboardVC{
    func setUi() {
        [self.lblNetTicketSold,self.lblTotalAddCheck].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
            $0?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        
        [self.lblNetTicketSoldValue,self.lblTotalAddCheckValue].forEach {
            $0?.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFive)
            $0?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        
        [self.lblAddmissionSold].forEach {
            $0?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
            $0?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        
        [self.lblTotalTicketSold].forEach {
            $0?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
            $0?.textColor = UIColor.setColor(colorType: .tgBlack)
        }
        
        
        [self.lblAddmissionSoldTotalAvaiable,].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
            $0?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        
    }
}

// MARK: - Actions
extension ManageEventDashboardVC{
    @IBAction func btnSeeMoreTickets(_ sender: Any) {
        let view = self.createView(storyboard: .manageevent, storyboardID: .ManageEventTicketSoldVC) as? ManageEventTicketSoldVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
    @IBAction func btnMonths(_ sender: Any) {
        self.txtMonths.showList()
    }
}

// MARK: - NavigationBarViewDelegate
extension ManageEventDashboardVC : NavigationBarViewDelegate{
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
  }
}
// MARK: - UITextFieldDelegate
extension ManageEventDashboardVC : UITextFieldDelegate{
}
