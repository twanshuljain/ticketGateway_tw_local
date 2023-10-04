//
//  ManageSellTicketSuccessfully.swift
//  TicketGateway
//
//  Created by Apple  on 23/05/23.
// swiftlint: disable line_length

import UIKit

class ManageSellTicketSuccessfully: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var lblThanku: UILabel!
    @IBOutlet weak var lblComplimentry: UILabel!
    @IBOutlet weak var lblticketDetail: UILabel!
    @IBOutlet weak var btnDone: CustomButtonGradiant!
    @IBOutlet weak var btnShare: CustomButtonNormal!
    @IBOutlet weak var btnDownload: CustomButtonNormal!
    @IBOutlet weak var btnSendAnotherComp: CustomButtonNormal!
    @IBOutlet weak var btnGoToOrder: CustomButtonNormalWithBorder!
    @IBOutlet weak var navigationView: NavigationBarView!
    var strTittle = HEADER_TITLE_SUNBURN
    var strDiscripation = ""
    var strComplimentry = ""
    var strSummary = ""
    var btnStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()

    }
}
// MARK: - Functions
extension ManageSellTicketSuccessfully {
    func setUp() {
        self.navigationView.btnBack.isHidden = false
        self.navigationView.delegateBarAction = self
        if strTittle == HEADER_TITLE_SUNBURN {
            self.navigationView.lblTitle.text = HEADER_TITLE_SUNBURN
            self.navigationView.lblDiscripation.text = HEADER_DESCRIPTION_DATE_TIME
            [self.btnDone, self.btnShare, self.btnDownload, self.btnSendAnotherComp].forEach {
                $0?.isHidden = false
            }
        } else {
            self.navigationView.lblTitle.text = strTittle
            self.navigationView.lblDiscripation.text = strDiscripation
            [self.btnDone, self.btnShare, self.btnDownload, self.btnSendAnotherComp].forEach {
                $0?.isHidden = true
            }
        }
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.vwBorder.isHidden = false
        [self.btnGoToOrder, self.btnDone, self.btnShare, self.btnDownload, self.btnSendAnotherComp].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.lblComplimentry.text = strComplimentry
        self.lblticketDetail.text = strSummary
        self.btnGoToOrder.setTitle(btnStr, for: .normal)
        self.btnGoToOrder.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnGoToOrder.titleLabel?.textColor = UIColor.setColor(colorType: .tgBlue)
        self.btnShare.addLeftIcon(image: UIImage(named: SHARE_ICON))
        self.btnShare.setTitles(text: SHARE, font: UIFont.setFont(fontType: .semiBold, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .lblTextPara))
        self.btnDownload.addLeftIcon(image: UIImage(named: DOWNLOAD_ICON))
        self.btnDownload.setTitles(text: DOWNLOAD, font: UIFont.setFont(fontType: .semiBold, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .lblTextPara))
        self.btnSendAnotherComp.setTitles(text: SEND_ANOTHER_COMP, font: UIFont.setFont(fontType: .semiBold, fontSize: .seventeen), tintColour: UIColor.setColor(colorType: .white), textColour: UIColor.setColor(colorType: .lblTextPara))
        self.btnDone.setTitles(text: DONE, font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        self.lblThanku.font = UIFont.setFont(fontType: .medium, fontSize: .twentyFive)
        self.lblThanku.textColor = UIColor.setColor(colorType: .titleColourDarkBlue)
        self.lblComplimentry.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblComplimentry.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.lblticketDetail.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
        self.lblticketDetail.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
}

// MARK: - Actions
extension ManageSellTicketSuccessfully {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnGoToOrder:
            self.btnGoToOrderAction()
        case btnShare:
            self.btnGoToOrderAction()
        case btnDownload:
            self.btnGoToOrderAction()
        case btnSendAnotherComp:
            self.btnGoToOrderAction()
        case btnDone:
            self.btnGoToOrderAction()
        default:
            break
        }
    }
    func btnGoToOrderAction() {
        //self.showToast(message: AMOUNT_ADDED_SUCCESSFULLY)
        //self.popViewController()
        self.navigationController?.popToRootViewController(animated: true)
    }

    func popViewController() {
        if let navigationController = self.navigationController{
            for controller in navigationController.viewControllers {
                if controller.isKind(of: MyTicketVC.self) {
                    navigationController.popToViewController(controller, animated: true)
                    break
                }
            }
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - NavigationBarViewDelegate
extension ManageSellTicketSuccessfully: NavigationBarViewDelegate {
    func navigationBackAction() {
        //self.popViewController()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
