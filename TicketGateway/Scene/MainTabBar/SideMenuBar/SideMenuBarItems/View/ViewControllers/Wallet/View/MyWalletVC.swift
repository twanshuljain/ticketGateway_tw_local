//
//  MyWalletVC.swift
//  TicketGateway
//
//  Created by Apple  on 08/05/23.
//

import UIKit
import iOSDropDown
import SideMenu

class MyWalletVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var btnAddWalletVC: UIButton!
    
    @IBOutlet weak var txtmonths: DropDown!
    @IBOutlet weak var lblTotalBalance: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblAddAmountInTGWallet: UILabel!
    @IBOutlet weak var lblTRansaction: UILabel!
    @IBOutlet weak var btnDrpoDown: UIButton!
    @IBOutlet weak var tblTransaction: TransactionListTableView!
    @IBOutlet weak var navigationView: NavigationBarView!
    var dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
     }
    
}
// MARK: - Functions
extension MyWalletVC {
    private func setup() {
        self.txtmonths.delegate = self
        [self.btnDrpoDown,self.btnAddWalletVC].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.setUi()
        self.tblTransaction.configure()
        self.tblTransaction.isFrom = "MyWallet"
        self.navigationView.delegateBarAction = self
       
            self.navigationView.lblTitle.text = "My Wallet"
          self.navigationView.btnBack.isHidden = false
          self.navigationView.delegateBarAction = self
        
        self.txtmonths.optionArray = ["Jan", "Feb", "Mar","April"]
        self.navigationView.imgBack.image = UIImage(named: "Menu")
        self.txtmonths.optionIds = [1,23,54,22]
        self.dropDown.didSelect{(selectedText , index ,id) in
        self.txtmonths.text = "\(selectedText)\(index)"
            }
        self.navigationView.vwBorder.isHidden = false
       
    }
    func setUi(){
        self.lblBalance.font = UIFont.setFont(fontType: .medium, fontSize: .twenty)
        self.lblBalance.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTotalBalance.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblTotalBalance.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblAddAmountInTGWallet.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblAddAmountInTGWallet.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTRansaction.font = UIFont.setFont(fontType: .medium, fontSize: .twentyTwo)
        self.lblTRansaction.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
       
      
    }
}
// MARK: - Actions
extension MyWalletVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnDrpoDown:
            btnDrpoDownAction()
        case btnAddWalletVC :
            btnAddAmtWalletAction()
        default:
            break
        }
    }
    
    func btnAddAmtWalletAction(){
        let view = self.createView(storyboard: .wallet, storyboardID: .AddAmountWalletVC) as! AddAmountWalletVC
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func btnDrpoDownAction(){
        self.txtmonths.showList()
    }
}

extension MyWalletVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
  }
}
