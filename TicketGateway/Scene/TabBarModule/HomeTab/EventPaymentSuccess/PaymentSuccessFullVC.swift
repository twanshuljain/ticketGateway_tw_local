//
// PaymentSuccessFullVC.swift
// TicketGateway
//
// Created by Apple on 16/05/23.
//
import UIKit
class PaymentSuccessFullVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var imgThankYou: UIImageView!
    @IBOutlet weak var lblThankYou: UILabel!
    @IBOutlet weak var lbl1Ticket: UILabel!
    @IBOutlet weak var lblCADPrice: UILabel!
    @IBOutlet weak var lblTicketForOrder: UILabel!
    @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblNoRefundAnytime: UILabel!
    @IBOutlet weak var btnViewMyTicket: CustomButtonNormalWithBorder!
    @IBOutlet weak var btnBrowseMorwEvents: CustomButtonGradiant!
    @IBOutlet weak var btnGoTopMyAccount: CustomButtonNormalWithBorder!
    @IBOutlet weak var lblRefundDescription: UILabel!
    @IBOutlet weak var btnNeedHelp: CustomButtonNormal!
    @IBOutlet weak var navigationView: NavigationBarView!
    //MARK: - Varibales
    var isTransactionFailed: Bool = false
    var createCharge:CreateCharge?
    var selectedArrTicketList = [EventTicket]()
    var selectedCurrencyType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.setUi()
        self.setData()
    }
}
//MARK: - Functions
extension PaymentSuccessFullVC {
    func setUp(){
        self.navigationView.btnBack.isHidden = true
        self.navigationView.imgBack.isHidden = true
        //self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = PAYMENT_SUCCESSFULL
        self.navigationView.vwBorder.isHidden = false
        self.btnBrowseMorwEvents.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnBrowseMorwEvents.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        [self.btnBrowseMorwEvents,self.btnViewMyTicket,btnBrowseMorwEvents,btnGoTopMyAccount,btnNeedHelp].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.btnViewMyTicket.titleLabel?.text = VIEW_MY_TICKETS
        self.btnViewMyTicket.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnViewMyTicket.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnGoTopMyAccount.setTitle(BROWSE_EVENTS, for: .normal)
        self.btnGoTopMyAccount.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnGoTopMyAccount.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnNeedHelp.setTitle(NEED_HELP_CHECK_FAQs, for: .normal)
        self.btnNeedHelp.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnNeedHelp.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnNeedHelp.addRightIcon(image: UIImage(named: RIGHT_BLUE_ICON))
    }
    
    func setData(){
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
        if selectedArrTicketList.count == 0{
            self.lbl1Ticket.text = "Ticket with amount"
        }else if selectedArrTicketList.count == 1{
            self.lbl1Ticket.text = "1 Ticket(S) with amount "
        }else{
            self.lbl1Ticket.text = "\(selectedArrTicketList.count) Ticket(S) with amount"
        }
       
        self.lblCADPrice.text = " \(self.selectedCurrencyType) \(self.createCharge?.amountTotal ?? 0)"
        self.lblTicketForOrder.text = "Transaction Id for Order is #\(self.createCharge?.transactionID ?? "") has been sent to \(userModel?.email ?? "")"
    }
    
    func setUi() {
        if isTransactionFailed {
            lblThankYou.text = "Transaction Failed"
            imgThankYou.image = UIImage(named: "x-circle")
            btnViewMyTicket.isHidden = true
            btnBrowseMorwEvents.setTitle("Retry Payment", for: .normal)
        } else {
            lblThankYou.text = "Thank You!"
           // imgThankYou.image = UIImage(named: "Done_ip")
            btnViewMyTicket.isHidden = false
            btnBrowseMorwEvents.setTitle("Go to my tickets", for: .normal)
        }
        lblThankYou.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFour)
        lblThankYou.textColor = UIColor.setColor(colorType: .tgBlack)
        lbl1Ticket.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        lbl1Ticket.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblCADPrice.font = UIFont.setFont(fontType: .semiBold, fontSize: .fifteen)
        lblCADPrice.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblTicketForOrder.font = UIFont.setFont(fontType: .semiBold, fontSize: .fifteen)
        lblTicketForOrder.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblRefundPolicy.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        lblRefundPolicy.textColor = UIColor.setColor(colorType: .tgBlack)
        lblNoRefundAnytime.font = UIFont.setFont(fontType: .semiBold, fontSize: .fifteen)
        lblNoRefundAnytime.textColor = UIColor.setColor(colorType: .tgBlack)
        lbl1Ticket.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        lbl1Ticket.textColor = UIColor.setColor(colorType: .lblTextPara)
        lblRefundDescription.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
        lblRefundDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
}
//MARK: - Actions
extension PaymentSuccessFullVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnGoTopMyAccount:
            self.btnGoTopMyAccountAction()
        case btnBrowseMorwEvents:
            self.btnBrowseMorwEventsAction()
        case btnNeedHelp:
            self.btnNeedHelpAction()
        case btnViewMyTicket:
            self.btnViewMyTicketAction()
        default:
            break
        }
    }
    func btnGoTopMyAccountAction() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    func btnBrowseMorwEventsAction() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    func btnNeedHelpAction() {
        AppShareData.sharedObject().setRootToHomeVCAndMoveToFAQ()
    }
    func btnViewMyTicketAction() {
        self.tabBarController?.selectedIndex = 1
        self.navigationController?.popToRootViewController(animated: false)
        //self.navigationController?.popToRootViewController(animated: false)
    }
}
////MARK: - NavigationBarViewDelegate
//extension PaymentSuccessFullVC : NavigationBarViewDelegate {
//    func navigationBackAction() {
//        self.navigationController?.popViewController(animated: true)
//    }
//}
