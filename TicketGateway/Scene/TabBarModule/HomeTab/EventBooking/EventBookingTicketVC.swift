//
//  EventDetailBookingTicketVC.swift
//  TicketGateway
//
//  Created by Apple  on 11/05/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count

import UIKit
import SVProgressHUD
import iOSDropDown

class EventBookingTicketVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var lblRefund: UILabel!
    @IBOutlet weak var btnCheckTermCondition: UIButton!
    @IBOutlet weak var lblAcceptedTermCon: UILabel!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblEventTicketTypes: TicketTypeListTableView!
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var lblFewTIcketleft: UILabel!
    @IBOutlet weak var lblClickingonCOntinue: UILabel!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTotalTicketPrice :DropDown!
    @IBOutlet weak var parentView: UIView!
    
    //MARK: - Variables
    var isCheckedTerm_COndition = false
    var viewModel = EventBookingTicketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setData()
        self.apiCall()
        // Do any additional setup after loading the view.
    }

}

//MARK: - Functions
extension EventBookingTicketVC {
    private func setup() {
        self.isCheckedTerm_COndition = false
        self.setUi()
        self.tblEventTicketTypes.configure()
        self.tblEventTicketTypes.selectedArrTicketList = self.viewModel.selectedArrTicketList
        self.tblEventTicketTypes.updatedPrice = { price in
            self.lblTotalTicketPrice.text = "CA$ \(price)"
        }
        self.navigationView.delegateBarAction = self
          self.navigationView.lblTitle.text = ""
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.lblDiscripation.text = ""
          self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
          self.navigationView.delegateBarAction = self
        self.tblEventTicketTypes.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.btnCheckTermCondition.setImage(UIImage(named: IMAGE_UNACTIVE_TERM_ICON), for: .normal)
        self.tblHeight.constant = self.tblEventTicketTypes.contentSize.height
        [self.btnContinue,self.btnCheckTermCondition].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
     }
    func setUi(){
        self.lblAcceptedTermCon.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFewTIcketleft.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFewTIcketleft.textColor = UIColor.setColor(colorType: .tgBlack)
        self.lblRefund.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblRefund.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblClickingonCOntinue.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        
        self.btnContinue.addRightIcon(image: UIImage(named: RIGHT_ARROW_ICON))
        self.btnContinue.setTitles(text: TITLE_CONTINUE, font: UIFont.boldSystemFont(ofSize: 17), tintColour: UIColor.setColor(colorType: .btnDarkBlue))
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblHeight.constant = tblEventTicketTypes.contentSize.height
        
   }
    
    func setData(){
        self.navigationView.lblTitle.text = (viewModel.eventDetail?.event?.title ?? "") + " - " + (self.viewModel.eventDetail?.eventLocation?.eventCountry ?? "")
        
        let dateTime = "\(viewModel.eventDetail?.eventDateObj?.eventStartDate?.getDateFormattedFrom() ?? "")" + " • " + "\(viewModel.eventDetail?.eventDateObj?.eventStartTime?.getFormattedTime() ?? "")"
        self.navigationView.lblDiscripation.text = dateTime
        
        self.lblRefund.text = "Refund Policy : Refund available \(self.viewModel.eventDetail?.eventRefundPolicy?.policyDescription ?? "")"
        
    }
    func apiCall(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            self.viewModel.dispatchGroup.enter()
            viewModel.getEventTicketList(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    DispatchQueue.main.async {
                        self.tblEventTicketTypes.arrTicketList = self.viewModel.arrTicketList
                         self.tblEventTicketTypes.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.parentView.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
        
        self.viewModel.dispatchGroup.notify(queue: .main) {
            self.apiCallForFeeStructure()
        }
    }
    
    func apiCallForFeeStructure() {
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            parentView.showLoading(centreToView: self.view)
            viewModel.getEventTicketFeeStructure(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    self.parentView.stopLoading()
                    print(self.viewModel.feeStructure)
                } else {
                    DispatchQueue.main.async {
                        self.parentView.stopLoading()
                        self.showToast(message: messageShowToast)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                self.parentView.stopLoading()
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
    }
}

//MARK: - Actions
extension EventBookingTicketVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case  btnCheckTermCondition :
            self.btnCheckTermConditionAction()
        default:
            break
        }
    }
    
    func btnCheckTermConditionAction(){
        if isCheckedTerm_COndition == false
        {
            isCheckedTerm_COndition = true
            self.btnCheckTermCondition.setImage(UIImage(named: IMAGE_ACTIVE_TERM_ICON), for: .normal)
        }
        else {
            isCheckedTerm_COndition = false
            self.btnCheckTermCondition.setImage(UIImage(named: IMAGE_UNACTIVE_TERM_ICON), for: .normal)
        }
        
    }
    
   func btnContinueAction() {
       if let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketOnApplyCouponVC) as? EventBookingTicketOnApplyCouponVC{
           view.viewModel.totalTicketPrice = self.lblTotalTicketPrice.text ?? ""
           view.viewModel.feeStructure = self.viewModel.feeStructure
           self.navigationController?.pushViewController(view, animated: true)
       }
    }
}

// MARK: - NavigationBarViewDelegate
extension EventBookingTicketVC : NavigationBarViewDelegate {
    func navigationBackAction() {
//        if let view = self.createView(storyboard: .home, storyboardID: .EventDetailVC) as? EventDetailVC {
//            view.viewModel.selectedArrTicketList = self.tblEventTicketTypes.selectedArrTicketList
//            self.navigationController?.popToViewController(view, animated: false)
//        }

        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: EventDetailVC.self) {
                (controller as! EventDetailVC).viewModel.selectedArrTicketList = self.tblEventTicketTypes.selectedArrTicketList
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }

      // self.navigationController?.popViewController(animated: true)
  }
}

