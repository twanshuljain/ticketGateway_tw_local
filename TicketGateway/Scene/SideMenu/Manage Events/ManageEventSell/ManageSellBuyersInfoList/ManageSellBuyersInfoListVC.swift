//
//  ManageSellBuyersInfoListVC.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
//

import UIKit

class ManageSellBuyersInfoListVC: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblBuyerInfo: BuyersInfoTableViewList!
    @IBOutlet weak var btnAdd: CustomButtonGradiant!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view.
    }
}
// MARK: - Functions
extension ManageSellBuyersInfoListVC {
    func setUp() {
          self.tblBuyerInfo.configure()
        self.tblBuyerInfo.tableDidSelectAtIndex = { intval in
            let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellAddBuyerVC) as? ManageSellAddBuyerVC
            view?.viewModel.isFromAddInfo = false
            view?.viewModel.toupleBuyerInfoData.strNameValue = "Rebecca young"
            view?.viewModel.toupleBuyerInfoData.strEmailValue = "rebecca.young@yahoo.com"
            view?.viewModel.toupleBuyerInfoData.strNumberValue = "+91 9876 543210"
            view?.viewModel.toupleBuyerInfoData.strCountryCodeValue = "fbfdfdgffggfhg"
            view?.viewModel.toupleBuyerInfoData.strDialCodeValue = "jhjh"
           self.navigationController?.pushViewController(view!, animated: true)
        }
        self.tblBuyerInfo.tableDidSelectAtIndexEdit = { intval in
            let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellAddBuyerVC) as? ManageSellAddBuyerVC
            view?.viewModel.isFromAddInfo = false
            view?.viewModel.toupleBuyerInfoData.strNameValue = "Rebecca young"
            view?.viewModel.toupleBuyerInfoData.strEmailValue = "rebecca.young@yahoo.com"
            view?.viewModel.toupleBuyerInfoData.strNumberValue = "+91 9876 543210"
            view?.viewModel.toupleBuyerInfoData.strCountryCodeValue = "fbfdfdgffggfhg"
            view?.viewModel.toupleBuyerInfoData.strDialCodeValue = "jhjh"
           self.navigationController?.pushViewController(view!, animated: true)
        }
          self.navigationView.delegateBarAction = self
          self.navigationView.lblTitle.text = BUYESR_INFO
          self.navigationView.lblDiscripation.isHidden = false
          self.navigationView.lblSeprator.isHidden = false
          self.navigationView.btnBack.isHidden = false
          self.navigationView.vwBorder.isHidden = false
          self.navigationView.delegateBarAction = self
          [self.btnAdd].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
          }
        self.btnAdd.setTitles(text: ADD_MORE_BUYER, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        self.btnAdd.addLeftIcon(image: UIImage(named: PLUS_ICON))
    }
}

// MARK: - Actions
extension ManageSellBuyersInfoListVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnAdd:
            self.btnAddMoreAction()
         default:
            break
        }
    }
   func btnAddMoreAction() {
       let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellAddBuyerVC) as? ManageSellAddBuyerVC
       view?.viewModel.isFromAddInfo = true
      self.navigationController?.pushViewController(view!, animated: true)
    }
}

// MARK: - NavigationBarViewDelegate
extension ManageSellBuyersInfoListVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - UITextFieldDelegate
extension ManageSellBuyersInfoListVC: UITextFieldDelegate {
}
