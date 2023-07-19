//
//  SellTicketVC.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
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

class ManageSellTicketVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var vwMore: UIView!
    @IBOutlet weak var lblDiscripation: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var vwBuy: UIView!
    @IBOutlet weak var vwPaymentType: UIView!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblEventTicketTypes: ManageEventSellTicketTableViewList!
    @IBOutlet weak var btnBuy: CustomButtonGradiant!
    @IBOutlet weak var btnCard: CustomButtonNormal!
    @IBOutlet weak var btnCash: CustomButtonNormal!
    @IBOutlet weak var btnViewCart: CustomButtonNormal!
    @IBOutlet weak var btnPromoCode: CustomButtonNormal!
    @IBOutlet weak var btnAddCustomerInfo: CustomButtonNormal!
    @IBOutlet weak var btnComplimentary: CustomButtonNormal!
    @IBOutlet weak var btnCancel: CustomButtonNormal!
    @IBOutlet weak var btnmenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.vwMore.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Functions
extension ManageSellTicketVC {
    func setUp(){
        self.vwMore.isHidden = true
        self.tblEventTicketTypes.isFromSellTab = true
        self.tblEventTicketTypes.configure()
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = HEADER_TITLE_SUNBURN
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
        self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.delegateBarAction = self
        [self.btnBuy,self.btnCard,self.btnCash,self.btnmenu,self.btnViewCart,self.btnPromoCode,self.btnAddCustomerInfo,self.btnComplimentary,self.btnCancel].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.btnBuy.setTitles(text: BUY_NOW, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        self.btnCard.addLeftIcon(image: UIImage(named: CREDIT_CARD_ICON))
        self.btnCard.setTitles(text: CARD, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .white))
        self.btnCard.backgroundColor = UIColor.setColor(colorType: .lightBlack)
        self.btnCash.addLeftIcon(image: UIImage(named: DOLLAR_ICON))
        self.btnCash.setTitles(text: CASH, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .white))
        self.btnCash.backgroundColor = UIColor.setColor(colorType: .lightBlack)
        self.navigationView.imgBack.image = UIImage(named: MENU_ICON)
        self.btnViewCart.setTitles(text: VIEW_CART, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .tgBlue))
        self.btnAddCustomerInfo.setTitles(text: ADD_CUSTOMER_INFO, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .tgBlue))
        self.btnPromoCode.setTitles(text: PROMO_CODE, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .tgBlue))
        self.btnComplimentary.setTitles(text: COMPLIMENTRY, font: UIFont.setFont(fontType: .medium, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .tgBlue))
        self.btnCancel.setTitles(text: CANCEL, font: UIFont.setFont(fontType: .semiBold, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .tgBlue))
      }
}

// MARK: - Actions
extension ManageSellTicketVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnBuy:
            self.btnBuyAction()
        case btnCash:
            self.btnCashAction()
        case btnCard:
            self.btnCardAction()
        case btnmenu:
            self.btnMenuAction()
        case btnViewCart:
            self.btnViewCartAction()
        case btnPromoCode:
            self.btnPromoCodeAction()
        case btnAddCustomerInfo:
            self.btnAddCustomerInfoAction()
        case btnComplimentary:
            self.btnComplimentaryAction()
        case btnCancel:
            self.btnCancelAction()
        default:
            break
        }
    }
    
    func btnCancelAction() {
        self.vwMore.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    func btnComplimentaryAction() {
        let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketComplimentary) as? ManageSellTicketComplimentary
        self.navigationController?.pushViewController(view!, animated: false)
    }
    
    func btnAddCustomerInfoAction() {
        let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellBuyersInfoListVC) as? ManageSellBuyersInfoListVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
    func btnPromoCodeAction() {
        let view = self.createView(storyboard: .manageevent, storyboardID: .PromoCodeVC) as? PromoCodeVC
        self.navigationController?.pushViewController(view!, animated: false)
    }
    
    func btnViewCartAction() {
        
    }
    
    
    func btnCardAction() {
        let view = self.createView(storyboard: .manageevent, storyboardID: .AddCardVC) as? AddCardVC
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
    func btnCashAction() {
        let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
        self.navigationController?.pushViewController(view!, animated: true)
        
    }
    
    func btnBuyAction() {
        self.vwBuy.isHidden = true
        self.vwPaymentType.isHidden = false
    }
    
    func btnMenuAction() {
        self.vwMore.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - NavigationBarViewDelegate
extension ManageSellTicketVC : NavigationBarViewDelegate{
    func navigationBackAction() {
        let sb = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
        
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}
