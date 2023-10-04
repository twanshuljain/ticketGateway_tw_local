//
//  ManageEventOrderDeatilVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 06/06/23.
//

import UIKit

class ManageEventOrderDeatilVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblorderNo: UILabel!
    @IBOutlet weak var lblOrderNoValue: UILabel!
    @IBOutlet weak var lblSale: UILabel!
    @IBOutlet weak var lblSaleValue: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDateValue: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTimeValue: UILabel!
    @IBOutlet weak var lblDeliveryMethode: UILabel!
    @IBOutlet weak var lblDeliveryMethodeValue: UILabel!
    @IBOutlet weak var btnRefund: CustomButtonNormal!
    @IBOutlet weak var btnPrint: CustomButtonNormal!
    @IBOutlet weak var btnMessage: CustomButtonNormal!
    @IBOutlet weak var lblTickets: UILabel!
    @IBOutlet weak var lbl1xGeneralAdmission: UILabel!
    @IBOutlet weak var lbl1xGeneralAdmissionValue: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTotalValue: UILabel!
    @IBOutlet weak var lblComplementry: UILabel!
    @IBOutlet weak var lblComplementryValue: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var txtNotes: UITextView!
    @IBOutlet weak var lblAttendee: UILabel!
    @IBOutlet weak var lblDavideTaylor: UILabel!
    @IBOutlet weak var lblGeneralAddmission: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setNavigationView()
        self.setUI()

    }
}

//MARK: - Functions
extension ManageEventOrderDeatilVC {
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = "Order Details"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)

    }
    
    func setFont() {
        self.lblorderNo.text = ORDER_NO
        self.lblSale.text = SALE
        self.lblDate.text = DATE
        self.lblTime.text = TIME
        self.lblDeliveryMethode.text = DELIVERY_METHOD
        self.lblTickets.text = TICKETS
        self.lbl1xGeneralAdmission.text = GENRAL_ADMISSION
        self.lblTotal.text = TOTAL
        self.lblComplementry.text = COMPLIMENTRY
        self.lblNotes.text = NOTES
        lblAttendee.text = ATTEENDE
        
        self.lblName.font = UIFont.setFont(fontType: .semiBold, fontSize: .eighteen)
        self.lblName.textColor = UIColor.setColor(colorType: .tgBlack)
       
        let regularLbls = [lblEmail, lblorderNo, lblSale, lblDate, lblTime, lblDeliveryMethode, lbl1xGeneralAdmission, lblTotal, lblComplementry]
        for lbl in regularLbls {
            lbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
       
        self.lblOrderNoValue.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblOrderNoValue.textColor = UIColor.setColor(colorType: .tgBlue)
        
        let valueLbls = [lblSaleValue, lblDateValue, lblTimeValue, lblDeliveryMethodeValue]
        for valueLbl in valueLbls {
            valueLbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            valueLbl?.textColor = UIColor.setColor(colorType: .tgBlack)
        }
        
        self.btnRefund.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnRefund.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlack)
        self.btnRefund.addLeftIcon(image: UIImage(named: REFUND_ICON))
        
        let lbls = [lblTickets, lblAttendee, lblGeneralAddmission]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
        
        let lblValues = [lbl1xGeneralAdmissionValue, lblTotalValue, lblComplementryValue]
        for valueLbl in lblValues {
            valueLbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            valueLbl?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        
        self.lblNotes.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblNotes.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblDavideTaylor.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblDavideTaylor.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
    }
}

//MARK: - Actions
extension ManageEventOrderDeatilVC {
    func setUI () {
        [btnRefund,btnPrint,btnMessage].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        }
    }

    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnRefund:
            self.refundAction()
        case btnPrint:
            self.printAction()
        case btnMessage:
            self.messageAction()
        default:
            break
        }
    }

    func refundAction() {
        let vc = createView(storyboard: .manageventorder, storyboardID: .RefundOptionsVC)
        self.navigationController?.pushViewController(vc, animated: true)

    }

    func printAction() {
        

    }
    
    func messageAction() {
       
    }

}

// MARK: - NavigationBarViewDelegate
extension ManageEventOrderDeatilVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
  
}
