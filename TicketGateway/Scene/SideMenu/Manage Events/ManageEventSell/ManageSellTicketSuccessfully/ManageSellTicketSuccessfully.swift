//
//  ManageSellTicketSuccessfully.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
//

import UIKit

class ManageSellTicketSuccessfully: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var lblThanku: UILabel!
    @IBOutlet weak var lblComplimentry: UILabel!
    @IBOutlet weak var lblticketDetail: UILabel!
    @IBOutlet weak var btnDone: CustomButtonGradiant!
    @IBOutlet weak var btnShare: CustomButtonNormal!
    @IBOutlet weak var btnDownload: CustomButtonNormal!
    @IBOutlet weak var btnSendAnotherComp: CustomButtonNormal!
    @IBOutlet weak var btnGoToOrder: CustomButtonNormalWithBorder!
    @IBOutlet weak var navigationView: NavigationBarView!
    
    var strTittle = "Sunburn reload NYE - toronto"
    var strDiscripation = ""
    var strComplimentry = ""
    var strSummary = ""
    var btnStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()

        // Do any additional setup after loading the view.
    }
}

// MARK: - Functions
extension ManageSellTicketSuccessfully {
    func setUp(){
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        if strTittle == "Sunburn reload NYE - toronto" {
            self.navigationView.lblTitle.text = "Sunburn reload NYE - toronto"
            self.navigationView.lblDiscripation.text = "Wed, Dec 7, 2023  at 05:00 PM"
            [self.btnDone,self.btnShare,self.btnDownload,self.btnSendAnotherComp].forEach {
                $0?.isHidden = false
            }
            
        }else {
            self.navigationView.lblTitle.text = strTittle
            self.navigationView.lblDiscripation.text = strDiscripation
            [self.btnDone,self.btnShare,self.btnDownload,self.btnSendAnotherComp].forEach {
                $0?.isHidden = true
            }
        }
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        
        [self.btnGoToOrder,self.btnDone,self.btnShare,self.btnDownload,self.btnSendAnotherComp].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        
        self.lblComplimentry.text = strComplimentry
        self.lblticketDetail.text = strSummary
        //   self.btnGoToOrder.titleLabel?.text = btnStr
        self.btnGoToOrder.setTitle(btnStr, for: .normal)
        
        btnGoToOrder.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnGoToOrder.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlue)
        
        //        btnGoToOrder.setTitles(text: "Go To Order", textColour: UIColor.setColor(colorType: .TGBlue), borderColour: UIColor.setColor(colorType: .PlaceHolder))
        self.btnShare.addLeftIcon(image: UIImage(named: SHARE_ICON))
        self.btnShare.setTitles(text: "Share", font: UIFont.setFont(fontType: .semiBold, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .lblTextPara))
        self.btnDownload.addLeftIcon(image: UIImage(named: "download"))
        self.btnDownload.setTitles(text: "Download", font: UIFont.setFont(fontType: .semiBold, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .lblTextPara))
        self.btnSendAnotherComp.setTitles(text: "Send another comp", font: UIFont.setFont(fontType: .semiBold, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .lblTextPara))
        self.btnDone.setTitles(text: "Done", font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        
        
        
        lblThanku.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFive)
        lblThanku.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        lblComplimentry.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        lblComplimentry.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        
        
        lblticketDetail.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        lblticketDetail.textColor = UIColor.setColor(colorType: .lblTextPara)
        
    }
}

// MARK: - Actions
extension ManageSellTicketSuccessfully {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnGoToOrder:
            self.btnGoToOrderAction()
        case btnShare:
            self.btnGoToOrderAction()
        case btnDownload:
            self.btnGoToOrderAction()
        case btnSendAnotherComp:
            self.btnGoToOrderAction()
        case btnDone:
            self.btnGoToOrderAction()
        default:
            break
        }
    }
    func btnGoToOrderAction() {
        self.showToast(message: "Amount added Successfully")
    }
    
   }

// MARK: - NavigationBarViewDelegate
extension ManageSellTicketSuccessfully : NavigationBarViewDelegate {
    func navigationBackAction() {
        
    self.navigationController?.popViewController(animated: true)
  }
}
