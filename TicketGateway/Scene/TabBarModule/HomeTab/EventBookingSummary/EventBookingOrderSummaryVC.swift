//
// EventBookingOrderSummaryVC.swift
// TicketGateway
//
// Created by Apple on 16/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import UIKit
class EventBookingOrderSummaryVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var vwDottedDIscount: UIView!
    @IBOutlet weak var vwDotteds: UIView!
    @IBOutlet weak var vwDotted: UIView!
    @IBOutlet weak var heightOfTickets: NSLayoutConstraint!
    @IBOutlet weak var heightOfAddOn: NSLayoutConstraint!
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblAddedTickets: TicketAddInOrderTableViewList!
    @IBOutlet weak var tblAddOnEtcThings: AddOnAddInOrderTableViewList!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblSubTotalValue: UILabel!
    @IBOutlet weak var lblServiceCharge: UILabel!
    @IBOutlet weak var lblServiceChargeValue: UILabel!
    @IBOutlet weak var lblfacilityFee: UILabel!
    @IBOutlet weak var lblfacilityFeeValue: UILabel!
    @IBOutlet weak var lblProcessingFee: UILabel!
    @IBOutlet weak var lblProcessingFeeValue: UILabel!
    @IBOutlet weak var lblTotalAmt: UILabel!
    @IBOutlet weak var lblTotalAmtValue: UILabel!
    @IBOutlet weak var lblContractOrganiser: UILabel!
    @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblRefundDisc: UILabel!
    @IBOutlet weak var lblDiscouted: UILabel!
    @IBOutlet weak var lblDiscoutedValue: UILabel!
    @IBOutlet weak var discountViewHt : NSLayoutConstraint!

    
    
    var viewModel = EventBookingOrderSummaryVieModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setUi()
        self.setData()
    }
}
//MARK: - Functions
extension EventBookingOrderSummaryVC {
    private func setup() {
        self.tblAddedTickets.configure()
        self.tblAddedTickets.selectedCurrencyType = self.viewModel.selectedCurrencyType
        self.tblAddOnEtcThings.configure()
        self.tblAddOnEtcThings.selectedCurrencyType = self.viewModel.selectedCurrencyType
        self.navigationView.delegateBarAction = self
        self.navigationView.lblTitle.text = ORDER_SUMMARY
        self.navigationView.vwBorder.isHidden = false
        self.navigationView.btnBack.isHidden = false
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.setFont(fontType: .medium, fontSize: .fourteen), tintColour: UIColor.setColor(colorType: .btnDarkBlue))
        btnGoBack.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        btnGoBack.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        [self.btnContinue, self.btnGoBack].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.tblAddedTickets.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfTickets.constant = self.tblAddedTickets.contentSize.height
        self.tblAddOnEtcThings.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.heightOfAddOn.constant = self.tblAddOnEtcThings.contentSize.height
    }
    func setUi(){
        [self.lblSubTotal,lblSubTotalValue,self.lblfacilityFee,self.lblfacilityFeeValue,self.lblServiceCharge,self.lblServiceChargeValue,self.lblProcessingFee,self.lblProcessingFeeValue].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        }
        [self.lblDiscouted,self.lblDiscoutedValue].forEach {
            $0?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            $0?.textColor = UIColor.setColor(colorType: .tgGreen)
        }
        self.lblTotalAmt.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblTotalAmt.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblTotalAmtValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .sixteen)
        self.lblTotalAmtValue.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblRefundPolicy.font = UIFont.setFont(fontType: .semiBold, fontSize: .twelve)
        self.lblRefundPolicy.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblContractOrganiser.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblContractOrganiser.textColor = UIColor.setColor(colorType: .tgBlue)
        self.lblRefundDisc.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblRefundDisc.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblContractOrganiser.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblContractOrganiser.textColor = UIColor.setColor(colorType: .tgBlue)
        vwDotted.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
        vwDotteds.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
        vwDottedDIscount.createDottedLine(width: 1, color: UIColor.lightGray.cgColor, dashPattern: [2,4])
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightOfTickets.constant = tblAddedTickets.contentSize.height
        if self.viewModel.selectedAddOnList.count == 0{
            self.heightOfAddOn.constant = 0
        }else{
            self.heightOfAddOn.constant = tblAddOnEtcThings.contentSize.height
        }
        
    }
    func setData() {
        var serviceCharge =  Double(self.viewModel.feeStructure?.serviceFees?.charge ?? 0)
        var processingCharge = Double((self.viewModel.feeStructure?.processingFees?.charge ?? 0))
        var facilityCharge = Double(self.viewModel.feeStructure?.facilityFees?.charge ?? 0)
        let subTotal = self.viewModel.eventDetail?.event?.eventTicketFinalPrice ?? 0.0
        let discountValue = self.viewModel.eventDetail?.event?.discountValue ?? 0.0
        let discountedFinalPrice = self.viewModel.eventDetail?.event?.discountedFinalPrice ?? 0.0
        
        if self.viewModel.feeStructure?.serviceFees?.chargeType == "PERCENTAGE"{
            serviceCharge = (subTotal / 100) * serviceCharge
        }
        
        if self.viewModel.feeStructure?.processingFees?.chargeType == "PERCENTAGE"{
            processingCharge = (subTotal / 100) * processingCharge
        }
        
        if self.viewModel.feeStructure?.facilityFees?.chargeType == "PERCENTAGE"{
            facilityCharge = (subTotal / 100) * facilityCharge
        }
        
        
        let convertedServiceCharge = self.convertToTwoDecimalPlaces(serviceCharge)
        let convertedProcessingCharge = self.convertToTwoDecimalPlaces(processingCharge)
        let convertedFacilityCharge = self.convertToTwoDecimalPlaces(facilityCharge)
        
        let convertedSubTotal = self.convertToTwoDecimalPlaces(subTotal)
        let convertedDiscountValue = self.convertToTwoDecimalPlaces(discountValue)
        _ = self.convertToTwoDecimalPlaces(discountedFinalPrice)
        
        
        self.lblServiceChargeValue.text = "\(self.viewModel.selectedCurrencyType)\(convertedServiceCharge ?? "")"
        self.lblProcessingFeeValue.text = "\(self.viewModel.selectedCurrencyType)\(convertedProcessingCharge ?? "")"
        self.lblfacilityFeeValue.text = "\(self.viewModel.selectedCurrencyType)\(convertedFacilityCharge ?? "")"
        self.lblSubTotalValue.text = "\(self.viewModel.selectedCurrencyType)\(convertedSubTotal ?? "")"
        var total = 0.0
        
//        if isPercentage{
//            serviceCharge = (serviceCharge / 100) * subTotal
//            processingCharge = (serviceCharge / 100) * subTotal
//            facilityCharge = (facilityCharge / 100) * subTotal
//            discountedFinalPrice = (discountedFinalPrice / 100) * subTotal
//            total = serviceCharge + processingCharge + facilityCharge + discountedFinalPrice
//        }else{
//            total = serviceCharge + processingCharge + facilityCharge + discountedFinalPrice
//        }
        
        if discountValue != 0.0 && self.viewModel.discountType != nil{
            total = serviceCharge + processingCharge + facilityCharge + discountedFinalPrice
            self.lblDiscouted.isHidden = false
            self.lblDiscoutedValue.isHidden = false
            self.discountViewHt.constant = 40
            self.lblDiscoutedValue.text = self.viewModel.discountType == .PERCENTAGE ? "-\(convertedDiscountValue ?? "")%" : "- \(self.viewModel.selectedCurrencyType)\(convertedDiscountValue ?? "")"
        }else{
            total = serviceCharge + processingCharge + facilityCharge + subTotal
            self.lblDiscouted.isHidden = true
            self.lblDiscoutedValue.isHidden = true
            self.discountViewHt.constant = 0
        }
        
        
        
        self.lblTotalAmtValue.text = "\(self.viewModel.selectedCurrencyType)\(convertToTwoDecimalPlaces(total) ?? "")"
        self.viewModel.totalTicketPrice = "\(convertToTwoDecimalPlaces(total) ?? "")"
        self.tblAddedTickets.selectedArrTicketList = self.viewModel.selectedArrTicketList
        self.tblAddOnEtcThings.selectedAddOnList = self.viewModel.selectedAddOnList
        DispatchQueue.main.async {
            self.tblAddedTickets.reloadData()
            self.tblAddOnEtcThings.reloadData()
        }
    }
    
}
//MARK: - Actions
extension EventBookingOrderSummaryVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case btnGoBack:
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
//    func btnContinueAction() {
//     //   if UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin) {
//            if let view = self.createView(storyboard: .main, storyboardID: .PhoneVerificationViewController) as? PhoneVerificationViewController{
//                if UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin) {
//                    view.userType = .new
//                }else{
//                    view.userType = .existing
//                }
//                view.isComingFrom = .OrderSummary
//                view.viewModel.eventId = self.viewModel.eventId
//                view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
//                view.viewModel.eventDetail = self.viewModel.eventDetail
//                view.viewModel.feeStructure = self.viewModel.feeStructure
//                view.viewModel.totalTicketPrice = self.viewModel.totalTicketPrice
//                view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList
//                view.viewModel.selectedCurrencyType = self.viewModel.selectedCurrencyType
//                self.navigationController?.pushViewController(view, animated: true)
//            }
////        }else{
////            if let view = self.createView(storyboard: .home, storyboardID: .EventBookingPaymentMethodVC) as? EventBookingPaymentMethodVC{
////                view.viewModel.eventId = self.viewModel.eventId
////                view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
////                view.viewModel.eventDetail = self.viewModel.eventDetail
////                view.viewModel.feeStructure = self.viewModel.feeStructure
////                view.viewModel.totalTicketPrice = self.viewModel.totalTicketPrice
////                view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList
////                self.navigationController?.pushViewController(view, animated: true)
////            }
////        }
//    }
    //FLOW CHANGE
    func btnContinueAction() {
     //   if UserDefaultManager.share.getUserBoolValue(key: .isGuestLogin) {
            if let view = self.createView(storyboard: .home, storyboardID: .EventCheckoutVerifyVC) as? EventCheckoutVerifyVC{
                view.viewModel.eventId = self.viewModel.eventId
                view.viewModel.selectedArrTicketList = self.viewModel.selectedArrTicketList
                view.viewModel.eventDetail = self.viewModel.eventDetail
                view.viewModel.feeStructure = self.viewModel.feeStructure
                view.viewModel.totalTicketPrice = self.viewModel.totalTicketPrice
                view.viewModel.selectedAddOnList = self.viewModel.selectedAddOnList
                view.viewModel.selectedCurrencyType = self.viewModel.selectedCurrencyType
                view.viewModel.discountType = self.viewModel.discountType
                self.navigationController?.pushViewController(view, animated: true)
            }
    }
}
//MARK: - NavigationBarViewDelegate
extension EventBookingOrderSummaryVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
