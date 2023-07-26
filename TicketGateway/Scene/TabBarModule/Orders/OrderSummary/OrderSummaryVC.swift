//
//  OrderSummaryVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
// swiftlint: disable line_length
import UIKit

class OrderSummaryVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var lblOrderSummary: UILabel!
    @IBOutlet weak var lblTicketDetails: UILabel!
    @IBOutlet weak var lblVIPTickets: UILabel!
    @IBOutlet weak var lblOldTicketPrice: UILabel!
    @IBOutlet weak var lblOldTicketPriceValue: UILabel!
    @IBOutlet weak var vwOldTickeDottedLine: UIView!
    @IBOutlet weak var lblNewTicktePrice: UILabel!
    @IBOutlet weak var lblNewTicketPriceValue: UILabel!
    @IBOutlet weak var lblTaxesFees: UILabel!
    @IBOutlet weak var lblServiceCharge: UILabel!
    @IBOutlet weak var lblServiceChargeValue: UILabel!
    @IBOutlet weak var vwTotalDashedLine: UIView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblTotalAmountValue: UILabel!
    @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblRefundDiscription: UILabel!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setNavigationView()
        self.setUI()
    }
}
// MARK: - Functions
extension OrderSummaryVC {
    func setUI() {
        self.btnContinue.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }
    func setNavigationView() {
        self.vwNavigationView.imgBack.isHidden = true
        self.vwNavigationView.btnRight.isHidden = false
        self.vwNavigationView.btnRight.setImage(UIImage(named: CANCEL_ICON), for: .normal)
        self.vwNavigationView.btnRight.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    func setFont() {
        self.lblOrderSummary.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblOrderSummary.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTicketDetails.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblTicketDetails.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        let lbls = [lblVIPTickets, lblOldTicketPrice, lblOldTicketPriceValue, lblNewTicktePrice, lblNewTicketPriceValue, lblServiceCharge, lblServiceChargeValue]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        self.lblTaxesFees.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblTaxesFees.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblTotalAmount.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblTotalAmount.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblTotalAmountValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblTotalAmountValue.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblRefundPolicy.font = UIFont.setFont(fontType: .semiBold, fontSize: .twelve)
        self.lblRefundPolicy.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblRefundDiscription.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblRefundDiscription.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.vwOldTickeDottedLine.createDottedLine(width: 1, color: UIColor.setColor(colorType: .borderLineColour).cgColor, dashPattern: [3, 5])
        self.vwTotalDashedLine.createDottedLine(width: 1, color: UIColor.setColor(colorType: .borderLineColour).cgColor, dashPattern: [3, 5])
        self.btnContinue.setTitles(text: BUTTON_CONTINUE, font: UIFont.setFont(fontType: .medium, fontSize: .fourteen), tintColour: UIColor.setColor(colorType: .btnDarkBlue))
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
    }
    @objc func buttonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    func btnContinueAction() {
        let eventBookingPaymentMethodVC = self.createView(storyboard: .home, storyboardID: .EventBookingPaymentMethodVC)
        self.navigationController?.pushViewController(eventBookingPaymentMethodVC, animated: false)
    }
}
// MARK: - Actions
extension OrderSummaryVC {
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
}
