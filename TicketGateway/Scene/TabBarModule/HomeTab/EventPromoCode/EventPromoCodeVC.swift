//
//  EventPromoCodeVC.swift
//  TicketGateway
//
//  Created by Apple on 26/07/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name
import UIKit
class EventPromoCodeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var vwApplyPromoCode: UIView!
    @IBOutlet weak var lblPromoCode: UILabel!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var lblApplyPromoCode: UILabel!
    @IBOutlet weak var txtPromoCode: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var promoCodeTableView: TicketTypeListTableView!
    @IBOutlet weak var vwPromoCodeAppliedView: UIView!
    @IBOutlet weak var lblPromoCodeApplied: UILabel!
    @IBOutlet weak var lblPromoCodeAppliedDescription: UILabel!
    // MARK: - Variables
    let isPromoCodeApplied: Bool = true
    var eventDetail:EventDetail?
    var feeStructure:FeeStructure?
    var selectedArrTicketList = [EventTicket]()
    var eventId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setUI()
        self.promoCodeTableView.configure()
    }
}
// MARK: - FUNCTIONS
extension EventPromoCodeVC {
    func setFont() {
        if isPromoCodeApplied {
            vwPromoCodeAppliedView.isHidden = false
            vwApplyPromoCode.isHidden = true
            btnSkip.isHidden = true
        } else  {
            vwPromoCodeAppliedView.isHidden = true
            vwApplyPromoCode.isHidden = false
        }
        
        self.lblPromoCode.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblPromoCode.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblApplyPromoCode.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblApplyPromoCode.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.btnApply.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnApply.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        self.btnSkip.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSkip.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        self.btnContinue.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .seventeen)
        self.btnContinue.titleLabel?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        self.lblPromoCodeApplied.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFour)
        self.lblPromoCodeApplied.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblPromoCodeAppliedDescription.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblPromoCodeAppliedDescription.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
}

// MARK: - Instance Method
extension EventPromoCodeVC {
    func setUI() {
        [self.btnDismiss, self.btnApply, self.btnSkip, self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
    }
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnDismiss:
            self.btnDismissAction()
        case btnApply:
            self.btnApplyAction()
        case btnSkip:
            self.btnSkipAction()
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
    func btnDismissAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func btnApplyAction() {
    }
    func btnSkipAction() {
        let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketAddOnsVC) as? EventBookingTicketAddOnsVC
        view?.viewModel.eventDetail = self.eventDetail
        view?.viewModel.feeStructure = self.feeStructure
        view?.viewModel.selectedArrTicketList = selectedArrTicketList
        view?.viewModel.eventId = self.eventId
        self.navigationController?.pushViewController(view!, animated: true)
    }
    func btnContinueAction() {
        let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketAddOnsVC) as? EventBookingTicketAddOnsVC
        view?.viewModel.eventDetail = self.eventDetail
        view?.viewModel.feeStructure = self.feeStructure
        view?.viewModel.selectedArrTicketList = selectedArrTicketList
        view?.viewModel.eventId = self.eventId
        self.navigationController?.pushViewController(view!, animated: true)
    }
}
