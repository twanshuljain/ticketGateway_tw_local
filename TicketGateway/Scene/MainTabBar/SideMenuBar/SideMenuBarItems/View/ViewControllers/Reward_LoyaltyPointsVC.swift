//
//  Reward_LoyaltyPointsVC.swift
//  TicketGateway
//
//  Created by Apple  on 02/06/23.
//

import UIKit
import iOSDropDown
import SideMenu

class Reward_LoyaltyPointsVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var collvwCalender: EventCalenderList!
    @IBOutlet weak var tbllatest: RefundListTableView!
    @IBOutlet weak var tblHistory: RefundListTableView!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var lblTotalPoints: UILabel!
    @IBOutlet weak var lblTotalPointsValue: UILabel!
    @IBOutlet weak var lblTotalPointsCalculateValue: UILabel!
    
    @IBOutlet weak var lbllatestetPoint: UILabel!
    @IBOutlet weak var lblHistoryPoint: UILabel!
    @IBOutlet weak var txtmonths: DropDown!
    @IBOutlet weak var btnDrpoDown: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
     }
    
}
// MARK: - Functions
extension Reward_LoyaltyPointsVC {
    private func setup() {
        self.collvwCalender.configure()
        self.navigationView.delegateBarAction = self
        self.tbllatest.configure()
        self.tbllatest.isFrom = "Refunds"
        self.tblHistory.configure()
        self.tblHistory.isFrom = "Refunds"
        self.navigationView.imgBack.image = UIImage(named: "Menu")
          self.navigationView.lblTitle.text = "Rewards & Loyalty Points"
          self.navigationView.btnBack.isHidden = false
          self.navigationView.delegateBarAction = self
          self.navigationView.vwBorder.isHidden = false
        
        self.txtmonths.delegate = self
        [self.btnDrpoDown].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.txtmonths.optionArray = ["Jan", "Feb", "Mar","April"]
        self.navigationView.imgBack.image = UIImage(named: "Menu")
        self.txtmonths.optionIds = [1,23,54,22]
        self.txtmonths.didSelect{(selectedText , index ,id) in
        self.txtmonths.text = "\(selectedText)\(index)"
            }
        self.setUi()
    }
    
    func setUi(){
        self.lblTotalPoints.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblTotalPoints.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTotalPointsValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .twenty)
        self.lblTotalPointsValue.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblTotalPointsCalculateValue.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
        self.lblTotalPointsCalculateValue.textColor = UIColor.setColor(colorType: .lblTextPara)
        [self.lbllatestetPoint,self.lblHistoryPoint].forEach { $0.font = UIFont.setFont(fontType: .medium, fontSize: .twenty)
            $0.textColor = UIColor.setColor(colorType: .TGBlack) }
        
       
      
    }
   
}

// MARK: - Actions
extension Reward_LoyaltyPointsVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnDrpoDown:
            btnDrpoDownAction()
        
        default:
            break
        }
    }
   
    func btnDrpoDownAction(){
        self.txtmonths.showList()
    }
}
// MARK: - Actions
extension Reward_LoyaltyPointsVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
  }
}
