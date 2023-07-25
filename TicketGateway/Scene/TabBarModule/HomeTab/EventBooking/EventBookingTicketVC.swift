//
//  EventDetailBookingTicketVC.swift
//  TicketGateway
//
//  Created by Apple  on 11/05/23.
//

import UIKit
import SVProgressHUD

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
        self.navigationView.delegateBarAction = self
          self.navigationView.lblTitle.text = HEADER_TITLE_SUNBURN
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
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
        self.lblFewTIcketleft.textColor = UIColor.setColor(colorType: .TGBlack)
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
        self.lblRefund.text = "Refund Policy : Refund available \(self.viewModel.eventDetail?.eventRefundPolicy?.policyDescription ?? "")"
        
    }
    
    
    func apiCall(){
        if Reachability.isConnectedToNetwork() //check internet connectivity
        {
            SVProgressHUD.show()
            viewModel.getEventTicketList(complition: { isTrue, messageShowToast in
                if isTrue == true {
                    SVProgressHUD.dismiss()
                    DispatchQueue.main.async {
                        self.tblEventTicketTypes.arrTicketList = self.viewModel.arrTicketList
                         self.tblEventTicketTypes.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.showToast(message: messageShowToast)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
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
       let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketOnApplyCouponVC) as? EventBookingTicketOnApplyCouponVC
   self.navigationController?.pushViewController(view!, animated: true)
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

