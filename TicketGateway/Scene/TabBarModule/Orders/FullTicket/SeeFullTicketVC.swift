//
//  SeeFullTicketVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 31/05/23.
//

import UIKit

class SeeFullTicketVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var vwTicketDottedLine: UIView!
    @IBOutlet weak var lblTicket: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var vwNameDottedLine: UIView!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblTicketsAndSeats: UILabel!
    @IBOutlet weak var lblGeneralAdmission: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDateValue: UILabel!
    @IBOutlet weak var btnAddToCalender: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnViewMap: UIButton!
    @IBOutlet weak var vwViewMapDottedLine: UIView!
    
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblOrderNumberValue: UILabel!
    @IBOutlet weak var lblEventSummary: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var btnViewEventList: UIButton!
    @IBOutlet weak var lblOrganizer: UILabel!
    @IBOutlet weak var lblOrganizerName: UILabel!
    @IBOutlet weak var btnFollowing: UIButton!
    
    @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblRefundPolicyDays: UILabel!
    @IBOutlet weak var lblPolicyExpired: UILabel!
    @IBOutlet weak var btnGetARefund: UIButton!
    @IBOutlet weak var btnSeeLessView: CustomButtonNormal!
    @IBOutlet weak var btnSaveTicketAsImage: CustomButtonNormal!
    @IBOutlet weak var btnAddAppToWallet: CustomButtonNormal!
    @IBOutlet weak var vwSeeLessDottedLine: UIView!
    
    @IBOutlet weak var vwRefundPolicyDottedLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setNavigationBar()
        self.setUI()
        
    }
}

//MARK: - Functions
extension SeeFullTicketVC{
    func setUI() {
        //      self.btnSeeLessView.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        [self.btnGetARefund,self.btnSeeLessView,self.btnSaveTicketAsImage,self.btnAddAppToWallet,self.btnViewEventList].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        
    }
    
    func setNavigationBar() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = MY_TICKETS
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.vwNavigationView.btnRight.isHidden = false
        self.vwNavigationView.btnRight.setImage(UIImage(named: MENU_DOT_ICON), for: .normal)
        self.vwNavigationView.btnRight.addTarget(self, action: #selector(addActionSheet), for: .touchUpInside)
        
    }
    
    @objc func addActionSheet() {
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Transfer this ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = self.createView(storyboard: .order, storyboardID: .TransferTicketVC)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Exchange ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = self.createView(storyboard: .order, storyboardID: .ExchangeTicketVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Change name on ticket", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = self.createView(storyboard: .order, storyboardID: .ChangeNameVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Share this event", style: UIAlertAction.Style.default, handler: { (action) -> Void in
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Contact organiser", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = self.createView(storyboard: .order, storyboardID: .ContactOrganiserVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
            
        }))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    
    func setFont() {
        let regularLbl = [lblTicket, lblEvent, lblTicketsAndSeats, lblDate, lblLocation, lblOrderNumber, lblEventSummary, lblOrganizer, ]
        for lbl in regularLbl {
            lbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .eighteen)
        self.lblName.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        let mediumLbl = [lblEventName, lblGeneralAdmission, lblDateValue, lblLocationName, lblOrderNumberValue]
        for lbl in mediumLbl {
            lbl?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        }
        
        let btns = [btnAddToCalender, btnViewMap, btnViewEventList, btnGetARefund]
        for btn in btns {
            btn?.titleLabel?.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
            btn?.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlue)
        }
        
        self.lblAddress.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblAddress.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblSummary.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblSummary.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblRefundPolicy.font = UIFont.setFont(fontType: .semiBold, fontSize: .twelve)
        self.lblRefundPolicy.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblRefundPolicyDays.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblRefundPolicyDays.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.btnSeeLessView.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSeeLessView.titleLabel?.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnSeeLessView.addRightIcon(image: UIImage(named: CHEVRON_DOWN_DB_ICON))
        
        self.btnSaveTicketAsImage.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSaveTicketAsImage.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlue)
        self.btnSaveTicketAsImage.addLeftIcon(image: UIImage(named: DOWNLOAD_ICON_ORDER))
        
        self.btnAddAppToWallet.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnAddAppToWallet.titleLabel?.textColor = UIColor.setColor(colorType: .white)
        self.btnAddAppToWallet.addLeftIcon(image: UIImage(named: APPLE_WALLET_ICON))
        
        let dottedLines = [vwNameDottedLine, vwTicketDottedLine, vwSeeLessDottedLine, vwViewMapDottedLine, vwRefundPolicyDottedLine]
        for dottedLine in dottedLines {
            dottedLine?.createDottedLine(width: 2, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [6,6])
        }
        
        self.lblOrganizerName.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblOrganizerName.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.btnFollowing.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnFollowing.titleLabel?.textColor = UIColor.setColor(colorType: .TGBlack)
        
        self.lblPolicyExpired.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        
    }
    
}

//MARK: - Actions
extension SeeFullTicketVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnGetARefund:
            self.btnRefundAction()
        case btnSeeLessView:
            self.seeLessViewAction()
        case btnSaveTicketAsImage:
            break
        case btnAddAppToWallet:
            break
        case btnViewEventList:
            self.viewEventListAction()
        default:
            break
        }
        
    }
    
    func btnRefundAction() {
        let vc = self.createView(storyboard: .order, storyboardID: .RequestRefundVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func seeLessViewAction() {
        let vc = self.createView(storyboard: .order, storyboardID: .MyTicketVC)
        self.navigationController?.popViewController(animated: false)
    }
    
    func saveTicketAsImage() {
        
    }
    
    func addAppToWalletAction() {
        
    }
    
    func viewEventListAction() {
        let vc = self.createView(storyboard: .order, storyboardID: .EventDetailStatusVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - NavigationBarViewDelegate
extension SeeFullTicketVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
    
}
