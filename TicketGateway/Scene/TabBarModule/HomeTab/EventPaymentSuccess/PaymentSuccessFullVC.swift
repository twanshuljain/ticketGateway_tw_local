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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.setUi()
    }
}
//MARK: - Functions
extension PaymentSuccessFullVC {
    func setUp(){
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = PAYMENT_SUCCESSFULL
        self.navigationView.vwBorder.isHidden = false
        self.btnBrowseMorwEvents.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnBrowseMorwEvents.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        [self.btnBrowseMorwEvents,self.btnViewMyTicket,btnBrowseMorwEvents,btnGoTopMyAccount].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.btnViewMyTicket.titleLabel?.text = VIEW_MY_TICKETS
        self.btnViewMyTicket.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnViewMyTicket.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnGoTopMyAccount.titleLabel?.text = GO_TO_MY_ACCOUNT
        self.btnGoTopMyAccount.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnGoTopMyAccount.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnNeedHelp.titleLabel?.text = NEED_HELP_CONTACT_US
        self.btnNeedHelp.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnNeedHelp.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnNeedHelp.addRightIcon(image: UIImage(named: RIGHT_BLUE_ICON))
    }
    func setUi() {
        if isTransactionFailed {
            lblThankYou.text = "Transaction Failed"
            imgThankYou.image = UIImage(named: "x-circle")
            btnViewMyTicket.isHidden = true
            btnBrowseMorwEvents.setTitle("Retry Payment", for: .normal)
        } else {
            lblThankYou.text = "Thank You!"
            imgThankYou.image = UIImage(named: "Done_ip")
            btnViewMyTicket.isHidden = false
            btnBrowseMorwEvents.setTitle("Browse more events", for: .normal)
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
    func btnGoTopMyAccountAction() {}
    func btnBrowseMorwEventsAction() {}
    func btnNeedHelpAction() {}
    func btnViewMyTicketAction() {
    }
}
//MARK: - NavigationBarViewDelegate
extension PaymentSuccessFullVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
