//
//  EventBookingOrderSummaryVC.swift
//  TicketGateway
//
//  Created by Apple  on 16/05/23.
//

import UIKit

class EventBookingOrderSummaryVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var vwDottedDIscount: UIView!
    @IBOutlet weak var vwDotteds: UIView!
    @IBOutlet weak var vwDotted: UIView!
    @IBOutlet weak var heightOfTickets: NSLayoutConstraint!
    @IBOutlet weak var heightOfAddOn: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblAddedTickets: TicketAddInOrderTableViewList!
    @IBOutlet weak var tblAddOnEtcThings: AddOnAddInOrderTableViewList!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblSubTotalValue: UILabel!
    @IBOutlet weak var lblSavingCharge: UILabel!
    @IBOutlet weak var lblSavingChargeValue: UILabel!
    @IBOutlet weak var lblfacilityFee: UILabel!
    @IBOutlet weak var lblfacilityFeeValue: UILabel!
    @IBOutlet weak var lblProcessingFee: UILabel!
    @IBOutlet weak var lblProcessingFeeValue: UILabel!
    @IBOutlet weak var lblTotalAmt: UILabel!
    @IBOutlet weak var lblTotalAmtValue: UILabel!
    @IBOutlet weak var lblContractOrganiser: UILabel!
   @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblRefundDisc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setUi()
    }
  
}

//MARK: - Functions
extension EventBookingOrderSummaryVC {
    private func setup() {
        self.tblAddedTickets.configure()
        self.tblAddOnEtcThings.configure()
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = "Order Summary"
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.btnBack.isHidden = false
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 15), tintColour: .black)
        [self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.tblAddedTickets.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfTickets.constant = self.tblAddedTickets.contentSize.height
        self.tblAddOnEtcThings.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfAddOn.constant = self.tblAddOnEtcThings.contentSize.height
    }
    
    
    func setUi(){
        [self.lblSubTotal,lblSubTotalValue,self.lblfacilityFee,self.lblfacilityFeeValue,self.lblSavingCharge,self.lblSavingChargeValue,self.lblProcessingFee,self.lblProcessingFeeValue].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
            $0?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        }
        self.lblTotalAmt.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblTotalAmtValue.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.lblRefundPolicy.font = UIFont.setFont(fontType: .semiBold, fontSize: .thirteen)
        self.lblRefundPolicy.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblRefundPolicy.font = UIFont.setFont(fontType: .regular, fontSize: .thirteen)
        self.lblRefundPolicy.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblContractOrganiser.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblContractOrganiser.textColor = UIColor.setColor(colorType: .TGBlue)
        vwDotted.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
        vwDotteds.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
        vwDottedDIscount.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightOfTickets.constant = tblAddedTickets.contentSize.height
        self.heightOfAddOn.constant = tblAddOnEtcThings.contentSize.height
    }
}

//MARK: - Actions
extension EventBookingOrderSummaryVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
       
        default:
            break
        }
    }
   func btnContinueAction() {
       let view = self.createView(storyboard: .home, storyboardID: .EventBookingPaymentMethodVC) as? EventBookingPaymentMethodVC
       self.navigationController?.pushViewController(view!, animated: true)
    }
   
}


//MARK: - NavigationBarViewDelegate
extension EventBookingOrderSummaryVC : NavigationBarViewDelegate {
    func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}
